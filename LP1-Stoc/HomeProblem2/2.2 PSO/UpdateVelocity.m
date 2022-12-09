function velocity = UpdateVelocity(c1,c2,bestParticlePos,particles,indexSB,deltat, velocity, vMax, w)
    velocity = velocity*w + c1*rand*(( bestParticlePos-particles )/deltat + c2*rand*(indexSB - particles)/deltat);
    
    velocity(velocity >= vMax) = vMax;
    velocity(velocity <= -vMax) = -vMax;
end