function [population,averageTheta] = UpdateThetaDelayAmanda(population,noise,deltat,N,R,h,t,averageTheta)
theta=population(:,3);
tmpAverageTheta=zeros(N,1);
if(sum(sum(averageTheta(N,h)))>0)
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
    population = averageTheta(:,t-h)+noise*(rand(N,1)-0.5)*deltat;
    
else
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
    population = tmpAverageTheta+noise*(rand(N,1)-0.5)*deltat;
end
end