function population = UpdateThetaVisionCone(population,noise,deltat,N,k,L,R)
theta=population(:,3);
averageTheta=zeros(N,1);
tmpPop=population(:,1:2);
M = [tmpPop-L; tmpPop+L; tmpPop(:,1)-L,tmpPop(:,2);tmpPop(:,1)+L,tmpPop(:,2);tmpPop(:,1),tmpPop(:,2)-L;tmpPop(:,1),tmpPop(:,2)+L;tmpPop(:,1)-L,tmpPop(:,2)+L;tmpPop(:,1)+L,tmpPop(:,2)-L];


for i=1:N
    x=population(i,1);
    y=population(i,2);

    visibility = sqrt((x-[population(:,1);M(:,1)]).^2+(y-[population(:,2);M(:,1)]).^2);  
    
    index = visibility(:,1) < R;
    index1=logical(sum(reshape(index,N,9),2));
    
    x2=R*cos(theta(i));
    y2=R*sin(theta(i));
    
    c=polyfit([x,x2],[y,y2],1);
    cinvers=-1./c;
    
    x2=0;
    y2=cinvers(2);
    
    index2=zeros(N,1);
    direction = sign(theta(i));
    
    for j=1:N
        d=(population(j,1)-x)*(y2-y)-(population(j,2)-y)*(x2-x);
        if sign(d) == direction || d==0
            index2(j)=1;
        end
    end
    index2=logical(index2);
    
    visibility=reshape(visibility,N,9);
    visibility=min(visibility,[],2);
    visibility(:,2)=theta;
    visibility=sortrows(visibility(and(index1,index2),:));
    
    if size(visibility,1)>k
        nominator=mean(sin(visibility(1:k+1,2)));
        denominator=mean(cos(visibility(1:k+1,2)));
        averageTheta(i,1)=atan2(nominator,denominator);
    else
        nominator=mean(sin(visibility(:,2)));
        denominator=mean(cos(visibility(:,2)));
        averageTheta(i,1)=atan2(nominator,denominator);
    end
end

population = averageTheta+noise*(rand(N,1)-0.5)*deltat;

end
