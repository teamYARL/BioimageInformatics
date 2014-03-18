function x = gaussianfit(xData,yData,zData)

%% Condition the data
[X, Y] = meshgrid(xData,yData);
XY(:,:,1) = X;  % x coordinate
XY(:,:,2) = Y;  % y coordinate

%% Create objective function
gaussian2D = @(x,XY) x(1)*exp(-((XY(:,:,1)-x(3)).^2/x(2))-((XY(:,:,2)-x(4)).^2/x(2)))+x(5);


%% Set up the startpoint
amp = max(max(zData)); % amp is the amplitude.
[x0, y0] = find(zData==max(max(zData)));  % first guess for position at the maximum
b = 50;
c = 300;
StartPoint = [amp, b, x0, y0, c];

%disp(StartPoint);

%% perform the fitting
% x is the fitting result for parameters
x = lsqcurvefit(gaussian2D,StartPoint,XY,zData); 

% show Fitted Surface
%Z = gaussian2D(x,XY); 
%surf(X, Y, Z)


end