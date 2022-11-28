function agents = Die(agents, mu)
[index,~] = find(agents(:,3) == -1);
for i = 1:length(index)
   if rand < mu
       agents(index(i),:) = [];
       index=index-1;
   end
end