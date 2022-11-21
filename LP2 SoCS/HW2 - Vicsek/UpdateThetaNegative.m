function [population,averageTheta] = UpdateThetaNegative(population,noise,deltat,N,R,h,t,s,averageTheta)
theta=population(:,3);
tmpAverageTheta=zeros(N,1);

for i=1:N
    x=population(i,1);
    y=population(i,2);

    visibility = sqrt((x-population(:,1)).^2+(y-population(:,2)).^2);  
    inRadius=visibility < R;

    nominator=mean(sin(theta(inRadius)));
    denominator=mean(cos(theta(inRadius)));
    tmpAverageTheta(i,1)=atan2(nominator,denominator);
end

averageTheta(:,t)=tmpAverageTheta;

if (h>0 && t-h<=0) || (h<0 && t-s<1)
    population=population(:,3);
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

population = averageTheta(:,t-h)+noise*(rand(N,1)-0.5)*deltat;

end