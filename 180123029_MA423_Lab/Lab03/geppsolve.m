%Function for geppSolve
function x = geppsolve(A,b)
    [L,U,p] = gepp(A);
    b = b(p);
    y = rowforward(L,b);
    x = colbackward(U,y);
end


