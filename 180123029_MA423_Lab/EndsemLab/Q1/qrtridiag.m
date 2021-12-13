% Function for qrtridiag
function [Q,R] = qrtridiag(H)
    m = size(A,2);
    n = size(A,1);
    if m == n
        p = n-1;
    else
       p = m;
    end
    g = zeros(p,1);
    U = zeros(n,p);
    track=zeros(p,1);
    info1=zeros(p,1);
    info2=zeros(p,1);
    for i=1:p
        if A(i,i)^2+A(i+1,i)^2==0
           track(i,1)=1;
        end
        [temp1,temp2,gam,tau] = reflect(A(i,i),A(i+1,i));
        info1(i,1)=temp1;
        info2(i,1)=temp2;
        g(i) = gam;
        U(i:end,i) = u;
        A(i,i) = -tau;
        A(i:i+1,i+1:i+2) = applreflect(temp1,temp2,gam,A(i:i+1,i+1:i+2));
    end
  
    Q = eye(n);
    for i=1:n
        for j=min(i,p):-1:1
            if (track(j,1)==1)
               continue;
            end
            Q(j:j+1,i) = applreflect(info1(j,1),info2(j,1),g(j),Q(j:j+1,i));
        end
    end
    R = triu(A)
end