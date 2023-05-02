import numpy as np
import random
import math
import h5py
import matplotlib.pyplot as plt
import tensorflow as tf
import copy
import time
import pickle 


class TQAgent:
    def __init__(self,alpha,epsilon,episode_count):
        self.alpha=alpha
        self.epsilon=epsilon
        self.episode=0
        self.episode_count=episode_count

    def fn_init(self,gameboard):
        self.gameboard=gameboard
        self.set_possible_actions()
        self.qtable = {}
        self.reward_tots = np.zeros(self.episode_count)

    def set_possible_actions(self):
        possible_actions = np.zeros((len(self.gameboard.tiles), self.gameboard.N_col*4))
        for i, tile in enumerate(self.gameboard.tiles):
            for j, rotation in enumerate(tile):
                possible_actions[i][j*self.gameboard.N_col:j*self.gameboard.N_col+self.gameboard.N_col+1-len(rotation)] = 1
        self.possible_actions = possible_actions

    def fn_load_strategy(self,strategy_file):
        # np.load
        pass

    def fn_read_state(self):
        self.state = np.reshape(self.gameboard.board, (1, self.gameboard.N_row*self.gameboard.N_col))
        self.state = tuple(np.append(self.state, self.gameboard.cur_tile_type))
        if self.state not in self.qtable:
            self.qtable[self.state] = np.zeros(int(sum(self.possible_actions[self.gameboard.cur_tile_type])))

    def fn_select_action(self):
        index_possible_actions = np.argwhere(self.possible_actions[self.gameboard.cur_tile_type] == 1).flatten()
        if np.random.rand() < self.epsilon:
            self.action_index = np.random.choice(index_possible_actions.size)
        else:
            self.action_index = np.argmax(self.qtable[self.state])
        
        action_index = index_possible_actions[self.action_index]
        position_drop = action_index % self.gameboard.N_col
        number_of_rotation = action_index // self.gameboard.N_col
        self.gameboard.fn_move(position_drop, number_of_rotation)
        

    def fn_reinforce(self,old_state,reward):
        self.qtable[old_state][self.action_index] += self.alpha*(reward + np.max(self.qtable[self.state]) - self.qtable[old_state][self.action_index])

    def fn_turn(self):
        if self.gameboard.gameover:
            self.episode+=1
            if self.episode%100==0:
                print('episode '+str(self.episode)+'/'+str(self.episode_count)+' (reward: ',str(np.sum(self.reward_tots[range(self.episode-100,self.episode)])),')')
            if self.episode%1000==0:
                saveEpisodes=[1000,2000,5000,10000,20000,50000,100000,200000,500000,1000000]
                if self.episode in saveEpisodes:
                    # TODO
                    # np.savez
                    pass
            if self.episode>=self.episode_count:
                plt.plot(self.reward_tots)
                plt.show()
                raise SystemExit(0)
            else:
                self.gameboard.fn_restart()
        else:
            self.fn_select_action()
            old_state = self.state

            reward=self.gameboard.fn_drop()
            self.reward_tots[self.episode] += reward

            self.fn_read_state()
            self.fn_reinforce(old_state,reward)


#######################################################################################################################################################
#######################################################################################################################################################
#######################################################################################################################################################
#######################################################################################################################################################

import torch
import torch.nn.functional as F
import torch.nn as nn

