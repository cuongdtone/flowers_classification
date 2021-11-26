function S=hu_moment(J)

% Caculation Hu Moment vector from Binary Mask
% Dev: Thien Le Van, Duy Ngu Dao


% Caculation Hu Moment vector from Binary Mask
% Dev: Thien Le Van, Duy Ngu Dao

format long;
[w,h]=size(J);
x_=0;
y_=0;
S=0;
for i =1:w
    for j=1:h
       S=S+double(J(i,j));
       x_=x_+double(i*J(i,j));
       y_=y_+double(j*J(i,j));
       
    end
end
S;
x_=x_/S;
y_=y_/S;



m_pq=zeros(4,4);
M=zeros(4,4);
for p=0:3
    for q=0:3
        m=0;
        for i=1:w
            for j=1:h
                m=m+double( ((i-x_)^p)*((j-y_)^q)*J(i,j) );
            end
        end
        m_pq(p+1,q+1)=m;
        M(p+1,q+1)=double( m_pq(p+1,q+1)/(S^((p+q)/2+1)) );
    end
end



S1=M(3,1)+M(1,3);
S2=( M(3,1)-M(1,3) )*(M(2+1,0+1)+M(0+1,2+1)) +4*M(1+1,1+1)*M(1+1,1+1);
S3=(M(4,1) -3*M(2,3))^2 +(M(1,4)-3*M(3,2))^2;
S4=(M(4,1)+M(2,3))^2+(M(1,4)+M(3,2))^2;
S5=(M(4,1)-3*M(2,3))*(M(4,1)+M(2,3))*( (M(4,1)+M(2,3))^2 -3*(M(1,4)+M(3,2))^2 )  +(3*M(3,2) -M(1,4))*(M(1,4)+M(3,2))*(3*(M(4,1)+M(2,3))^2-(M(1,4)+M(3,2))^2);
S6=(M(3,1)-M(1,3))*( (M(4,1)+M(2,3))^2 -(M(1,4) +M(3,2)^2) ) +4*M(2,2)*(M(4,1)+M(2,3))*(M(1,4)+M(2,3));
S7=(3*M(3,2)-M(1,4))*(M(4,1) +M(2,3))*( (M(4,1)+M(2,3))^2 -3*(M(1,4)+M(3,2))^2 ) +(M(4,1) -3*M(2,3)*( M(3,2)+M(1,3))*( 3*(M(4,1)+M(2,3))^2 -(M(1,4)+M(3,2))^2 ));
S=[S1 S2 S3 S4 S5 S6 S7];



        
