function agents = Move(agents,d,L)
move = (rand(length(agents),1) < d).*randi(4,length(agents),1);

agents(move == 1,1) = agents(move == 1,1) +1;
agents(move == 2,2) = agents(move == 2,2) +1;
agents(move == 3,1) = agents(move == 3,1) -1;
agents(move == 4,2) = agents(move == 4,2) -1;

tmpAgents = agents(:,1:2);
tmpAgents(tmpAgents>L) = tmpAgents(tmpAgents>L)-L;
tmpAgents(tmpAgents<0) = tmpAgents(tmpAgents<0)+L;
agents(:,1:2) = tmpAgents;
end