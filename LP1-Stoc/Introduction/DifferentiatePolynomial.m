% This method should return the coefficients of the k-th derivative (defined by
% the derivativeOrder) of the polynomial given by the polynomialCoefficients (see also GetPolynomialValue)

function derivativeCoefficients = DifferentiatePolynomial(polynomialCoefficients, derivativeOrder)
derivativeCoefficients = zeros; 
    for i = derivativeOrder+1:length(polynomialCoefficients)
        derivativeCoefficients(1,i-derivativeOrder) = polynomialCoefficients(i) * (factorial(i-1)/factorial(i-derivativeOrder-1));
    end
end
