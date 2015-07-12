function [] = markFace( A, idxs, eigenSize, sf)
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here
    hold on;
    for i = size(idxs,1)
        idx = idxs(i,:);
        r = idx(1);c = idx(2);
        n = eigenSize(1)*sf; m = eigenSize(2)*sf;
        A(r:(r+5),c:(c+m)) = 225;
        A((r+n):(r+n+5),c:(c+m)) = 225;
        A(r:(r+n),c:(c+5)) = 225;
        A(r:(r+n),(c+m):(c+m+5)) = 225;
    end
    imshow(A,[]);
end

