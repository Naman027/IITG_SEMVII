% Rayleigh function
function [u, v, lambda, p] = rayleigh(A, x, m, tol)
    q = [];
    [~, i] = max(abs(x));
    s = x(i);
    x = x/s;
    q = [q x];
    [Q, H] = hess(A);
    n = size(A,1);
    RHO = q'*H*q/(q'*q);
    p = 1;

    %Iterating for max of m steps
    for j=1:m-1
        [L,U,P] = lu(H - RHO*eye(n));
        b = P*x;
        y = rowforward(L,b);
        x = colbackward(U,y);
        [~,i] = max(abs(x));
        s = x(i);
        x = x/s;
        q = [q x];
        % Checking for the condition
        if(norm(Q(q(end) - q(end-1)) < tol))
            p = 0;
            break
        end
    end
    
    iter = q;
    lambda = 1/s + RHO;
    iter = Q*iter;
    u = iter(end);
    v = iter(end-1); 
end
