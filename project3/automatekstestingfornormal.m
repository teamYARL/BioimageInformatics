croppedstr='cropped_APPYFPX_Lgt_a07r10s01_'
names=[]
for num = 100001:100150
    num= int2str(num)
    num=num(end-2:end)
    names=[names strcat(cropstr,num ,'.tif')]
end