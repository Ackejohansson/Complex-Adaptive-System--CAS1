function agents = FromRtoS(agents, alpha)
[index,~] = find(agents(:,3) == 1);
for i = 1:length(index)
   if rand < alpha
       agents(index(i),:) = 0;
   end
end