% This function should run gradient descent until the L2 norm of the
% gradient falls below the specified threshold.
function x = RunGradientDescent(xStart, mu, eta, gradientTolerance)
xNext = xStart;    
gradF = ComputeGradient(xStart, mu);
while norm(gradF) > gradientTolerance
    gradF = ComputeGradient(xNext, mu);
    xNext = xNext - eta * gradF;
end
x = xNext;
end