%%

clc


originalimage = randi([0 255], 1000, 1000);
resizedimage = imresize(originalimage, [160 160]);
whos resizedimage

J = checkerboard(resizedimage);

figure
imshow(J)

%%
numRows = 8;
numColumns = 8;
rows = 1920;
columns = 1760;
pixelsx = floor(rows / (2*numRows))
grayImage = checkerboard(pixelsx, numRows/2, numColumns/2) > 0;
% Resize to rectangular instead of square.
grayImage = imresize(grayImage, [1920, 1760]);
imshow(grayImage);
%impixelinfo;
axis('on', 'image');
