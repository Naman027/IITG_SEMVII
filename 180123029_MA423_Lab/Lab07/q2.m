close all;
clear;

k=100;
load clown.mat; 

[U, S, V] = svd(X); 
colormap('gray');
image(U(:, 1:k)*S(1:k, 1:k)*V(:,1:k)')

K = 25:5:195;

i = 1;
for k = K
   compression_ratio(i) = 520*k/64000; 
   errors(i) = S(k+1,k+1)/S(1,1);
   i=i+1;
end    

t = table(K', compression_ratio', errors','VariableNames', {'K', 'Compression Ratio', 'Error'});
disp(t);