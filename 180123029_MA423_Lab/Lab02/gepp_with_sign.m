%Function for gepp with sign
function [L,U,p,sign] = gepp_with_sign(A)
    n = size(A,1);
    p = [1:n];
    sign = 1;
    for k = 1:n-1
        [y,P] = max(abs(A(k:end,k)));
        P = P + k - 1;
        if P ~= k
            sign = sign*-1;
        end
        A([k,P],:) = A([P,k],:);
        p([k,P]) = p([P,k]);
        if A(k,k) ~= 0
            A(k+1:n,k) = A(k+1:n,k)/A(k,k);
        else
            disp('Zero pivot encountered');
            quit;
        end
        A(k+1:n,k+1:n) = A(k+1:n,k+1:n) - A(k+1:n,k)*A(k,k+1:n);
    end
    L = tril(A) - diag(A).*eye(n) + eye(n);
    U = triu(A);
end


