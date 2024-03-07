function agents = Infect(agents,beta)
infected = agents(agents(:,3) == -1, 1:2);

for i = 1:size(infected,1)
    [samePosition,~] = find(ismember(agents(:,1:2),infected(i,:),'rows'));
    suceptable = agents(samePosition,3) == 0;
    index=(rand(size(samePosition,1),1)<beta) & suceptable;
    agents(samePosition(index),3) = -1;
end

%%% Work in progress, trying to remove find(ismember(...))
%
% infectedVector = agents(:,3) == -1;
% infectedPos = agents(infectedVector, 1:2);
% 
% for i = 1:size(infectedPos,1)
%    samePos = sum(infectedPos(i,:)==infectedPos, 2) == 2
% end
% 
% sick = agents(infected,1:2);
% samePos = sum(sick(i,:) == agents(:,1:2), 2) ==2;
end

