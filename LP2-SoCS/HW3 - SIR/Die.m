function agents = Die(agents, mu)
infected = agents(:,3) == -1;
index=(rand(size(agents,1),1)<mu) & infected;
agents(index,:)=[];
end