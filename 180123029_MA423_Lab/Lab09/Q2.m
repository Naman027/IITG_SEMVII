clc;
clear;
close all;

A = [1 1 1;-1 9 2;0 -1 2];
x = [1;1;1];
check_conv(A,x,20);

A = [1 1 1;-1 9 2;-4 -1 2];
check_conv(A,x,20);

A = [1 1 1;-1 3 2;-4 -1 2];
check_conv(A,x,20);

function check_conv(A,x,k)
    [V,D] = eig(A);    
    [D,P] = sort(diag(D),'descend');
    V = V(:,P);
    v = V(:,1);
    lambda1 = D(1);
    lambda2 = D(2);

    [iter,~] = Powermethod(A,x,k);
    actual_conv = norm(iter(:,end) - v)/norm(iter(:,end - 1) - v);
    expected_conv = abs(lambda2/lambda1);
    disp('|Actual Convergence rate - expected convergence rate| = ');
    disp(abs(actual_conv - expected_conv));
end
