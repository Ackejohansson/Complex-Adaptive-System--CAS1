function [D,DqOfq] = FitPolynomial(Iq, epsilon,Q)
D = zeros(10,2);
D(1,:) = polyfit(log(1./epsilon),log(Iq(1,:)),1);
D(2,:) = polyfit(log(1./epsilon),Iq(2,:),1);
D(3,:) = polyfit(log(1./epsilon),-log(Iq(3,:)),1);

for i = 1:7
    D(i+3,:) = polyfit(log(1./epsilon), log(Iq(i+3,:))/(1-Q(i+3)),1);
end
DqOfq = polyfit(Q,D(:,1)',1);
end