function inv_moments = hu_moment(im)
% *****************************************
% function: extract feature ho moment of a image
% output: vector feature hu moment
% input: + im: image binary 0, 1
% program created by DAO DUY NGU
% email: ddngu0110@gmail.com
% *****************************************
format long
[h, w] = size(im);
% compute centroid of the image
M = sum(sum(im));
maximum = max(h, w);
x = 0;
y = 0;
for i=1:maximum
    if i <= h
        x = x + sum(i*im(i, :));
    end
    if i <= w
        y = y + sum(i*im(:, i));
    end
end
x_centroid = x/M;
y_centroid = y/M;

% central moment and normalize
M_nor = zeros(4, 4);
for p=1:4
    for q=1:4
        %check p+q >= 4:
        if (p + q) < 4
            continue
        end
        m_t = 0.0;
        for x=1:h
            for y=1:w
                if im(x, y) == 1
                    m_t = m_t + ((x-x_centroid)^(p-1))*((y-y_centroid)^(q-1))*double(im(x, y));
                end
            end
        end
        % Normalize central moments
        M_nor(p,q) = m_t/((M)^(((p+q-2)/2)+1));
    end
end
eta = M_nor;
% hu_moments feature
inv_moments = double(zeros(7,1));
inv_moments(1) = eta(3,1) + eta(1,3);
inv_moments(2) = (eta(3,1) - eta(1,3))^2 + (4*eta(2,2)^2);
inv_moments(3) = (eta(4,1) - 3*eta(2,3))^2 + (3*eta(3,2) - eta(1,4))^2;
inv_moments(4) = (eta(4,1) + eta(2,3))^2 + (eta(3,2) + eta(1,4))^2;
inv_moments(5) = (eta(4,1) - 3*eta(2,3))*(eta(4,1) + eta(2,3))*((eta(4,1) + eta(2,3))^2 - 3*((eta(3,2) + eta(1,4))^2)) + (3*(eta(3,2) - eta(1,4)))*(eta(3,2) + eta(1,4))*(3*(eta(4,1) + eta(2,3))^2 - (eta(3,2) + eta(1,4))^2);
inv_moments(6) = (eta(3,1) - eta(1,3))*((eta(4,1)+eta(2,3))^2 - (eta(3,2)+ eta(1,4))^2) + 4*eta(2,2)*((eta(4,1) + eta(2,3))*(eta(3,2) + eta(1,4)));
inv_moments(7) = (3*eta(3,2) - eta(1,4))*(eta(4,1) + eta(2,3))*((eta(4,1) + eta(2,3))^2 - 3*(eta(3,2)-eta(1,4))^2) - (eta(4,1) - 3*eta(2,3))*(eta(3,2) + eta(1,4))*(3*(eta(4,1) + eta(2,3))^2 - (eta(3,2) + eta(1,4))^2);
inv_moments = inv_moments';
 
    