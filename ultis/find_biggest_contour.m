function out = find_biggest_contour(edge)
% Find biggest contour
% Dev: Cuong Tran
im_fill = imfill(edge, 'holes');
s = regionprops(im_fill, 'Area', 'PixelList');
[~,ind] = max([s.Area]);
pix = sub2ind(size(edge), s(ind).PixelList(:,2), s(ind).PixelList(:,1));
out = zeros(size(edge));
out(pix) = edge(pix);