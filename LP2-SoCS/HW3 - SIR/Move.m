function agents = Move(agents,movementProb,L)
move = randsample(["right","up","left","down"],length(agents),true);
move(rand(length(agents),1) > movementProb) = 0;

agents(move == "right",1) = agents(move == "right",1) +1;
agents(move == "up",2)    = agents(move == "up",2)    +1;
agents(move == "left",1)  = agents(move == "left",1)  -1;
agents(move == "down",2)  = agents(move == "down",2)  -1;

tmpAgents = agents(:,1:2);
tmpAgents(tmpAgents>L) = tmpAgents(tmpAgents>L)-L;
tmpAgents(tmpAgents<0) = tmpAgents(tmpAgents<0)+L;
agents(:,1:2) = tmpAgents;
end