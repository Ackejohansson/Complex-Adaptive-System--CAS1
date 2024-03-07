function tau = ComputePheromoneLevels(simplifiedPath,tau,rho,Q,pathLength)
deltaTau = zeros(size(tau,1));
for i = 1:size(simplifiedPath,1)
    path = nonzeros(simplifiedPath(i,:))';
    for j=1:size(path,2)-1
        deltaTau(path(j),path(j+1)) = deltaTau(path(j),path(j+1)) + Q./pathLength(i);
        deltaTau(path(j+1),path(j)) = deltaTau(path(j+1),path(j)) + Q./pathLength(i);
    end
end
tau(tau<1e-4) = 0;
tau = tau*(1-rho)+ deltaTau;
end