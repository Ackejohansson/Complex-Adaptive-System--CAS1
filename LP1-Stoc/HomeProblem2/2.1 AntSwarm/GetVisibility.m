function visibility = GetVisibility(cityLocation)
visibility = 1 ./sqrt((cityLocation(:,1) - cityLocation(:,1)').^2 + (cityLocation(:,2) - cityLocation(:,2)').^2);
end