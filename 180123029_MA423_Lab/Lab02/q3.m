clear all;
clc;
clear all;

disp("Question 3");
format long e;

n = input('Input size of Matrix A: ');
A = randn(n)
b = randn(n,1)

disp("Matrix A: ");
disp(A);

disp("Matrix B: ");
disp(b);

x = geppsolve(A,b);
disp("Ax = b Solution using geppsolve(A,b)");
disp(x);

x1 = A\b;
disp("Ax = b Solution using A\b");
disp(x1);

disp("Norm of difference = ");
disp(norm(x-x1));
