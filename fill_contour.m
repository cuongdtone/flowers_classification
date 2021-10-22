function out = fill_contour(biggest_contour);
%Fill contour
binaryImage = biggest_contour;
[rows, columns] = size(binaryImage);
for col = 1 : columns
	% Find the top most pixel.
	topRow = find(binaryImage(:, col), 1, 'first');
	if ~isempty(topRow)
		% If there is a pixel in this column, then find the lowest/bottom one.
		bottomRow = find(binaryImage(:, col), 1, 'last');
		% Fill from top to bottom.
		binaryImage(topRow : bottomRow, col) = true;
	end
end
out = binaryImage;