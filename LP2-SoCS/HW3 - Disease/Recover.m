function agents = Recover(agents,gamma)
    infected = agents(:,3) == -1;
    index=(rand(size(agents,1),1)<gamma) & infected;
    agents(index,3)=1;
end