function B=extrac_HOG(I,S)
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

        
         