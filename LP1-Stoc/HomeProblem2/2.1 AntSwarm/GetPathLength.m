function pathLength = GetPathLength(path,cityLocation)
    pathLength = 0;
    for i = 1:size(cityLocation,1)-1
        deltaxTmp = (cityLocation(path(i),1)-cityLocation(path(i+1),1))^2;
        deltayTmp = (cityLocation(path(i),2)-cityLocation(path(i+1),2))^2;
        
        pathLength = pathLength + sqrt(deltaxTmp + deltayTmp);
    end
    lastx = (cityLocation(path(end),1)-cityLocation(path(1),1))^2;
    lasty = (cityLocation(path(end),2)-cityLocation(path(1),2))^2;
    pathLength = pathLength + sqrt(lastx+lasty);
end