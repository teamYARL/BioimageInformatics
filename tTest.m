function [ newlocalmax ] = tTest(image, localmax, mean, sigma, Q )

%disp(sum(sum(localmax)));

tmp = size(localmax);
rol = tmp(1);
col = tmp(2);

tSet = [];

for i = 1 : rol
    for j = 1 : col
        if (localmax(i,j) == 1) 
            T = (abs(image(i,j) - mean))/(sqrt((sigma^2)/3));
            tSet = [tSet T];
            if(T < Q)
                localmax(i,j) = 0;
            end
        end
    end
end

newlocalmax = localmax;
%disp(tSet);
%disp(sum(sum(newlocalmax)));

end
