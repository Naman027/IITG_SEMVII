function x=SMsolve(A,u,v,m,b)
    A=A-u*v'; 
    x=geppsolve(A,b); 
end

