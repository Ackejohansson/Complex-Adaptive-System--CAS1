function F = EvaluateParticles(particles)
    x = particles(:,1);
    y = particles(:,2);
    F = (x.^2+y-11).^2 + (x+y.^2-7).^2;
end