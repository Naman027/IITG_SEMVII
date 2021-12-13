%Function for mydet(Matrix)
function d = mydet(A)
    [~,U,~,sign] = gepp_with_sign(A);
    d = prod(diag(U))*sign;
end


