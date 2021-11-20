function plotConfMat(varargin)
% Edit: Cuong Tran
% Thank for author! Vahe Tshitoyan.
% Visualize Confusion Matrix

switch (nargin)
    case 0
       confmat = 1;
       labels = {'1'};
    case 1
       confmat = varargin{1};
       labels = 1:size(confmat, 1);
    otherwise
       confmat = varargin{1};
       labels = varargin{2};
end
confmat(isnan(confmat))=0; % in case there are NaN elements
numlabels = size(confmat, 1); % number of labels
% calculate the percentage accuracies
confpercent = 100*confmat./repmat(sum(confmat, 1),numlabels,1);
% plotting the colors
imagesc(confpercent);
title(sprintf('Accuracy: %.2f%%', 100*trace(confmat)/sum(confmat(:))));
ylabel('Truth'); xlabel('Predict');
% set the colormap
colormap(flipud(gray));
% Create strings from the matrix values and remove spaces
textStrings = num2str([confpercent(:), confmat(:)], '%.1f%%\n%d\n');
textStrings = strtrim(cellstr(textStrings));
% Create x and y coordinates for the strings and plot them
[x,y] = meshgrid(1:numlabels);
hStrings = text(x(:),y(:),textStrings(:), ...
    'HorizontalAlignment','center');
% Get the middle value of the color range
midValue = mean(get(gca,'CLim'));
% Choose white or black for the text color of the strings so
% they can be easily seen over the background color
textColors = repmat(confpercent(:) > midValue,1,3);
set(hStrings,{'Color'},num2cell(textColors,2));
% Setting the axis labels
set(gca,'XTick',1:numlabels,...
    'XTickLabel',labels,...
    'YTick',1:numlabels,...
    'YTickLabel',labels,...
    'TickLength',[0 0]);
end