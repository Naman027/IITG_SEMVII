clear;
close all;
format short e;

A = gallery('kahan',90,1.2,0);

% Part (a)
max_diag_entry = max(diag(A));
min_diag_entry = min(diag(A));
fprintf("Max Diagonal Entry = %e\n", max_diag_entry);
fprintf("Min Diagonal Entry = %e\n\n\n", min_diag_entry);

% Part (b)
sig1 = svd(A);
fprintf('Original Matrix\n');
fprintf('sigma(1,1) = %e\n', sig1(1));
fprintf('sigma(89,89) = %e\n',sig1(89));
fprintf('sigma(90,90) = %e\n',sig1(90));

num_rank_normal = rank(A);
fprintf('Rank of Original Matrix: %d\n\n\n', num_rank_normal);

% Part (c)
A = gallery('kahan',90,1.2,25);
sig2 = svd(A);
fprintf('Perturbed Matrix\n');
fprintf('sigma(1,1) = %e\n', sig2(1));
fprintf('sigma(89,89) = %e\n',sig2(89));
fprintf('sigma(90,90) = %e\n',sig2(90));
num_rank_perturbed = rank(A);
fprintf('Rank of Perturbed Matrix: %d\n\n\n', num_rank_perturbed);

fprintf('Using QR decomposition\n');
[Q,R,E] = qr(A);
dif = norm(eye(90)-E);
fprintf('|| I - E||: %e\n',dif);
fprintf('R(90,90) = %e\n',R(90,90));