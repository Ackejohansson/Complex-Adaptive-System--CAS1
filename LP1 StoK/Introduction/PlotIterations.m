% This method should plot the polynomial and the iterates obtained
% using NewtonRaphsonStep (if any iterates were generated).

function PlotIterations(polynomialCoefficients, iterationValues)
fplot(@(x)  GetPolynomialValue(x, polynomialCoefficients));

hold on
plot(iterationValues, GetPolynomialValue(iterationValues, polynomialCoefficients),'o')
hold off
end



