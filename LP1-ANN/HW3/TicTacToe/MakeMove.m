function [boardState, updatePosition] = MakeMove(epsilon, boardState, Q, player)
positions = find(0 == boardState);


    


if rand < epsilon
    if length(positions) == 1
        updatePosition = positions;
    else
        updatePosition = randsample(positions,1); 
    end
%%%%%%%%% NOT DONE, works for epsilon = 1 %%%%%%%%%%%%%
else
    [~, Row] = ismember(boardState,Q(:,1:9),'rows');
    updatePosition = max(Q(row, 10:18))
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if player == 1
        boardState(updatePosition) = 1;
elseif player == 2
        boardState(updatePosition) = -1;
else
    error('Player has to be ether 1 or 2.')
end
end