function [ Y, sizeOfFace ] = readFaces( folder, extension )
%Read face images from folder, generate a matrix with all faces
%   [ Y, sizeOfFace ] = readFaces( 'lfw1000', '.pgm$' )
    files = dir(fullfile(pwd,folder));
    k = 0;
    images = {};
    for i = 1:numel(files)
        fid = strcat(folder,files(i,1).name);

        if isempty(regexp(fid,extension))
            k = k+1;
        else
            img = double(imread(fid));
            img = (img-mean(img(:)))/norm(img(:));
            images{i-k} = img;
        end
    end
    Y = [];
    sizeOfFace = size(images{1});
    for i = 1:numel(images)
        Y = [Y images{i}(:)];
    end
end

