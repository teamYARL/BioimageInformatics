function [ bool ] = checkifonline( localmat )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

directionalmat=zeros(2);

directionalmat(1,1)=localmat(1,1)
directionalmat(1,2)=localmat(1,3)
directionalmat(2,1)=localmat(3,1)
directionalmat(2,2)=localmat(3,3)

[eigvect,eigval]=eig(directionalmat)

select=max(max(eigval))

for i =1:2
    if(eigval(i,i)==select)
        prefered=eigvect(:,i)
        prefered=prefered'
        prefered=fliplr(prefered)
    end
end

[FX,FY]=gradient(localmat)
%[FX,FY]=gradient(directionalmat)
delf=[FX,FY]
delf=delf'


end

