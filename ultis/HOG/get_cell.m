
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
        