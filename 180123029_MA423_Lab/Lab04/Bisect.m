% Bisect Function
function x = bisect(p,x0,x1,tolerance)
    xmid = (x0+x1)/2;
    Hornerx0 = Horner(p,x0);
    Hornerx1 = Horner(p,x1);
    Hornerxmid = Horner(p,xmid);
    while (Hornerx0*Hornerx1 < 0 && Hornerxmid > tolerance)
        if Hornerxmid*Hornerx0 < 0 
            x1 = xmid;
        else
            x0 = xmid;
        end
        xmid = (x0+x1)/2;
    end
    x = xmid;
end
