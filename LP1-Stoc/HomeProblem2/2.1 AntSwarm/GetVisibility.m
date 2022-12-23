function visibility = GetVisibility(cityLocation)
visibility = zeros(length(cityLocation));
for i = 1:length(cityLocation)
    visibility(i,:) = 1./pdist2(cityLocation, cityLocation(i,:));
end
end