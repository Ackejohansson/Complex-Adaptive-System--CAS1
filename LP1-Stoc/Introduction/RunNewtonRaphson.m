% This function should run the Newton-Raphson method, making use of the
% other relevant functions (StepNewtonRaphson, DifferentiatePolynomial, and
% GetPolynomialValue). Before returning iterationValues any non-plottable values 
% (e.g. NaN) that can occur if the method fails (e.g. if the input is a
% first-order polynomial) should be removed, so that only values that
% CAN be plotted are returned. Thus, in some cases (again, the case of
% a first-order polynomial is an example) there may be no points to plot.

function iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance)

tempX = zeros;
tempX = [tempX, startingPoint];

while abs(tempX(end) - tempX(end-1)) >= tolerance
    
    fPrimeCoeff = DifferentiatePolynomial(polynomialCoefficients, 1);
    fPrime = GetPolynomialValue(tempX(end) ,fPrimeCoeff);
    
    fDoublePrimeCoeff = DifferentiatePolynomial(polynomialCoefficients, 2);
    fDoublePrime = GetPolynomialValue(tempX(end),fDoublePrimeCoeff);
    
    tempX =[tempX, StepNewtonRaphson( tempX(end), fPrime, fDoublePrime)];
end
iterationValues = tempX(2:end);
