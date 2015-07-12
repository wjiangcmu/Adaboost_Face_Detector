function [ U,S,V ] = generateEigen( Y, imgSize, N)
% Generate eigenfaces and plot with matrix N
%   e.g. genEigen(Y, [3,4]) will subplot(3,4,i)
    [U,S,V] = svd(Y,0);
    
    if nargin < 3
        return;
    else 
        figure(1);
        k = 1;
        for i = 1:N(1)
            for j = 1:N(2)
                subplot(N(1),N(2),k);
                imshow(reshape(U(:,k),[imgSize(1) imgSize(2)]),[]);
                t = sprintf('Eigen face #%1.0f',k);
                k = k+1;
                title(t)
            end
        end 
    end   
end

