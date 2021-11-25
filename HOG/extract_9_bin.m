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
