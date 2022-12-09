%% PSO 
clc, clf, clear all;

% Plot
hold on
x = linspace(-5,5);
y = linspace(-5,5);
[X,Y] = meshgrid(x,y);
a = 0.01;
F =log(a+(X.^2+Y-11).^2 + (X+Y.^2-7).^2);
contour(X,Y,F)

% Settings
nParticles = 30;
vMax = 20;
nTrials = 100;
c1 = 2;
c2 = 2;
alpha = 1;
deltat = 1;
beta = 0.95;

% Constants
x = -5:5;
y = -5:5;
nDim = 2;
totalMin = zeros(nTrials,3);


for k = 1:nTrials
    % Initialize
    PB = Inf(nParticles,1);
    SB = inf;
    bestParticlePos = zeros(nParticles,nDim);
    w = 1.4;
    
    % Step 1 - Initialize particles and velocities
    particles = GenerateParticles(nParticles,nDim,x);
    velocity = GenerateVelocity(alpha, deltat, x, nParticles, nDim);

    for i = 1:10000
        % Step 2 - Evaluate
        F = EvaluateParticles(particles);

        %Step 3 - Update best positions
        [bestParticlePos, PB, indexSB, SB] = UpdatePositions(F, nParticles, PB, particles, bestParticlePos);

        % Step 4 - Update vel and pos
        if 0.3 < w
            w = w*beta;
        end
        velocity = UpdateVelocity(c1,c2,bestParticlePos,particles,indexSB,deltat, velocity, vMax, w);
        particles = particles + deltat*velocity;
    end
    totalMin(k,:) = [bestParticlePos(indexSB,:) SB];
end
bestMin = uniquetol(totalMin, 1, 'ByRows', true);
disp("The minimas of the function is (x,y,f(x,y)):")
disp(bestMin)

% Plot
axis([x(1) x(end) y(1) y(end)])
title(("Contour plot for $\ln{(0.01 + f(x,y))}$"),'interpreter','latex')
plot(bestMin(:,1),bestMin(:,2),'+','Color','red')
legend('$\ln{(0.01 + f(x,y))}$','$(x^*,y^*)$','interpreter','latex','Location','northeast')
xlabel('x')
ylabel('y')
hold off