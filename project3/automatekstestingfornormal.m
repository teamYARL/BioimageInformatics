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



spacemeans=[]
spacestds=[]
imagePath=sepnames{i};
I = imread(imagePath);
for samples=1:5
figure('Name', strcat('Please select the background of this image to be saved - sample: ',int2str(samples))), imshow(I, [])

rect = getrect();
croppedRegion = imcrop(I, rect);
spacemeans=[spacemeans mean2(croppedRegion)]
spacemeans=[spacemeans mean2(croppedRegion)]


end
close;

