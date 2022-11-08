function Q = UpdateQ(boardState, Q, movePos, winner, oldBoard, alpha, gamma)
[~, newRow] = ismember(boardState,Q(:,1:9),'rows');
[~, oldRow] = ismember(oldBoard,Q(:,1:9),'rows');

R = 0;
if winner > 0
    R = 1;
end
disp(oldRow)
Q(oldRow,9+movePos) = Q(oldRow,9+movePos) + alpha*(R + gamma * max(Q(newRow,10:18)) - Q(oldRow,9+movePos));

end