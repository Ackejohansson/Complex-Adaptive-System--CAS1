function [bestParticlePos, PB, indexSB, SB] = UpdatePositions(F, N, PB, particles, bestParticlePos)
    for i = 1:N
        if F(i) < PB(i)
            PB(i) = F(i);
            bestParticlePos(i,:) = particles(i,:);
        end
    end
    [SB, indexSB] = min(PB);
end