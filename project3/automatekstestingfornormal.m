croppedstr='CroppedImages\cropped_APPYFPX_Lgt_a07r10s01_'
names=[];
for num = 100001:100150
    num= int2str(num);
    num=num(end-2:end);
    names=[names, strcat(croppedstr,num ,'.tif'), '   '];
end
sepnames=strsplit(names);
sepnames=sepnames(1:end-1);
numfiles=length(sepnames)

kstests=[];
means=[];
stds=[];
for i=1:numfiles
    %sepnames{i}
    %class(sepnames{i})
    back=imread(sepnames{i});
    back=double(back);
    means=[means, mean2(back)];
    stds=[stds,std2(back)];
    kstests=[kstests, kstest(back)];
end
sum(kstests)

plot(means)
plot(stds)



spacemeans=[];
spacestds=[];
samples=cell(1,5);
imagePath='microscope_char\DrosophilaVesicleTransport\APPYFPX_Lgt_a07r10s01_001.tif';
I=double(I);
I = imread(imagePath);
for sample=1:5
figure('Name', strcat('Please select the background of this image to be saved - sample: ',int2str(sample))), imshow(I, [])

rect = getrect();
croppedRegion = imcrop(I, rect);
spacemeans=[spacemeans mean2(croppedRegion)]
spacestds=[spacestds std2(croppedRegion)]
di=size(croppedRegion)
samples(sample)=mat2cell(croppedRegion,di(2),di(1))

close;

end

imagePath='imagesfromproj1\image01.tiff';
I = imread(imagePath);
I=double(I);
figure('Name', strcat('Please select the background of this image to be saved')), imshow(I, [])
rect = getrect();
croppedRegion = imcrop(I, rect);
kstest(croppedRegion)
close;


imagePath='imagesfromproj1\image02.tiff';
[pic,crop]=image02ROI(imagePath);
%I = imread(imagePath);
%I=double(I);
disp ('now')

for chan=1:2
    figure('Name', strcat('Please select the background of this image to be saved - channel: ',int2str(chan))), imshow(crop{chan}, [])

    rect = getrect();
    croppedRegion = imcrop(crop{chan}, rect);
    croppedRegion=double(croppedRegion);
    class(croppedRegion)
    kstest(croppedRegion)
    close;
end
