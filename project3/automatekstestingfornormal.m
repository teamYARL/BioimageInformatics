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