function [new_beta] = step2sym(beta, dS, s, P, r, dt, n, sigma, K)
% step 2-1
    S1 = beta + dS;
    S2 = beta + 2*dS;   
    P_tau_l_minus_1 = spline(s,P,[S1; S2]);  % at S1 and S2
    
    P_tau_l_S1 = (1-r*dt)*P_tau_l_minus_1(1) + n*(sigma^2*(n-1)/2+r)*S1*dt*(P_tau_l_minus_1(2)-(K-beta))/(2*(S2-S1)) + (sigma*n*S1)^2/2*(K-beta-2*P_tau_l_minus_1(1)+P_tau_l_minus_1(2))/(S2-S1)^2*dt;
    
    % step 2-2
    Q_tau_l_S1 = sqrt(max(P_tau_l_S1-(K-S1),0));
    
    % step 2-3
    Q = Q_tau_l_S1
    A = n*(sigma^2*(n-1)/2+r);
    B = (A-r)*beta + r*K;
    L = (log(S1/beta)+1-S1/beta)/dt;
    p1 = @(x) sqrt(B)+(A-r)*(x-beta)/(2*sqrt(B))-(A-r)^2*(x-beta)^2/(8*B*sqrt(B));
    p2 = @(x) 6*p1(x)*Q*(sigma*n)^3*x^2+(2*p1(x)^2*(L+A+(sigma*n)^2)-(A-r)*(sigma*n)^2*x)*(S1-x)^2-6*p1(x)^2*(S1-x)*(sigma*n)^2*x;
    new_beta = fzero(@(x) p2(x), beta);
end