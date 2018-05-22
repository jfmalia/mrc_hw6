function [MAP] = map_image(ifile)

% Read the Map Image
% ifile = '../maps/map.pgm';   % Image file name
I=imread(ifile);
 
% Set the size scaling
xWorldLimits = [-10 9.2];
yWorldLimits = [-10 9.2];
RI = imref2d(size(I),xWorldLimits,yWorldLimits)
 
% Plot Map Image
figure(3);
clf()
MAP = imshow(flipud(I),RI); hold on
set(gca,'YDir','normal')
end

