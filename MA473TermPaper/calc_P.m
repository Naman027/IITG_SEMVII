% P(j,l) is price for s(j) at tou(l) 
% y= P(j:M,l) when calculated for tou(l)
% M=no of spatial steps

function y=calc_P(beta, s, l, M, sigma, r, n, del_tou, K, P)
    j=1;
    del_S = s(j+1)-s(j);
    while(s(j)<=beta)
        j=j+1;
    end
    
    coeff1=0.5*(sigma*n*s(j))^2;
    coeff2=n*(0.5*(n-1)*sigma^2+r);
    a(1)=-(coeff1*del_tou)/(del_S*(s(j)-beta))+(coeff2*del_tou*s(j))/(2*(s(j)-beta));
    b(1)=1+r*del_tou-(coeff2*del_tou*s(j))*(del_S-s(j)+beta)/(2*del_S*(s(j)-beta))+(coeff1*del_tou)*(s(j)-beta+del_S)/((s(j)-beta)*del_S^2);
    c(1)=-(coeff2*del_tou*s(j))/(2*del_S)-coeff1*del_tou/(del_S^2);
    
    
    for i=2:M-j+1        
        mu=coeff2*del_tou*s(j+i-1)/2*del_S;
        lamda=(sigma*n)^2*del_tou*((s(j+i-1))^2)/(2*(del_S^2));
        
        if i==M-j+1
            a(M-j+1)=2*mu;
            b(M-j+1)=1+r*del_tou-2*mu;
            break;
        end
        a(i)=mu-lamda;
        b(i)=(1+r*del_tou)+2*lamda;
        c(i)=-(mu+lamda);
    end
    A=zeros(M-j+2,M-j+2);
    B=zeros(M-j+2,1);
    A(1,1)=1;
    B(1)=K-beta;
    for i=2:M-j+2
        B(i)=P(j+i-2,1);
        if i==M-j+2
            A(i,i-1)=a(i-1);
            A(i,i)=b(i-1);
            break
        end
        A(i,i-1)=a(i-1);
        A(i,i)=b(i-1);
        A(i,i+1)=c(i-1);
    end
    y=A\B;
    y = [K-s(1:j-1);y(2:end)];
end








