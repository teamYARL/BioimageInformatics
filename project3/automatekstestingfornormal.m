croppedstr='cropped_APPYFPX_Lgt_a07r10s01_'
for num = 100001:100150
    num= int2str(num)
    num=num(end-2:end)
    strcat(cropstr,num ,'.tif')
end