function [ localmax, localmin ] = detectlocalmaxmin_inputMatrix( im, masksize )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   Usage: im = image path
%          masksize = number (`3` for 3x3 mask)
%   e.g.: im = '2/images/001.tif'
%         masksize = 3

I = double(im);     %double as recommended by Prof Yang

% TESTING
%===============================================================================
%masksize = 5;   % testing
%I = magic(3)    % testing
%I = magic(5)    % testing; need to bound
%===============================================================================

dimensions=size(I);
minmap=zeros(dimensions);
maxmap=zeros(dimensions);

offset=floor(masksize/2);

for i=1+offset:dimensions(1)-offset
    for j=1+offset:dimensions(2)-offset
        submatrix=I(i-offset:i+offset,j-offset:j+offset);
        cpoint=I(i,j);
        submatrix=submatrix(:);
        if cpoint==max(submatrix)
            maxmap(i,j)=1;
            cpoint;
        end
        if cpoint==min(submatrix)
            minmap(i,j)=1;
            cpoint;
        end
    end
    %if i==3
    %    break
    %end
end

localmax=minmap;
localmin=maxmap;

%I2 = I([1:masksize], [1:masksize])    % bound to (masksize x masksize)
%I = I2;

% init
%maxima = FALSE;
%minima = FALSE;

%check masksize/2; require masksize to be odd number by odd number
%if max(I) > I(masksize/2, masksize/2)
%    maxima = TRUE;
%end

%if min(I) > I(masksize/2, masksize/2)
%    minima = TRUE;
%end


%% [col,row] coordinates so that accessing in MATLAB is natural
%%   e.g. Image(col,row)
%localmax = [1,1];       % vector [col,row]
%localmin = [1,1];       % vector [col,row]
%localmax_row = localmax(2);
%localmax_col = localmax(1);
%localmin_row = localmin(2);
%localmin_col = localmin(1);
%
%% Find max and min in row and col
%for k = 1:masksize
%    if max( I(localmax_row,:) ) < max( I(k,:) )
%        localmax_row = k;
%    end
%    if min( I(localmin_row,:) ) > min( I(k,:) )
%        localmin_row = k;
%    end
%    if max( I(:,localmax_col) ) < max( I(:,k) )
%        localmax_col = k;
%    end
%    if min( I(:,localmin_col) ) > min( I(:,k) )
%        localmin_col = k;
%    end
%end














%
%% Print outputs to console
%localmax = [localmax_col, localmax_row]
%localmin = [localmin_col, localmin_row]

end
