function agents = Move(agents,d,L)
for i=1:length(agents)
    if rand < d
        switch randi(4)
            case 1
                agents(i,1:2) = agents(i,1:2)+[1,0];
            case 2
                agents(i,1:2) = agents(i,1:2)+[0,1];
            case 3
                agents(i,1:2) = agents(i,1:2)+[-1,0];
            case 4
                agents(i,1:2) = agents(i,1:2)+[0,-1];
            otherwise
                error("Move out of bounce")
        end
    end
end
tmpAgents = agents(:,1:2);
tmpAgents(tmpAgents>L) = tmpAgents(tmpAgents>L)-L;
tmpAgents(tmpAgents<0) = tmpAgents(tmpAgents<0)+L;
agents = [tmpAgents, agents(:,3)];
end