function [population,averageTheta] = UpdateThetaNegative(population,eta,dt,N,R,h,t,s,averageTheta,M)
x=population(:,1);
y=population(:,2);
theta=population(:,3);
newTheta = zeros(N,1);

for j = 1:N
    distances = sqrt( (M(:,1)-x(j,1)).^2 + (M(:,2)-y(j,1)).^2);
    inRadius = distances < R;
    inRadius = sum(reshape(inRadius, N,9),2);
    inRadius = logical(inRadius);
    
    newTheta(j) = angle(sum(exp(theta(inRadius)*1i)));
end
averageTheta(:,t) = newTheta;

if (h>0 && t-h<=0) || (h<0 && t-s<1)
    population(:,3)=population(:,3);
    return;
elseif h<0 && t-s>0
    c=zeros(N,1);
    for i=1:N
        tmpC=polyfit(t-s:t,averageTheta(i,t-s:t),1);
        y1=(t-s)*tmpC(1)+tmpC(2);
        y2=t*tmpC(1)+tmpC(2);
        c(i,1)=(y2 - y1)./(t - (t-s));
    end
    averageTheta(:,t-h) = atand(c);
end

population(:,3) = averageTheta(:,t-h)+eta*(rand(N,1)-0.5)*dt;
end