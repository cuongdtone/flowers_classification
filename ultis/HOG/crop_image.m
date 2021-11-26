function J =crop_image(I)
%crop boundingbox of object
[w,h]=size(I);
x_min=1;
y_min=1;
x_max=w;
y_max=h;
i=1;
j=1;
while I(i,:)==0
    i=i+1;
    x_min=i;
end
while I(:,j)==0
    j=j+1;
    y_min=j;
end
while I(w,:)==0
    w=w-1;
    x_max=w;
end

while I(:,h)==0
    h=h-1;
    y_max=h;
end

J=I(x_min:x_max,y_min:y_max);


    

            
                    
