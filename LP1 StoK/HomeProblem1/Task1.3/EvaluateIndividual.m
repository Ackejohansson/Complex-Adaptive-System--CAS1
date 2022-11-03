function fitness = EvaluateIndividual(x)
sq1 = ( 1.5-x(1)+x(1)*x(2) )^2;
sq2 = ( 2.25-x(1)+x(1)*x(2)^2 )^2;
sq3 = ( 2.625-x(1)+x(1)*x(2)^3 )^2;

g = sq1 + sq2 + sq3;
fitness = 1/(g+1);
end 
