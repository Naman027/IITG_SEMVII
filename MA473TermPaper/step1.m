% Sgrids=Asset Price, Pgrids = Price, 
function[P1nxt] = step1(Sgrids,Pgrids,beta,dt,K,r,sig,n)
dS = Sgrids(1,2)-Sgrids(1,1);
S1=beta+dS;
S2=S1+dS;
if ~any(Sgrids(1,:)==beta)
j = 1+ceil((beta-Sgrids(1,1))/dS);
arr = spline([beta,Sgrids(1,j:j+2)],[K-beta,Pgrids(1,j:j+2)],[S1,S2]);
P1 = arr(1,1); 
P2 = arr(1,2);
else
    j = 1+(beta-Sgrids(1,1))/dS;
    P1 = Pgrids(1,j+1);
    P2 = Pgrids(1,j+2);
end
%% Explicit FD
dP_by_dS = (P2-(K-beta))/(2*dS);
d2P_by_dS2= (P2-2*P1+(K-beta))/dS^2; 
P1nxt = (1-r*dt)*P1+n*(r+0.5*sig^2*(n-1))*S1*dP_by_dS*dt + 0.5*(sig*n*S1)^2*d2P_by_dS2*dt; 
end