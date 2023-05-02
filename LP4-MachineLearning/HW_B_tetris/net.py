class TDQNAgent:
    def __init__(self,alpha,epsilon,epsilon_scale,replay_buffer_size,batch_size,sync_target_episode_count,episode_count):
        self.alpha=alpha
        self.epsilon=epsilon
        self.epsilon_scale=epsilon_scale
        self.replay_buffer_size=replay_buffer_size
        self.batch_size=batch_size
        self.sync_target_episode_count=sync_target_episode_count
        self.episode=0
        self.episode_count=episode_count

    def fn_init(self,gameboard):
        self.gameboard=gameboard
        self.dqn_action = DeepQNetwork(hidden_channels= 64)
        self.dqn_target = DeepQNetwork(hidden_channels= 64)
        self.reward_tots = np.zeros(self.episode_count)
        self.actions = []
        self.exp_buffer = []
        self.optimizer = torch.optim.Adam(self.dqn_action.parameters(), lr=self.alpha*2)
        self.criterion = torch.nn.MSELoss()
        # 'self.episode_count' the total number of episodes in the training
        # 'self.replay_buffer_size' the number of quadruplets stored in the experience replay buffer


    def fn_load_strategy(self,strategy_file):
        pass
        # TO BE COMPLETED BY STUDENT
        # Here you can load the Q-network (to Q-network of self) from the strategy_file

    def fn_read_state(self):
        self.state = self.gameboard.board.flatten()
        tile = -np.ones(len(self.gameboard.tiles))
        tile[self.gameboard.cur_tile_type] = 1
        self.state = torch.tensor(np.append(self.state, tile))


    def fn_select_action(self):
        if np.random.rand() < max(self.epsilon, 1-self.episode/self.epsilon_scale):
            self.action_index = np.random.choice(16)
        else:
            self.action_index = self.dqn_action(self.state).argmax().item()

        position_drop = self.action_index % self.gameboard.N_col
        number_of_rotation = self.action_index // self.gameboard.N_col
        self.gameboard.fn_move(position_drop, number_of_rotation)


    def fn_reinforce(self,batch):
        self.dqn_action.train()
        self.dqn_target.eval() # hat
        out = []
        label = []

        for old_state, last_action, reward, state, gameover in batch:
            target = reward
            if not gameover:
                target += self.dqn_target(state).max().item()
            
            out.append(self.dqn_action(old_state)[last_action])
            label.append(torch.tensor(target, dtype=torch.float64))
        

        self.loss = self.criterion(torch.stack(out), torch.stack(label))
        self.optimizer.zero_grad()
        self.loss.backward()
        self.optimizer.step()
        self.dqn_action.eval()


    def fn_turn(self):
        if self.gameboard.gameover:
            self.episode+=1
            if self.episode%100==0:
                print('episode '+str(self.episode)+'/'+str(self.episode_count)+' (reward: ',str(np.sum(self.reward_tots[range(self.episode-100,self.episode)])),')')
            if self.episode%1000==0:
                saveEpisodes=[1000,2000,5000,10000,20000,50000,100000,200000,500000,1000000]
                if self.episode in saveEpisodes:
                    pass
                    # TO BE COMPLETED BY STUDENT
                    # Here you can save the rewards and the Q-network to data files
            if self.episode>=self.episode_count:
                raise SystemExit(0)
            else:
                if (len(self.exp_buffer) >= self.replay_buffer_size) and ((self.episode % self.sync_target_episode_count)==0):
                    self.dqn_target = copy.deepcopy(self.dqn_action)
                    self.dqn_target.requires_grad_(False)
                self.gameboard.fn_restart()
        else:
            self.fn_select_action()
            self.old_state = torch.clone(self.state)
            reward=self.gameboard.fn_drop()
            self.reward_tots[self.episode] += reward
            self.fn_read_state()
            self.exp_buffer.append((self.old_state, self.action_index, reward, torch.clone(self.state), self.gameboard.gameover))
            
            if len(self.exp_buffer) >= self.replay_buffer_size:
                batch = random.sample(self.exp_buffer, self.batch_size)
                self.fn_reinforce(batch)
                if len(self.exp_buffer) >= self.replay_buffer_size + 2:
                    self.exp_buffer.pop(0)