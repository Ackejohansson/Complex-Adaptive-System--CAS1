function population = UpdateThetaNearest(population,N,R,eta,dt,M,k)
x=population(:,1);
y=population(:,2);
theta=population(:,3);
newTheta = zeros(N,1);

for j = 1:N
    distances = [sqrt( (M(:,1)-x(j,1)).^2 + (M(:,2)-y(j,1)).^2), repmat(theta, 9,1)];
    distances = sortrows(distances);
    index = distances(1:k+1,1) < R; 
    
    newTheta(j) = angle(sum(exp(distances(index,2)*1i)))+ eta*(rand - 1/2)*dt;
end
population(:,3) = newTheta;
end

