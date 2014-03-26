imagePath = ['microscope_char', filesep, 'DrosophilaVesicleTransport', filesep, 'APPYFPX_Lgt_a07r10s01_001.tif'];     % Cross-platform format
I = imread(imagePath);
I=double(I);
figure('Name', 'Please select the background of this image to be tested for background illumination uniformity');
imshow(I, []);

rect = getrect();
croppedRegion = imcrop(I, rect);
close;

illuminationdifference=pairedregionilluminationdifferencecheker(croppedRegion)

illuminationuniformity=1-illuminationdifference
