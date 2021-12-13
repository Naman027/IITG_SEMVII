% Function for reflectQR
function [Q,R] = reflectQR(A)
    [n,m]=size(A);    
    
    g=zeros(m,1);
    Q = zeros(n,m);
    In = eye(n);
    
    for i=1:m
    
        if(i~=n)   
            x=A(i:n,i);
            [u,gamma,t]=reflect(x);
            g(i)=gamma;
            A(i+1:n,i) = u(2:end);
            A(i:n,i+1:m)=applreflect(u,gamma,A(i:n,i+1:m));
            A(i,i)=-t;
        end
        
        tmp = In(:,i);
        
        for j=i:-1:1
            u = [1,A(j+1:end, j)']';
            gamma = g(j);
            tmp(j:end) = applreflect(u,gamma,tmp(j:end));
        end
        
        Q(1:end,i) = tmp;
    end
    
    R = triu(A);
    R = R(1:m,:);

end
