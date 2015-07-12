function [ model ] = adaboost( x, y, iter, learner, rate )
% adaboost take input {x,y}, number of iteration and a weak learner 
% (default is weakLearn, should return err and train prediction) to learn a
% complex model. It returns a model with set of weak models
%   e.g. [ model ] = adaboost(x, y, iter)
%   e.g. [ model ] = adaboost(x, y, iter, learner)
    if nargin < 4
        rate = 10;
        learner = @weakLearn; % default learner
    elseif nargin < 5
        rate = 10;
    end
    
    n = size(x,1);
    D = 1/n*ones(n,1); %[n 1]
    weakModels = cell(iter,1);
    alphas = zeros(iter,1);
    for t = 1:iter
        fprintf('Iteration %2.0f/%2.0f with %2.0f features(eigen)... \n',t,iter, size(x,2));
        wm = learner(x, y, D,rate); %h [n,1]
        alphas(t) = 1/2*log((1-wm.err)/wm.err);
        for i = 1:n
            D(i) = D(i)*exp(-alphas(t)*y(i)*wm.opt_predict(i));
        end
        D = D/sum(D);
        weakModels{t} = wm;
    end
    model.alphas = alphas;
    model.weakModels = weakModels;
end

