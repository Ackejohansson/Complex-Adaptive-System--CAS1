function agents = Recover(agents,gamma)
    infected = agents(:,3) == -1;
    recovered=(rand(size(agents,1),1)<gamma) & infected;
    agents(recovered,3)=1;
end