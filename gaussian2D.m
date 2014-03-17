%% 2D gaussian fit equation
% x is the vector of parameters for equation
function [F] = gaussian2D(x, xydata)
xdata = xydata(1);
ydata = xydata(2);
class(xdata)
class(x)
class(x(1))
F = x(1)*exp(-((xdata-x(3))^2+(ydata-x(4))^2)/x(2)^2);