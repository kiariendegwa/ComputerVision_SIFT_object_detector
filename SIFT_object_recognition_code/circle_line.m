function circle_line(x,y,r, angle)
%x and y are the coordinates of the center of the circle
%r is the radius of the circle
%0.01 is the angle step, bigger values will draw the circle faster but
%you might notice imperfections (not very smooth)
%
%angle in radians
ang=0:0.01:2*pi; 
xp=r*cos(ang);
yp=r*sin(ang);
plot(x+xp,y+yp, 'g', 'LineWidth', 4);
hold on

[x2,y2] = pol2cart(angle/180*pi,r);
plot(line([x, x+x2], [y, y+y2]), 'g', 'LineWidth', 4);
end