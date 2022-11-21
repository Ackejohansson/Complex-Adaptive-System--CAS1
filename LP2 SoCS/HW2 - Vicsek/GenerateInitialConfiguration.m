function population = GenerateInitialConfiguration(N,L)
    x = rand(N,1)*L;
    y = rand(N,1)*L;
    theta = pi*(2*rand(N,1)-1);
    population = [x,y,theta];
end