function velocity = GenerateVelocity(alpha, deltat, x, N, n)
    velocity = zeros(N,n);
    for i = 1:N
        for j = 1:n
            velocity(i,j) = alpha/deltat * (rand*(x(end)-x(1))-(x(end)-x(1))/2);
        end
    end
end