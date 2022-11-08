function [winner, scoreP1, scoreP2] = CheckWinner(boardState, scoreP1, scoreP2)
boardState = reshape(boardState, 3, 3)';
list = [sum(boardState,1), sum(boardState,2)', trace(boardState), trace(flip(boardState))];

if ismember(3,list)
    winner = 1;
    scoreP1 = scoreP1 +1;
    disp('Player 1 won!')
    
elseif ismember(-3,list)
    winner = 2;
    scoreP2 = scoreP2 +1;
    disp('Player 2 won!')  
    
elseif isempty(find(boardState == 0))
    winner = -1;
    disp('Tie!')
    
else
    winner = 0;
end
end