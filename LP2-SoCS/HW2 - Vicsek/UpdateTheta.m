function population = UpdateTheta(population,N,R,eta,dt,M)
x=population(:,1);
y=population(:,2);
theta=population(:,3);
newTheta = zeros(N,1);

for j = 1:N
    distances = sqrt((M(:,1)-x(j,1)).^2 + (M(:,2)-y(j,1)).^2);
    inRadius = distances < R;
    inRadius = sum(reshape(inRadius, N,9),2);
    inRadius = logical(inRadius);
    newTheta(j) = angle(sum(exp(theta(inRadius)*1i)));
end
population(:,3) = newTheta + eta*(rand(N,1)-1/2)*dt;
end