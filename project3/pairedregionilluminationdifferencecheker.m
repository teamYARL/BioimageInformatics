%Does the caculation for the matrix in B.3
function [ averageimagedifference ] = pairedregionilluminationdifferencecheker(Region)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


%i decided a 10 by 10 region grid is good enough
%this is where the dimensions of the subregions are caclculated
squareparameter=10;
nRows=squareparameter;
nCols=squareparameter;
numsubregions=nRows*nCols;
dimensions=size(Region);
usedheight=dimensions(1)-mod(dimensions(1),nRows);
usedwidth=dimensions(2)-mod(dimensions(2),nCols);
subheight=usedheight/nRows;
subwidth=usedwidth/nCols;
% a celll matrix to hold all the sub regions
subregions=cell(numsubregions,1);
%the subregions are cropped and added to the cell matrix as seperate sub regions
for j=1:nRows
    for i=1:nCols
        heightstart=(j-1)*subheight+1;
        widthstart=(i-1)*subwidth+1;
        subregions((j-1)*nCols+i)=mat2cell(Region(heightstart:heightstart+subheight-1,widthstart:widthstart+subwidth-1),subheight,subwidth);
    end
end

%number of comparisons
numregioncomparisons=nchoosek(numsubregions,2);
numofsigdifferences=0;

%all the pairwise comparsions are done here and all the kstest2 results are summed here
for i=1:numsubregions-1
    for j=(i+1):numsubregions
        %averageimagedifference=class(subregions{i})
        sr1=subregions{i};
        sr2=subregions{j};
        numofsigdifferences=numofsigdifferences+kstest2(sr1(:),sr2(:));
    end
end

%numofsigdifferences;
% this is where the illumination difference is returned and then turned into the illumination uniformity
averageimagedifference=numofsigdifferences/numregioncomparisons;

end

