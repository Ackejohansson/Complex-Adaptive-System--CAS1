function h = NeighbourhoodFunction(i0,i,j, sigma)
    ri0 = i0;
    ri = [i,j];
    h = exp(-norm(ri-ri0)/(2*sigma^2));
end