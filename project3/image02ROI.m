function [ pics,crops ] = image02ROI( imname )
%Question3.2 from project 1
% crop the image in all channels
% get image and metadata
mtif=imname;
info = imfinfo(mtif);
num_images = numel(info);
% get objects to hold initial images and cropped images
pics=cell(1,num_images);
crops=cell(1,num_images);
for k = 1:num_images
    %for each channel read it in, crop it to desired region, write cropped image to file
    % and save images and cropped images to objects
    A = imread(mtif, k, 'Info', info);
    if (k==1)
        % for first image select a region and record it so all channels 
        % can be cropped in the same place
        imshow(A);
        rec=getrect;
    end
    cro=imcrop(A,rec);
    pics{k}=A;
    imwrite(cro,strcat('image02-',int2str(k),'.tiff'));
    crops{k+num_images}=cro;
end
end

