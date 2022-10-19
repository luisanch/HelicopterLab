%quick script for getting the cartesian coordibates of poles based on 
%radius and angle span
clear all
number_of_poles = 6;
radius = 100;
span = 20;
spacing = span / (number_of_poles - 1);
angles = (0:number_of_poles - 1);
angles =  180 - (span / 2) + spacing*angles;
angles = deg2rad(angles);
radii = zeros(size(angles)) + radius;
[x,y] = pol2cart(angles, radii);

figure()
plot(x,y,'o');
grid on;plot(x,y)
y = y*i;
list = x+y;
list' 
