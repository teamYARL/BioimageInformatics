inputDir1 = 'curve_detection_images';%'microscope_char';
%inputDir2 = 'DrosophilaVesicleTransport';
filename = 'curv_det_01.tif';%'10x_calib.tif'; %'APPYFPX_Lgt_a07r10s01_001.tif';
%outputDir = 'CroppedImages';

imagePath = [inputDir1, filesep, filename]     % Cross-platform format
I = imread(imagePath);
I=double(I);
figure('Name', 'Please select the region with the thickest line in this image.') 
imshow(I, [])

rect = getrect();
croppedRegion = imcrop(I, rect);


figure('Name', 'Please select the tight square around the widest curve in this image.') 
imshow(croppedRegion, [])

rect = getrect();
croppedRegion = imcrop(croppedRegion, rect);


dimensionswidth=size(croppedRegion)
width=mean(dimensionswidth)

sigma=width/sqrt(3)
fixedmask=getguasskernalmask(sigma);
size(fixedmask)

I2 = conv2(I,fixedmask, 'same');   

imshow(I2, [])