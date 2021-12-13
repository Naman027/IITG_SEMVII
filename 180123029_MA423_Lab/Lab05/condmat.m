function A = condmat(n,kappa)
    D = [];
    for i=1:n
       D = [D;kappa^((i-1)/(n-1))]; 
    end
    D = diag(D);
    X = randn(n,n);
    [U,R] = qr(X);
    A = U*D*U';
end
