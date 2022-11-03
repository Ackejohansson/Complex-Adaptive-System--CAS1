function particles = GenerateParticles(N,n,x)
    particles = zeros(N,n);
    for i =1:N
        for j = 1:n
            particles(i,j) = x(1) + rand*(x(end)-x(1));
        end
    end
end