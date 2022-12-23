function visibility = GetVisibility(cityLocation)
visibility = 1./pdist2(cityLocation, cityLocation);
end