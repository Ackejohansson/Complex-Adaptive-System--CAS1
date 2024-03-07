% This function should return the gradient of f_p = f + penalty.
% You may hard-code the gradient required for this specific problem.
function gradF = ComputeGradient(x,mu)
grad1Uncon = 2*(x(1)-1);
grad2Uncon = 4*(x(2)-2);
pTerm1 = 4*mu*x(1)*(x(1)^2 +x(2)^2-1);
pTerm2 = 4*mu*x(2)*(x(1)^2 +x(2)^2-1);

if x(1)^2 + x(2)^2 -1 <= 0
   gradF = [grad1Uncon,grad2Uncon]; 
else
   gradF = [grad1Uncon + pTerm1, grad2Uncon + pTerm2];  
end
end