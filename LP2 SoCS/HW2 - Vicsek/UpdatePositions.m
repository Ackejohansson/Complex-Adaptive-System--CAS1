function population = UpdatePositions(population,L,v,dt)
theta=population(:,3);
population = population(:,1:2) + [cos(theta),sin(theta)]*v*dt;
population(population > L) = 0;
population(population < 0) = L;

population = [population,theta];
end