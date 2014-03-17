function [x] = gaussianfit(img)

%% Condition the data
a = size(img);
m = a(1);
n = a(2);
xx = 1:n;  %vector for x coordinate
yy = 1:m;  %vector for y coordinate
zz = img;
[xData, yData, zData] = prepareSurfaceData(xx, yy, zz);
xyData = {xData,yData};

%% Set up the startpoint
[amp, index] = max(zData); % amp is the amplitude.
x0 = xData(index); % first guess at the maximum
y0 = yData(index); % first guess at the maximum
sigma = 1;
StartPoint = [amp, sigma, x0, y0];

%% Set up the lower and upper bound 
xmax = max(xData)+2;
ymax = max(yData)+2;
xmin = min(xData)-2;
ymin = min(yData)-2;
Lower = [0, 0, xmin, ymin];
Upper = [Inf,Inf, xmax, ymax]; % angles greater than 90 are redundant

%% perform the fitting
%x is the fitting result for parameters
x = lsqcurvefit('gaussian2D',StartPoint,xyData,zData,Lower,Upper); 
% F = x(1)*exp(-((xdata-x(3))^2+(ydata-x(4))^2)/x(2));

end

