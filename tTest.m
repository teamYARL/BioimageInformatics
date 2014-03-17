function [ newlocalmax ] = tTest( localmax, mean, sigma, Q )

%disp(localmax);

tmp = size(localmax);
rol = tmp(1);
col = tmp(2);

for i = 1 : rol
    for j = 1 : col
        if (localmax(i,j) == 1) 
            T = abs(mean)/sqrt((sigma^2)/3);
            if(T < Q)
                localmax(i,j) = 0;
            end
        end
    end
end

newlocalmax = localmax;
%disp(newlocalmax);
end
