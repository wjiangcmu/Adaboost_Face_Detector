function [ score, testFace, idxMat ] = faceScore( testFid, eigenFace, scaleFactor, stepSize)
% Calculate similarity of eigenface and patches on test image
%  [score, A] = faceScore('img.jpg', eigenFace, 2, 2)
    if nargin < 2
        return;
    elseif nargin == 2
        scaleFactor = 1;
        stepSize = 1;
    elseif nargin == 3
        stepSize = 1;
    end
     
    testFace = squeeze(mean(imread(testFid),3));
    E = imresize(eigenFace, floor(size(eigenFace)*scaleFactor));
    E = -E;
    [n, m] = size(E);
    [p, q] = size(testFace);
 
    integralA = cumsum(cumsum(testFace,1),2);
    patchmeanofA = zeros(p,q);
    idxMat.row = 1:stepSize:(p-n+1);
    idxMat.col = 1:stepSize:(q-m+1);
    row = 0;
    for i = 1:stepSize:(p-n+1)
        row = row+1; col = 0;
        for j = 1:stepSize:(q-m+1)
            col = col+1;
            a1 = integralA(i,j);
            a2 = integralA(i+n-1,j);
            a3 = integralA(i,j+m-1);
            a4 = integralA(i+n-1,j+m-1);
            patchmeanofA(row,col) = a4 + a1 - a2 - a3;
        end
    end
    tmpim = conv2(testFace, rot90(E,2));
    convolvedimage = tmpim(n:end, m:end);
    sumE = sum(E(:));
    score = convolvedimage - sumE*patchmeanofA(1:size(convolvedimage,1),1:size(convolvedimage,2));
end

