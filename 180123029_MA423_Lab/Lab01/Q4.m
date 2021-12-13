clear all;
clc;
close all;

% Part A
disp("Question 4 a");
n = input('Input size of Upper Triangular Matrix(n): ');
b = randn(n,1);
U = triu(randn(n));
disp('For U =');
disp(U);
disp('For b =');
disp(b);
disp('Solution x using Column Oriented Back substitution = ');
disp(colbackward(U,b));

% Part B
n = input('Input size of Lower Triangular Matrix(n): ');
b = randn(n,1);
L = tril(randn(n));
disp('For L =');
disp(L);
disp('For b =');
disp(b);
disp('Solution x  using Row Oriented Forward substitution = ');
disp(rowforward(L,b));








