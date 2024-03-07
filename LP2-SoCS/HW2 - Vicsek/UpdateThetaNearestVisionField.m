function population = UpdateThetaNearestVisionField(population,N,R,eta,dt,M)
x=population(:,1);
y=population(:,2);
theta=population(:,3);
newTheta = zeros(N,1);
ang = pi/5;

for j = 1:N
    distances = [sqrt( (M(:,1)-x(j,1)).^2 + (M(:,2)-y(j,1)).^2), repmat(theta, 9,1)];
    distances = sortrows(distances);
    index = distances(:,1) < R; %distances(1:k+1,1)
    index = logical(sum(reshape(index,N,9),2));
    
    for n=1:sum(index)
        Arg = atan(M(index(n),2)-y(j,1)/M(index(n),1)-x(j,1));
        if theta(n)-ang < Arg && theta(n)+ang > Arg
            index(n) = 1;
        else
            index(n) = 0;
        end
    end
    newTheta(j) = angle(sum(exp(distances(index,2)*1i)))+ eta*(rand - 1/2)*dt;
end
population(:,3) = newTheta;
end