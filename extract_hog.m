function all_feature = extract_hog(im_org, size_scale)
% *****************************************
% function: extract feature hog of a image
% output: vector feature hog
% input: + im_org: image original with color is gray
%        + size_scale: is vector [width, height], size normalize image [row, col] pow of 2
% program created by DAO DUY NGU
% email: ddngu0110@gmail.com
% *****************************************
% get size image current
format long
[h, w] = size(im_org);
% config size window and stride
size_window = 16;
stride = 8;
% check and resize image about size 64x64 or 64x64
if h > w
    im_org = imresize(im_org, size_scale);
else
    im_org = imresize(im_org, size_scale);
end
% get size image after resize
[h, w] = size(im_org);
% compute number feature of image
number_feature = ((h-size_window)/stride + 1)*((w-size_window)/stride + 1)*36;
% create a vector feature original have value 0 with size is number feature
all_feature = zeros(1, number_feature);
% initialization count
count_feature = 1;
% get window of a image
for y=0:stride:h-size_window
    for x=0:stride:w-size_window
        %get window of image with size is size window
        im_window = im_org(y+1:y+size_window, x+1:x+size_window);
        % initialization vector hog with 36 feature
        value_hog36 = zeros(1, 36);
        count = 1;
        % split window and compute vector feature hog
        for j=0:stride:size_window-stride
            for i=0:stride:size_window-stride
                % get image hog of a image window with size stride
                im_hog = im_window(j+1:j+stride, i+1:i+stride);
                % ---------------------------------------------------------
                % compute vector hog
                format long
                hx = [-1 0 1];
                hy = hx';
                fx = imfilter(im_hog, hx);
                fy = imfilter(im_hog, hy);
                [h, w] = size(im_hog);
                % compute mag
                Gabs = round(sqrt(double(fx.^2 + fy.^2)), 2);
                % reshape about one vector
                Gabs = reshape(Gabs, [1, w*h]);
                % compute orientation
                Gtheta = round(atand(double(fy)./double(fx)));
                Gtheta(isnan(Gtheta)) = 0;
                % transform angle negative
                Gtheta1 = Gtheta;
                Gtheta1(Gtheta < 0) = 180;
                Gtheta1(Gtheta > 0) = 0;
                Gtheta = Gtheta1 + Gtheta;
                step = 20;
                % create matrix feature original have value 0
                hog_method4 = zeros(1,9);
                count1 = 1;
                for k = 0:20:160
                    %copy matrix orientation
                    G_theta_com = Gtheta;
                    % check value orientation in thesh allow x-> x+1
                    if k ~= 0
                        G_theta_com(G_theta_com < k) = 0;
                    end
                    if k ~= 160
                        G_theta_com(G_theta_com > k +  step) = 0;
                    end
                    % reshape matrix -> vector
                    G_theta_com = reshape(G_theta_com,[1, w*h]);
                    % copy value and tranform positive value -> 1
                    G_check = G_theta_com;
                    G_check(G_theta_com > 0) = 1;
                    % compute value feature and assign 
                    hog_method4(count1) = hog_method4(count1) + sum((G_check.*(k+step)-G_theta_com).*Gabs/20);
                    if k + step == 180
                        hog_method4(1) =  hog_method4(1) + sum((G_theta_com-G_check.*k).*Gabs/20);
                    else
                        hog_method4(count1 + 1) =  hog_method4(count1 + 1) + sum((G_theta_com-G_check.*k).*Gabs/20);
                    end
                    count1 = count1 + 1;
                end
                % ---------------------------------------------------------
                % assign vecotr hog 
                value_hog36(1, count:count+stride) = hog_method4;
                count = count + stride + 1;
            end
        end
        % Normalize vector hog with 36 feature
        K = sqrt(sum(value_hog36.^2));
        value_hog_normalize = value_hog36/K;
        % change value NaN -> 0
        value_hog_normalize(isnan(value_hog_normalize)) = 0;
        % assign vector hog 36
        all_feature(1, count_feature:count_feature+35) = value_hog_normalize;
        count_feature = count_feature + 36;
    end
end
