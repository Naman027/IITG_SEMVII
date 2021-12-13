clear all;
clc;
close all;

disp("Question 4");
N = 32:32:64;
for n = N
   fprintf('<strong> n = %d</strong>\n',n);
   x = randn(n,1);
   W = Wilkinson(n);
   b = W*x;
   xhat = geppsolve(W,b);
   r = W*xhat - b;
   fprintf('forward error norm(x - xhat,inf)/norm(x,inf): %e\n',...
       norm(x - xhat,inf)/norm(x,inf));
   fprintf('cond(W): %e\n', cond(W));
   fprintf('norm(r,inf)/norm(b,inf): %e\n',norm(r,inf)/norm(b,inf));
   fprintf('\nQR method\n');
   [Q,R] = qr(W);
   xhat = colbackward(R,Q'*b);
   r = W*xhat - b;
   fprintf('forward error norm(x - xhat,inf)/norm(x,inf): %e\n',...
       norm(x - xhat,inf)/norm(x,inf));
   fprintf('cond(W): %e\n', cond(W));
   fprintf('norm(r,inf)/norm(b,inf): %e\n',norm(r,inf)/norm(b,inf));
   fprintf('-------------------------------------------------\n');
end
