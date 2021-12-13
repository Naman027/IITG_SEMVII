clear all;
clc;
close all;

disp("Question 1 (a)");
A = [10^(-20),1;1,1];
[L,U] = genp(A)
disp('A - L*U = ');
disp(A - L*U);

disp("Question 1 (b)");
b = [1;0];

y = rowforward(L,b);
x = colbackward(U,y);
disp('GENP Solution');
disp(x);

x_actual = A\b;
disp('Actual solution for Ax = b');
disp(x_actual);

fprintf('2-norm difference between GENP and Actual =  %f\n',...
    norm(x_actual - x,2));
















