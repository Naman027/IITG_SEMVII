% Q1 reflect function
function [u,gamma,t]=reflect(x)
    curx=x(1);
    if curx<0
        sign=-1;
    else
        sign=1;
    end
    t = sign*norm(x,2);
    y = zeros(size(x,1),1);
    y(1)=-t;
    u = (x-y)/(curx+t);
    gamma = (t+curx)/t;
end