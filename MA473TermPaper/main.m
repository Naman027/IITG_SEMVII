clc
clear all
close all
%Set 1: 
K=100; r=0.1; sig=0.3; T=1; Nsp = 500; Nt=2000; Smx = 200; n=1;
Sarr = linspace(0,Smx,Nsp+1); Sarr=Sarr'; dS = Smx/Nsp;
Tarr = linspace(0,T,Nt+1); Tarr=Tarr'; dt = T/Nt;
betaarr = zeros(size(Tarr));
Price = max(K-Sarr,0);
beta = K;
betaarr(1,1) = beta;
for j=2:Nt+1
    beta = step2(beta,dS,Sarr,Price,r,dt,n,sig,K);
    betaarr(j,1) = beta;
    Price = calc_P(beta,Sarr,j,Nsp+1,sig, r, n,dt,K,Price);
end

Qarr = sqrt(Price-(K-Sarr));
pic=figure(1); hold on;
plot(Sarr, Price,'LineWidth',1); 
plot(Sarr,max(K-Sarr,0),'k-.');
plot(Sarr,Qarr,'r','LineWidth',1);
title('American power put price vs asset price for n=1')
legend('American put price', 'payoff', 'Transformed Function')
hold off;
saveas(pic,'plots/set1fig1','epsc');

pic=figure(2);
plot(Tarr, betaarr,'LineWidth',1);
title('Optimal boundary condition for n=1')
saveas(pic,'plots/set1fig2','epsc');

% Set 2: 
clear Sarr Tarr betaarr Price dS n
K=100; r=0.08; sig=0.1; T=0.5; Nsp = 300; Nt=2000; Smx=300;
Sarr = linspace(0,Smx,Nsp+1); Sarr=Sarr'; dS = Smx/Nsp;
Tarr = linspace(0,T,Nt+1); Tarr=Tarr'; dt = T/Nt;
N=(2:1:5);
beta=K;
betaarr = zeros(length(Tarr),4);

betaarr(1,:)=ones(1,4)*beta;
Price=zeros(length(Sarr),4);

for n=N
    Price(:,n-1)=max(K-Sarr,0);
end

for n=N
    for j=2:Nt+1
        beta = step2(beta,dS,Sarr,Price(:,n-1),r,dt,n,sig,K);
        betaarr(j,n-1) = beta;
        Price(:,n-1) = calc_P(beta,Sarr,j,Nsp+1,sig, r, n,dt,K,Price(:,n-1));
    end
end
pic=figure(3)
plot(Sarr,max(K-Sarr,0),'k-.');
for n=N
    hold on;
    plot(Sarr, Price(:,n-1),'LineWidth',1);
end
title('Price of option vs asset price and Payoff vs asset price')
legend('Payoff', 'Price for n=2', 'Price for n=3', 'Price for n=4', 'Price for n=5')
hold off
saveas(pic,'plots/set2fig1','epsc');
pic=figure(4)
for n=N
    plot(Tarr, betaarr(:,n-1),'LineWidth',1);
    hold on;
    title('Optimal boundary condition')
end
title('Optimal exercise boundary for different values of n')
legend('n=2','n=3','n=4','n=5');
hold off;
saveas(pic,'plots/set2fig2','epsc');