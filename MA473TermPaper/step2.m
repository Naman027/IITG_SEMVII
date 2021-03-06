% Function parameters according to their actual notations
% beta = beta(tau_{l-1})
% new_beta = beta(tau_l)
% dS = delta S^n
% s = [ S_i ], i=0,...,M
% P = [ P(tau_{l-1},s) ]
% dt = delta tau 

function [new_beta] = step2(beta, dS, s, P, r, dt, n, sigma, K)
    % step 2-1
    S1 = beta + dS;
    S2 = beta + 2*dS;   
    s_req = s>beta;
    P_tau_l_minus_1 = csapi(s(s_req),P(s_req),[S1; S2]);  % at S1 and S2
    
    P_tau_l_S1 = (1-r*dt)*P_tau_l_minus_1(1) + n*(sigma^2*(n-1)/2+r)*S1*dt*(P_tau_l_minus_1(2)-(K-beta))/(2*(S2-S1)) + (sigma*n*S1)^2/2*(K-beta-2*P_tau_l_minus_1(1)+P_tau_l_minus_1(2))/(S2-S1)^2*dt;
    n3 = P_tau_l_S1;
    n4 = K-S1;
    
    % step 2-2
    Q_tau_l_S1 = sqrt( max ((P_tau_l_S1-(K-S1)),0));
    
    % step 2-3
    Q = Q_tau_l_S1;

    A = n*(sigma^2*(n-1)/2+r);
    B = (A-r)*beta + r*K;
    C = 3*sigma*n*Q*dt;
    
    a = -C*(A-r)^2/(4*B*sqrt(B));
    b = C*(A-r)/sqrt(B) + C*(A-r)^2*beta/(2*B*sqrt(B)) + 5*dt*(A-r) + 2*(A-r)/(sigma*n)^2*(log(S1/beta) + 1 + dt*(A+(sigma*n)^2));
    c = 2*C*sqrt(B) - C*(A-r)*beta/sqrt(B) - C*(A-r)^2*beta^2/(4*B*sqrt(B)) - dt*(4*(A-r)*S1 - 6*r*K) + (2*r*K/(sigma*n)^2)*(log(S1/beta) + 1 + dt*(A+(sigma*n)^2)) - (2*(A-r)*S1/(sigma*n)^2)*(3 + 2*log(S1/beta) + 2*dt*(A+(sigma*n)^2));
    d = -6*r*K*S1*dt - (A-r)*dt*S1^2 - (2*r*K*S1/(sigma*n)^2)*(3 + 2*log(S1/beta) +2*dt*(A+(sigma*n)^2)) + (2*(A-r)*S1^2/(sigma*n)^2)*(3 + log(S1/beta) + dt*(A+(sigma*n)^2));
    e = (2*r*K*S1^2/(sigma*n)^2)*(3 + log(S1/beta) + dt*(A+(sigma*n)^2)) - (2*(A-r)/(sigma*n)^2)*S1^3;
    f = -(2*r*K/(sigma*n)^2)*S1^3;
  
    % Newton method to solve ax^5 + bx^4 + cx^3 + dx^2 + ex + f = 0 to get
    % new_beta. Since new_beta will be close to beta, we use it as starting
    % point
    
    x0 = beta;
    x1 = x0 - (a*x0^5 + b*x0^4 + c*x0^3 + d*x0^2 + e*x0 + f)/(5*a*x0^4 + 4*b*x0^3 + 3*c*x0^2 + 2*d*x0 + e);

    while abs(x1-x0)>10^(-7)
        x0 = x1;
        x1 = x0 - (a*x0^5 + b*x0^4 + c*x0^3 + d*x0^2 + e*x0 + f)/(5*a*x0^4 + 4*b*x0^3 + 3*c*x0^2 + 2*d*x0 + e);
    end
    new_beta = x1;
end