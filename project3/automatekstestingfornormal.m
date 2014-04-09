croppedstr=['CroppedImages', filesep, 'cropped_APPYFPX_Lgt_a07r10s01_'];
names=[];
for i = 1:150
    num = sprintf('%03d',i);
    names=[names, strcat(croppedstr,num ,'.tif'), '   '];
end
sepnames=strsplit(names);
sepnames=sepnames(1:end-1);
numfiles=length(sepnames)

%% B2.1
kstests=[];
means=[];
stds=[];
for i=1:numfiles
    sepnames{i}
    back=imread(sepnames{i});
    back=double(back);
    means=[means, mean2(back)];
    stds=[stds,std2(back)];
    kstests=[kstests, kstest(back)];
end
su=sum(kstests)

figure('Name','B.2: Noise signal distribution, mean')
plot(means)
figure('Name','B.2: Noise signal distribution, sd')
plot(stds)

figure
%% B2.2

kstests2=[];
for j=1:numfiles-1
    % first cropped background
    back1=imread(sepnames{j});
    back1=double(back1);
    size1 = numel(back1);
    back1=reshape(back1',1,size1);

    % second cropped background
    back2=imread(sepnames{j+1});
    back2=double(back2);
    size2 = numel(back2);
    back2=reshape(back2',1,size2);
    
    kstests2=[kstests2, kstest2(back1,back2)];
end
su2=sum(kstests2)



%% B2.3

spacemeans=[];
spacestds=[];
samples=cell(1,5);
imagePath=['microscope_char', filesep, 'DrosophilaVesicleTransport', filesep, 'APPYFPX_Lgt_a07r10s01_001.tif'];
I = imread(imagePath);
I=double(I);
for sample=1:5
figure('Name', strcat('Please select the background of this image to be saved - sample: ',int2str(sample))), imshow(I, [])

rect = getrect();
croppedRegion = imcrop(I, rect);
spacemeans=[spacemeans mean2(croppedRegion)]
spacestds=[spacestds std2(croppedRegion)]
di=size(croppedRegion)
samples(sample)=mat2cell(croppedRegion,di(1),di(2).*ones(1,1))

close;

end

%% next part

imagePath=['imagesfromproj1', filesep, 'image01.tiff'];
I = imread(imagePath);
I=double(I);
figure('Name', strcat('Please select the background of this image to be saved')), imshow(I, [])
rect = getrect();
croppedRegion = imcrop(I, rect);
kstest(croppedRegion)
close;


imagePath=['imagesfromproj1', filesep, 'image02.tiff'];
[pic,crop]=image02ROI(imagePath)
%I = imread(imagePath);
%I=double(I);
%disp ('now')

for chan=1:2
    figure('Name', strcat('Please select the background of this image to be saved - channel: ',int2str(chan))), imshow(crop{chan}, [])

    rect = getrect();
    croppedRegion = imcrop(crop{chan}, rect);
    croppedRegion=double(croppedRegion);
    %class(croppedRegion)
    kstest(croppedRegion)
    close;
end
