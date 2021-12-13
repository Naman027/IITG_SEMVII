%Efficient appreflect function
function B=applreflect(u,gamma,A)
    v=gamma*u;
    w=u'*A;
    C=v*w;
    B=A-C;
end
