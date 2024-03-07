function Q = AddState(boardState, Q)
if ~ismember(boardState,Q(:,1:9),'rows')
    Q(end+1,1:9) = boardState; 
    tmpBoard = boardState;
    tmpBoard(tmpBoard~=0)=NaN;
    Q(end,10:18) = tmpBoard;
end
end   