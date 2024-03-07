%% TicTacToe
clc, clear
% Settings
nGames = 100000;
epsFactor = 0.99;

% Initialize
epsilon = 1;
gamma = 1;
alpha = 0.1;
Q1 = zeros(1,18);
Q2 = [];
score = zeros(1,3);
totalScore = [];


for games = 1:nGames    
    winner = false;    
    boardState = zeros(1,9);
    [boardState, newP1Pos] = MakeMove(epsilon, boardState, Q1, 1);
    Q2 = AddState(boardState, Q2);
    
    [boardState, newP2Pos] = MakeMove(epsilon, boardState, Q2, 2);
    Q1 = AddState(boardState, Q1);
    Q1 = UpdateQ(Q1,boardState,alpha,newP1Pos);

    while ~winner
        [boardState, newP1Pos] = MakeMove(epsilon, boardState, Q1, 1);
        [winner, scoreP1, scoreP2] = CheckWinner(boardState, scoreP1, scoreP2);
        
        if ~winner;break;   end          

        Q2 = AddState(boardState, Q2);
        Q2 = UpdateQ(Q2,boardState,alpha,newP1Pos);
        
        [boardState, newP2Pos] = MakeMove(epsilon, boardState, Q2, 2);
        [winner, scoreP1, scoreP2] = CheckWinner(boardState, scoreP1, scoreP2);
        
        if ~winner;break;   end
        
        Q1 = AddState(boardState, Q1);
        Q1 = UpdateQ(Q1,boardState,alpha,newP1Pos);
    end
    if mod(games,100) == 0
    epsilon = epsilon*epsFactor;
    totalScore(games/100,:) = score;
    score=zeros(1,3);
    end
end
    

%%
x = 1:100:100000;
plot(x,totalScore(:,1).','r')
hold on
plot(x,totalScore(:,2).','b')
plot(x,totalScore(:,3).','g')
legend('Probability of player 1 win', 'Probability of player 1 win', 'Probability of tie')
title('The win distribution over 100 000 games')



