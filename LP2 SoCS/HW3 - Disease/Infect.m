function agents = Infect(agents,beta)
index = agents(:,3) == -1;
infected = agents(index,1:2);
for i = 1:size(infected,1)
    [indx,~] = find(ismember(agents(:,1:2),infected(i,:),'rows'));
    for k=1:length(indx)
       if agents(indx(k),3) == 0
           if rand < beta
            agents(indx(k),3) = -1;
           end
       end
    end
end
end