class DeepQNetwork(torch.nn.Module):
    def __init__(self, hidden_channels):
        super(DeepQNetwork, self).__init__()
        torch.manual_seed(12345)
        self.lin1 = nn.Linear(20, hidden_channels, dtype=torch.float64)
        self.lin2 = nn.Linear(hidden_channels, hidden_channels, dtype=torch.float64)
        self.lin3 = nn.Linear(hidden_channels, 16, dtype=torch.float64)
        
    def forward(self, x):
        x = F.relu(self.lin1(x))
        x = F.relu(self.lin2(x))
        x = self.lin3(x)

        return x


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
        self.reward_tots=[0]*episode_count

    def fn_init(self,gameboard):
        self.gameboard=gameboard
        self.actions = [7, 6, 12, 3] # pillar, slash, L, square
        self.dqn_action = DeepQNetwork(hidden_channels= 64)
        self.dqn_target = DeepQNetwork(hidden_channels= 64)
        self.exp_buffer = []
        self.criterion = nn.MSELoss()
        self.optimizer = torch.optim.Adam(self.dqn_action.parameters(), lr=self.alpha)


    def fn_load_strategy(self,strategy_file):
        self.dqn_action.load_state_dict(torch.load(strategy_file))


    def fn_read_state(self):
        self.state = self.gameboard.board.flatten()
        tile_type = -np.ones(len(self.gameboard.tiles))
        tile_type[self.gameboard.cur_tile_type] = 1
        self.state = np.append(self.state, tile_type) # concatenate the state with the tile type


    def fn_select_action(self):
        self.dqn_action.eval()
        out = self.dqn_action(torch.tensor(self.state)).detach().numpy()
        if np.random.rand() < max(self.epsilon, 1-self.episode/self.epsilon_scale): # epsilon-greedy
            self.action = np.random.choice(16)
        else: 
            self.action = np.argmax(out)
                
        drop_position = self.action % self.gameboard.N_col
        number_of_rotations = self.action // self.gameboard.N_col
        self.gameboard.fn_move(drop_position, number_of_rotations)


    def fn_reinforce(self,batch):
        targets = []
        action_value = []
        self.dqn_action.train()
        self.dqn_target.eval()

        for state, action, reward, next_state, terminal in batch:
            target = reward
            if not terminal:
                # TODO Change here
                #with torch.no_grad():
                #self.dqn_target(torch.tensor(next_state)).max()
                target += max(self.dqn_target(torch.tensor(next_state)).detach().numpy())
            targets.append(torch.tensor(target, dtype=torch.float64))
            out = self.dqn_action(torch.tensor(state))
            action_value.append(out[action])

        targets = torch.stack(targets)
        action_value = torch.stack(action_value)
        loss = self.criterion(action_value, targets)
        self.optimizer.zero_grad()
        loss.backward()
        self.optimizer.step()
    """
    def fn_reinforce(self, batch):
    self.dqn_action.train()
    self.dqn_target.eval()

    targets = []
    action_values = []
    for state, action, reward, next_state, terminal in batch:
        target = reward
        if not terminal:
            with torch.no_grad():
                max_next_action_value = self.dqn_target(torch.tensor(next_state)).max()
                target += max_next_action_value
        targets.append(target)
        
        action_value = self.dqn_action(torch.tensor(state))[action]
        action_values.append(action_value)

    targets = torch.stack(targets, dtype=torch.float64)
    action_values = torch.stack(action_values)

    loss = self.criterion(action_values, targets)
    self.optimizer.zero_grad()
    loss.backward()
    self.optimizer.step()
    """


    def fn_turn(self):
        if self.gameboard.gameover:
            self.episode+=1
            if self.episode%100==0:
                print('episode '+str(self.episode)+'/'+str(self.episode_count)+' (reward: ',str(np.mean(self.reward_tots[self.episode-100:self.episode])),')')
            if self.episode%1000==0:
                saveEpisodes=[1000,2000,5000,10000,20000,50000,100000,200000,500000,1000000];
                if self.episode in saveEpisodes:
                    torch.save(self.dqn_action.state_dict(), 'dqn_action_'+str(self.episode)+'.pth')
                    torch.save(self.dqn_target.state_dict(), 'dqn_target_'+str(self.episode)+'.pth')
                    pickle.dump(self.reward_tots, open('reward_tots_'+str(self.episode)+'.p', 'wb'))
            if self.episode>=self.episode_count:
                raise SystemExit(0)
            else:
                if (len(self.exp_buffer) >= self.replay_buffer_size) and ((self.episode % self.sync_target_episode_count)==0):
                    pass
                    # TODO Dont pass
                    self.dqn_target = copy.deepcopy(self.dqn_action)
                self.gameboard.fn_restart()
        else:
            self.fn_select_action()
            old_state = self.state.copy()
            reward=self.gameboard.fn_drop()
            self.reward_tots[self.episode] += reward
            self.fn_read_state()
            self.exp_buffer.append((old_state, self.action, reward, self.state.copy(), self.gameboard.gameover))

            if len(self.exp_buffer) >= self.replay_buffer_size:
                batch = random.sample(self.exp_buffer, self.batch_size)
                self.fn_reinforce(batch)
                # TODO + 1
                if len(self.exp_buffer) >= self.replay_buffer_size + 2:
                    self.exp_buffer.pop(0) # Remove the oldest transition from the buffer


class THumanAgent:
    def fn_init(self,gameboard):
        self.episode=0
        self.reward_tots=[0]
        self.gameboard=gameboard

    def fn_read_state(self):
        pass

    def fn_turn(self,pygame):
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                raise SystemExit(0)
            if event.type==pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    self.reward_tots=[0]
                    self.gameboard.fn_restart()
                if not self.gameboard.gameover:
                    if event.key == pygame.K_UP:
                        self.gameboard.fn_move(self.gameboard.tile_x,(self.gameboard.tile_orientation+1)%len(self.gameboard.tiles[self.gameboard.cur_tile_type]))
                    if event.key == pygame.K_LEFT:
                        self.gameboard.fn_move(self.gameboard.tile_x-1,self.gameboard.tile_orientation)
                    if event.key == pygame.K_RIGHT:
                        self.gameboard.fn_move(self.gameboard.tile_x+1,self.gameboard.tile_orientation)
                    if (event.key == pygame.K_DOWN) or (event.key == pygame.K_SPACE):
                        self.reward_tots[self.episode]+=self.gameboard.fn_drop()