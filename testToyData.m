% Test adaboost with toy data and visualization
%%
clear;clc
kk = 1000;
data = randn(kk,2);
data = awgn(data,1);
label = double(data(:,1)>data(:,2)); 
label = double(2*(data(:,1).^2 + 3*data(:,2).^2)<3.2);
label(sin(data(:,1)+data(:,2))>0.5) = 1;
label(data(:,1)+data(:,2)>3) = 0;

pos1 = find(label == 1);
pos2 = find(label == 0);
label(pos2) = -1;

% plot training data
figure(1);plot(data(pos1,1), data(pos1,2), 'c.')
hold on;plot(data(pos2,1), data(pos2,2), 'm.')
xlim([-3 3])
ylim([-3 3])

iters = 1:4:30;
acc = zeros(numel(iters),1);
n = size(data,1);
x = data(1:(kk/2),:); y = label(1:(kk/2));
x_test = data((kk/2)+1:end,:); y_test = label((kk/2)+1:end);

for iter = iters
    [ model ] = adaboost( x, y, iter, @weakLearn, 20); 
    % larger number learning rate is, slower, smother
    % changing the learning rate, result significantly different
    yTestMat = zeros(size(x_test,1),iter);
    weakModels = model.weakModels;
    alphas = model.alphas; %[100 1]
    for k = 1:iter
        wm = weakModels{k};
        pred = (x_test(:,wm.feature) > wm.threshold);
        pred = pred+(pred==0)*-1;
        yTestMat(:,k) = pred*wm.dir;
    end
    H = sign(yTestMat*alphas);
    acc(find(iters==iter)) = mean(H==y_test);
end
% plot(iters,1-acc)
for i = 1:numel(weakModels)
    wm = weakModels{i};
    wm.feature
    if wm.feature == 1
        drawLine([wm.threshold,-5],[wm.threshold,5],'r');
    else
        drawLine([-5,wm.threshold],[5,wm.threshold],'b');
    end
    pause
end
hold off;
clc; max(acc)

