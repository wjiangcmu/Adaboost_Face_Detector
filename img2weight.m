function [ w ] = img2weight( X, U, eigenSize, imgSize, numEigen, opt)
% This is the feature extraction process. X is the input image matrix
% [pixels, numImages], U is the eigen vector, eigenSize is the size of
% each eigen face [row, col], imgSize is the size of each image [row, col],
% numEigen is the number of top eigen faces chosen from U
%   e.g. w = img2weight( X, U, eigenSize, imgSize, numEigen, '0' )
%   Default mode is to add error as feature, o/w no error feature
    tempEigen = U(:,1:numEigen);
    eigenFaces = zeros(imgSize(1)*imgSize(2),numEigen);
    for i = 1:numEigen
        resized = imresize(reshape(tempEigen(:,i),eigenSize),imgSize);
        eigenFaces(:,i) = resized(:);
    end
    weight = X'*eigenFaces;
    if nargin == 6 && opt == '0'
        w = weight;
        return;
    else %default
        dif = X-eigenFaces*weight';
        err = sqrt(sum(dif.^2,1))/size(eigenFaces,1);
        w = [err', weight];
end

