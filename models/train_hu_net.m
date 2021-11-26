clc
clear 

addpath(genpath('.\ultis'));
addpath(genpath('.\models'));


path = 'datasets_humoment.mat';

datasets = load(path);
datasets = datasets.datasets;

label = datasets(:, 1);
t = one_hot(label);
x = ((datasets(:, 2:end)'));
x = -sign(x).*(log10(abs(x)));

net = patternnet(15);

net.trainFcn = 'trainbr' ;
net.trainParam.epochs=100;
net.trainParam.lr=0.001;
net.divideparam.trainRatio= 80/100;
net.divideparam.valRatio= 10/100;
net.divideparam.testRatio= 10/100;

[net, tr] = train(net,x,t);

y = net(x);
classes = vec2ind(y);

%Extract test set
test_true = t  .* tr.testMask{1};
test_pred = y  .* tr.testMask{1};
test_pred = test_pred(~isnan(test_pred))';
test_pred = reshape(test_pred, [5, 59]);
test_pred = vec2ind(test_pred);
test_true = test_true(~isnan(test_true))';
test_true = reshape(test_true, [5, 59]);
test_true = vec2ind(test_true);

CM_test = confusionmat(test_pred', test_true', 'Order', [1,2,3, 4, 5]);
figure
subplot(121)
plotConfMat(CM_test, {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'});

truth = vec2ind(t);
CM = confusionmat(classes, truth, 'Order', [1,2,3, 4, 5]);
subplot(122)
plotConfMat(CM, {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'});
save hog_net
save CM_test