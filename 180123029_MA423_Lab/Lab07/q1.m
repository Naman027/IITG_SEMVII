clear;
close all;

format long e;

f = @(t) sin(pi.*t./5) + (t./5);

t = [-5:0.5:6]';
deg = 18;

A = zeros(size(t,1),deg);

for j=1:deg
   A(:,j) =  t.^(j - 1);
end

b = f(t);

% *************************************************************************
% MATLAB command

p1 = A\b;
r1 = norm(A*p1-b);

% *************************************************************************
% Cholesky Method

G = chol(A'*A);
y = rowforward(G',A'*b);
p2 = colbackward(G,y);
r2 = norm(A*p2-b);

% *************************************************************************
% Augmented system

n = 23;
A_hat = [eye(n),A;A',zeros(deg,deg)];
b_hat = [b;zeros(18,1)];
x_hat = A_hat\b_hat;
p3 = x_hat(24:end);
r3 = norm(x_hat(1:23));

method = ["MATLAB Command"; "Cholesky Factorization"; "Augmented System"];
Condition_numbers = [cond(A,2); cond(A'*A,2); cond(A_hat,2)];
residuals = [r1; r2; r3];
t = table(method, Condition_numbers, residuals,'VariableNames',{'Method','Condition Number of Coefficient Matrix','Residual Norm',});
disp(t);