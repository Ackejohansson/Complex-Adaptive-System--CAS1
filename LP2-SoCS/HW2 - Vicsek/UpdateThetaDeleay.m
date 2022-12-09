function population = UpdateThetaDeleay(population,N,R,eta,dt,h,t,T)
x=population(:,1);
y=population(:,2);
theta=population(:,3);
avgTheta = zeros(N,T);

for j = 1:N
    distances = sqrt( (x-x(j)).^2 + (y-y(j)).^2);
    inRadius = distances < R;
    a = sum(cos(theta(inRadius)));
    b = sum(sin(theta(inRadius)));
    W = rand - 1/2;
    avgTheta(j,t) = atan2(b, a) + eta*W*dt;
end
population(:,3) = avgTheta;
end