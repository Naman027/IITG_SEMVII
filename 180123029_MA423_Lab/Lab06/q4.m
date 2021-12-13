clear;
close all;

format;
disp("Question 4");

t = table([],[],[],[],[],[],'VariableNames',{'Matrix Size','norm(A-QR)','norm(Qt*Q - Im)', 'norm(tril(R,-1))', 'norm(Q-Qhat)', 'norm(R-Rhat)'});
for i = 1:10
    m = randi([5, 10]);
    n = m + randi([0, 10]);
    A = rand(n,m);
    [Q_hat, R_hat] = qr(A, 0);
    [Q, R] = reflectQR(A);
    t = [t; {[n, m], norm(A - Q*R, 2), norm(Q'*Q - eye(m)), norm(tril(R,-1)), norm(Q-Q_hat), norm(R-R_hat)}];
end
disp(t);
