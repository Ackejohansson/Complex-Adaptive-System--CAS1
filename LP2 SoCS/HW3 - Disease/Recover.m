function agents = Recover(agents,gamma)
I = agents(:,3) == -1;
for i=1:length(agents)
    if I(i)==1
        if rand < gamma
            agents(i,3) = 1;
        end
    end
end
end