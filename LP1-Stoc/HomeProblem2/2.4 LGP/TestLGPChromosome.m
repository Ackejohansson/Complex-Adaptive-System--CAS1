%% TestLGPChromosome.m
clf, clc
constants = [-1, 3, 1];
nVariables = 7;

[~, bestChromo] = BestChromosome;
[fitness, yapproxGenerated] = EvaluateIndividual(bestChromo,nVariables,constants);
f = LoadFunctionData;

% Plot exact data with estimated
hold on
title('The exact and approximated y-data for $x\in[-5,5]$' , 'interpreter','latex')
xlabel('x')
ylabel('y')
plot(f(:,1),f(:,2),"--.", 'Color', [0 0.9 0])
plot(f(:,1),yapproxGenerated, "-.", 'Color', 'blue')
legend('Exact y-values','Estimated y-values', 'Location','SouthEast')
hold off

% Get function as in eq 8: g(x)
syms x
registers = [x zeros(1, nVariables-1) constants];
g = simplify(DecodeChromosome(bestChromo, registers))