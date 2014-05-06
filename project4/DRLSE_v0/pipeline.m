clear all;
close all;

%test('60x_02_resize_300width.ppm');   fo

%test('Blue0001.tiff');

inputDir = 'Mito_GFP_a01';
outputDir = 'sequence_results';

structOfImages = dir([inputDir, filesep , '*.tif']);

for i = 1:length(structOfImages)
    %clear all;
    close all;
    
    
    
    filename = structOfImages(i).name;
    filenameOut = ['seg_', filename];
    filePathOut = [outputDir, filesep, filenameOut];

    imagePath = [inputDir, filesep, filename];
    test(imagePath, filePathOut);
    
    %I = imread(imagePath);
   % J = imresize(I, [80 NaN]);
    
    %imwrite(I, [filePathOut,'.ppm'], 'ppm');
    
    %disp('image ');
    disp(i);
    %disp('done');
end
