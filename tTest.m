function [ newlocalmax ] = tTest(image, localmax, localmin, sigma, Q )

%disp(sum(sum(localmax)));

[DT,x,y] = triangulationproject(localmin)

tmp = size(localmax);
rol = tmp(1);
col = tmp(2);

%tSet = [];

for i = 1 : rol
    for j = 1 : col
        if (localmax(i,j) == 1) 
            T = (abs(image(i,j) - mean));
            %tSet = [tSet T];
            if(T < Q*sigma)
                localmax(i,j) = 0;
            end
        end
    end
end

newlocalmax = localmax;
%disp(tSet);
%disp(sum(sum(newlocalmax)));

end
