function visibility = GetVisibility(cityLocation)
    visibility = zeros(size(cityLocation, 1));
    for i = 1:length(cityLocation)
        for j = 1:length(cityLocation)
            visibility(i,j) = 1 / sqrt((cityLocation(i,2)-cityLocation(j,2))^2 +(cityLocation(i,1)-cityLocation(j,1))^2);
        end
    end
end