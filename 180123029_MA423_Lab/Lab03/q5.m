clear all;
clc;
close all;

disp("Question 5");
N = 20:20:100;
for n = N
    fprintf('<strong> n = %d </strong>\n',n);
    A = randn(n);
    A(1,1) = 50*eps*A(1,1);
    [L,U] = genp(A);
    fprintf('GENP norm(L*U - A): %e\n',norm(L*U - A));
    [L,U,P] = gepp(A);
    fprintf('LU norm(L*U - P*A): %e\n\n',norm(L*U - P*A));
end

