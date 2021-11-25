clc
clear 

addpath(genpath('.\ultis'));
addpath(genpath('.\models'));


path = 'hulog.mat';

datasets = load(path);
datasets = datasets.datasets;

label = datasets(:, 1);
t = one_hot(label);
x = ((datasets(:, 2:end)'));

net = patternnet(8);
net.trainParam.epochs=1000000;
net.trainParam.lr=0.0005;
net = train(net,x,t);

y = net(x)
classes = vec2ind(y)
truth = vec2ind(t)
CM = confusionmat(classes, truth, 'Order', [1,2,3, 4, 5])
plotConfMat(CM, {'daisy', 'rose', 'hibiscus', 'lotus', 'sunflower'})
save hu_net