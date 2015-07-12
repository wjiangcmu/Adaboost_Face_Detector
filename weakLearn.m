function [ weakModel ] = weakLearn( x, y, D, rate )
% This weak learner use weight vector D(num of instance) to train on {x, y},
% where y is a column vector. It returns a weakModel with optimal threshod, 
% predicting label, feature idx, default searching step is 10
%   e.g. [weakModel] = weakLearn( x, y, D ) 
%   e.g. [weakModel] = weakLearn( x, y, D, rate)
    if nargin < 4
        rate = 10; % default learning rate for threshold searching
    end
    
    [n,m] = size(x);
    weakModel.err = 1;
    weakModel.dir = 1;
    weakModel.threshold = 0;
    weakModel.opt_predict = zeros(n,1);
    weakModel.feature = 1;
    for dir = [1, -1]
        for i = 1:m % choice of feature
            for threshold = linspace(min(x(:,i)), max(x(:,i)),rate)
                y_pred = double(x(:,i) > threshold); % USE DOUBLE!!!
                y_pred(y_pred==0) = -1;
                y_pred = y_pred+(y_pred==0)*-1;
                y_pred = y_pred*dir;
                err = D'*(y~=y_pred);
                if err < weakModel.err
                    weakModel.feature = i;
                    weakModel.err = err;
                    weakModel.threshold = threshold;
                    weakModel.dir = dir;
                    weakModel.opt_predict = y_pred;
                end
            end
        end 
    end
end

