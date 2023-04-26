import numpy as np
import random
import math
import h5py
import matplotlib.pyplot as plt
import tensorflow as tf
import copy

# This file provides the skeleton structure for the classes TQAgent and TDQNAgent to be completed by you, the student.
# Locations starting with # TO BE COMPLETED BY STUDENT indicates missing code that should be written by you.

class TQAgent:
    # Agent for learning to play tetris using Q-learning
    def __init__(self,alpha,epsilon,episode_count):
        # Initialize training parameters
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
        # TO BE COMPLETED BY STUDENT
        # Here you can load the Q-table (to Q-table of self) from the input parameter strategy_file (used to test how the agent plays)


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
                saveEpisodes=[1000,2000,5000,10000,20000,50000,100000,200000,500000,1000000];
                if self.episode in saveEpisodes:
                    pass
                    # np.save()
                    # TO BE COMPLETED BY STUDENT
                    # Here you can save the rewards and the Q-table to data files for plotting of the rewards and the Q-table can be used to test how the agent plays
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
    def __init__(self):
        super(DeepQNetwork, self).__init__()
        self.lin1 = nn.Linear(20, 64, dtype=torch.float64)
        self.lin2 = nn.Linear(64, 64, dtype=torch.float64)
        self.lin3 = nn.Linear(64, 16, dtype=torch.float64)
        
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
        self.reward_tots = np.zeros(self.episode_count)

    def fn_init(self,gameboard):
        self.gameboard=gameboard
        self.dqn_action = DeepQNetwork()
        self.dqn_target = DeepQNetwork()
        self.actions = []
        self.reward_tots = np.zeros(self.episode_count)
        self.exp_buffer = []
        self.optimizer = torch.optim.Adam(self.dqn_action.parameters(), lr=self.alpha)
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
        # TODO might give wrong type out
        if np.random.rand() < max(self.epsilon, 1-self.episode/self.epsilon_scale):
            self.action_index = np.random.choice(16)
        else:
            self.action_index = self.dqn_action(self.state).argmax()#.item()

        position_drop = self.action_index % self.gameboard.N_col
        number_of_rotation = self.action_index // self.gameboard.N_col
        self.gameboard.fn_move(position_drop, number_of_rotation)


    def fn_reinforce(self,batch):
        old_state, last_action, reward, state, terminal  = batch
        self.dqn_action.train()
        self.dqn_target.eval() # hat
        q_target = self.dqn_target(state)
        q_action = self.dqn_action(old_state)

        
        target = reward + (terminal == 0) * (torch.max(q_target, dim=-1).values)
        q = q_action[range(self.batch_size), last_action]

        self.loss = self.criterion(q, target)
        self.optimizer.zero_grad()
        self.loss.backward()
        self.optimizer.step()
        

    def fn_turn(self):
        if self.gameboard.gameover:
            self.episode+=1
            if self.episode%100==0:
                print('episode '+str(self.episode)+'/'+str(self.episode_count)+' (reward: ',str(np.sum(self.reward_tots[range(self.episode-100,self.episode)])),')')
            if self.episode%1000==0:
                saveEpisodes=[1000,2000,5000,10000,20000,50000,100000,200000,500000,1000000];
                if self.episode in saveEpisodes:
                    pass
                    # TO BE COMPLETED BY STUDENT
                    # Here you can save the rewards and the Q-network to data files
            if self.episode>=self.episode_count:
                raise SystemExit(0)
            else:
                if (len(self.exp_buffer) >= self.replay_buffer_size) and ((self.episode % self.sync_target_episode_count)==0):
                    self.dqn_target = copy.deepcopy(self.dqn_action)
                    # TO BE COMPLETED BY STUDENT
                    # Here you should write line(s) to copy the current network to the target network
                self.gameboard.fn_restart()
        else:
            self.fn_select_action()
            self.old_state = torch.clone(self.state)
            reward=self.gameboard.fn_drop()
            self.reward_tots[self.episode] += reward
            self.fn_read_state()

            # TO BE COMPLETED BY STUDENT
            # Here you should write line(s) to store the state in the experience replay buffer
            self.exp_buffer.append((self.old_state, self.action_index, reward, torch.clone(self.state), self.gameboard.gameover))
            if len(self.exp_buffer) >= self.replay_buffer_size:
                batch = random.sample(self.exp_buffer, self.batch_size)
                self.fn_reinforce(batch)
                if len(self.exp_buffer) >= self.replay_buffer_size+1:
                    self.exp_buffer.pop(0)


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