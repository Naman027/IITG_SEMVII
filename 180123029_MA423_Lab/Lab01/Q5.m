clear all;
clc;
close all;

n = input('Input size of matrix A: ');
A = randn(n);
disp('Matrix A')
disp('A = ');
disp(A);
[L,U] = genp(A);
disp('L = ');
disp(L);
disp('U = ');
disp(U);
disp('L*U = ');
disp(L*U);









