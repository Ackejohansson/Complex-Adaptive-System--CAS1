function population = UpdateTheta(population,N,R,eta,dt)
x=population(:,1);
y=population(:,2);
theta=population(:,3);
newTheta = zeros(N,1);

for j = 1:N
    distances = sqrt( (x-x(j)).^2 + (y-y(j)).^2);
    inRadius = distances < R;
    a = sum(cos(theta(inRadius)));
    b = sum(sin(theta(inRadius)));
    W = rand - 1/2;
    newTheta(j) = atan(a/b) + eta*W*dt;
end

population(:,3) = newTheta;
end