% Clean up MATLAB environment before starting
clc, close all


%===============================================================================
% Settings
%===============================================================================
numOfHistograms = 2;

%dir_path = ['Mito_GFP_a01', filesep, '*.tif'];
dir_path = '*.tif';
fname_out_without_extension = 'SOT_Mito_GFP_a01';
path_out = 'result_partB22_SOT';     % Folder/directory name


%===============================================================================
% SOT (OtsuThresholdSegmentation)
%===============================================================================
mkdir(path_out);        % Create directory; Needed for imwrite write permission.
fprintf('...Processing...\n')

dnames = dir(dir_path);
for k=1:length(dnames)
    dname = dnames(k).name;
    disp(dname)
    Img = imread(dname);

    % Convert to double and get the size of this video frame
    Img = double(Img);
    imgSize = size(Img);

    % in order to use matitk, we have to use 3D data
    % so we first build a 3D volume of two layers, and each layer
    % contains the original image
    D = zeros(imgSize(1),imgSize(2),2);
    D(1:imgSize(1),1:imgSize(2),1) = Img(1:imgSize(1),1:imgSize(2));
    D(1:imgSize(1),1:imgSize(2),2) = Img(1:imgSize(1),1:imgSize(2));

    % implement segmentation using Otsu's method
    segmentedImage = matitk('SOT', [numOfHistograms], double(D));
    %figure('Name','SOT segmented image')
    h = imagesc(squeeze(segmentedImage(:,:,1))); colormap gray; axis off; axis equal;
    saveas(h, ['results_partB_SOT', filesep, name_out, '_SOT_', int2str(numOfHistograms)], 'tiff')
    fname_out = strcat(path_out,'/',fname_out_without_extension,num2str(k,'%04d\n'),'.tiff');
    imwrite(vidFrame_cropped, fname_out, 'tiff', 'Compression','none');
end

fprintf('Done!\n  Cropped frames are saved in:\n  %s\n', path_out)
