function B=extract_HOG(I,S)
%extract all features for an image
%First the image will be resized to S[S1 S2], normaly S(i)%8 ==0 
%input: +I : The image needs to be featured
%       +S : size need change
%output: (S(1)-1)*(S(2)-1)*36 features

I=double(imresize(I,S));
B=[];
for i=1:8:size(I,1)-8
    for j=1:8:size(I,2)-8       
        J=I(i:i+15,j:j+15);
        B=[B,get_block(J)];
    end
end
end
function B=get_block(I)
%xtract features for a block, block =  2x2 cells
%       |------|------|
%       |cell1 |cell2 |
%       |------|------|
%       |cell3 |cell4 |
%       |------|------|
%input: block 16X16
%output: 9x4 =36 features
B=[];
for i=1:8:16
    for j=1:8:16
        J=I(i:i+7,j:j+7);
        B=[B,get_cell(J)];
    end
end
K=sqrt(sum(B.^2));
B=B/K;
%remove NaN
B(isnan(B)) = 0; 
end

function B=get_cell(I)
%extract 9 bins for each 8x8 cell.
%input: cell 8x8
%output: 9 bins
%take only angles from 0 -> 180. angles greater than 180 will be assigned =0
    hx=[-1 0 1];
    hy=hx';
    fx=imfilter(I,hx);
    fy=imfilter(I,hy);
    %gabs, theta
    gabs=sqrt(double(fx.^2+fy.^2));
    gtheta=round(atand(double(fy)./double(fx)));
     %remove Nan
    gtheta(isnan(gtheta)) = 0;
    
    gtheta1 = gtheta;
    %angles >180 =0
    gtheta1(gtheta < 0) = 180;
    gtheta1(gtheta > 0) = 0;
    gtheta = gtheta1 + gtheta;

    B=extract_9_bin(gabs,gtheta);
end



function B=extract_9_bin(gabs,gtheta)
%bin 1:9 [0  ][20 ][40 ][60 ][80 ][100 ][120 ][140 ][160 ]
B=zeros(1,9);
for i=1:size(gabs,1)
    for j=1:size(gabs,2)
       g_theta =gtheta(i,j);
       g_abs=gabs(i,j);
        
       
       K=floor(g_theta/20)+1;
       %calculate left bin and right bin
       K1=(K-1)*20;
       K2=K*20;
       %180 => bin 0
       K1(K1>=180)=0;
       K2(K2>=180)=0;
       %index left bin & right bin
       k1=floor(K1/20)+1;
       k2=floor(K2/20)+1;
       %calculate weight for left bin & right bin
       W1=(abs(K2-g_theta))/20;
       W2=(abs(g_theta-K1))/20;
       
       B(k1)=B(k1)+W1*g_abs;
       B(k2)=B(k2)+W2*g_abs;
    end        
end
end
