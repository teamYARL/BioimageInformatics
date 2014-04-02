%% eigenvector unnormalized

% H is the output of hessianmatrix function
% E is the matrix of corresponding eigen vectors
function [ E ] = eigenmatrix(H)

% get size of H
[m,n] = size(H);

E = cell(m,n);

for i = 1:m
    for j=1:n
        [eigvect,eigval]=eig(H{i,j});
        % extract the diagnol of eigen value matrix
        eigval = diag(eigval);
        % find the position of max eigen value
        col = find(eigval==max(eigval(:)));
        % find the corresponding eigen vector for this max eigen value
        E{i,j} = eigvect(:,col);
    end
end
        
        