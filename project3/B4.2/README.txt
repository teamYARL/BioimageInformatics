Run the autoCalibraton.m to get the pixel size calibration.

In the autoCalibration.m, update the distance,filename for different image inputs.

When execute the autoCalibration.m, first crop a region long enough in X axis which 
should include some black segments(try avoid include horizontal black segments in the 
center vertical part, could just crop left half of the X axis), then crop a relatively 
small background region as information needed for local minimums detection. 
