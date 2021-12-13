clear all;
clc;
close all;

disp("Question 1");

function [Q,R] = qrtridiag((H)
    n = length(H);
    V = zeros(2,n-1);
    g = zeros(n-1,1);
    
    for j = 1:n-1
        % -- Find W_j = I-2vv’ to put zero into H(j+1,j)
        u = H(j:j+1,j);
        x1 = u(1);
        tau = sign(u(1))*norm(u);
        g(j) =  1/((tau + x1)*(tau));
        u(1) = u(1) + tau;
        V(:,j) = u;
        v = u/norm(u);
        H(j:j+1,:) = H(j:j+1,:)-2*v*(v'*H(j:j+1,:));
    end
   
    R = H;
    Q = eye(n,n);
    for i=1:n
        for j=min(i,n-1):-1:1
            Q(j:j+1,i) = applreflect(V(:,j),g(j),Q(j:j+1,i));
        end
    end
 end
 











