function hog_method4 = hog_feature(image_org)
% *****************************************
% function: extract feature hog of a window
% output: vector feature 1x9
% input: + im_org: image window
% program created by DAO DUY NGU
% email: ddngu0110@gmail.com
% *****************************************
hx = [-1 0 1];
hy = hx';
fx = imfilter(image_org, hx);
fy = imfilter(image_org, hy);
[h, w] = size(image_org);
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
count = 1;
for x = 0:20:160
    %copy matrix orientation
    G_theta_com = Gtheta;
    % check value orientation in thesh allow x-> x+1
    if x ~= 0
        G_theta_com(G_theta_com < x) = 0;
    end
    if x ~= 160
        G_theta_com(G_theta_com > x +  step) = 0;
    end
    % reshape matrix -> vector
    G_theta_com = reshape(G_theta_com,[1, w*h]);
    % copy value and tranform positive value -> 1
    G_check = G_theta_com;
    G_check(G_theta_com > 0) = 1;
    % compute value feature and assign 
    hog_method4(count) = hog_method4(count) + sum((G_check.*(x+step)-G_theta_com).*Gabs/20);
    if x + step == 180
        hog_method4(1) =  hog_method4(1) + sum((G_theta_com-G_check.*x).*Gabs/20);
    else
        hog_method4(count + 1) =  hog_method4(count + 1) + sum((G_theta_com-G_check.*x).*Gabs/20);
    end
    count = count + 1;
end



