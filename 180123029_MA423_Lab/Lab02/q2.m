clear all;
clc;
clear all;

disp("Question 2");
n = input('Give input size of random matrix: ');
format long e;

A = randn(n);
disp("Matrix A");
disp(A);

[L,U,p] = gepp(A);
[L1,U1,p1] = lu(A, 'vector');

disp("A(p,:)-L*U");
disp(A(p,:)-L*U);
disp("norm(A(p,:)-L*U)=");
disp(norm(A(p,:)-L*U));

disp("L-L1");
disp(L-L1);
disp("norm(L-L1)=");
disp(norm(L-L1));

disp("U-U1");
disp(U-U1);
disp("norm(U-U1)=");
disp(norm(U-U1));

disp("p-p1");
disp(p-p1);
disp("norm(p-p1)=");
disp(norm(p-p1));


