function population = GenerateInitialConfiguration(N,L)
    x = rand(N,1)*L;
    y = rand(N,1)*L;
    theta = rand(N,1)*2*pi;
    population = [x,y,theta];
end