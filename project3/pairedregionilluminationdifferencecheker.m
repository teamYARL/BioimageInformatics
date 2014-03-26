function [ averageimagedifference ] = pairedregionilluminationdifferencecheker(Region)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

squareparameter=20;
nRows=squareparameter
nCols=squareparameter
numsubregions=nRows*nCols
dimensions=size(Region);
usedheight=dimensions(1)-mod(dimensions(1),nRows)
usedwidth=dimensions(2)-mod(dimensions(2),nCols)
subheight=usedheight/nRows;
subwidth=usedwidth/nCols;

subregions=cell(numsubregions,1);

for j=1:nRows
    for i=1:nCols
        heightstart=(j-1)*subheight+1;
        widthstart=(i-1)*subwidth+1;
        subregions((j-1)*nCols+i)=mat2cell(Region(heightstart:heightstart+subheight-1,widthstart:widthstart+subwidth-1),subheight,subwidth);
    end
end

numregioncomparisons=nchoosek(numsubregions,2)
numofsigdifferences=0;

for i=1:numsubregions-1
    for j=(i+1):numsubregions
        %averageimagedifference=class(subregions{i})
        sr1=subregions{i};
        sr2=subregions{j};
        numofsigdifferences=numofsigdifferences+kstest2(sr1(:),sr2(:));
    end
end

numofsigdifferences

averageimagedifference=numofsigdifferences/numregioncomparisons;

end

