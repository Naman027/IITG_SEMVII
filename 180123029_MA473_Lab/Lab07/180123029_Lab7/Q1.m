close all; 
clear;

plotNo = 1;

is_terminal = true;

T = 0.2;
K = 100;
r = 0.05;
sig = 0.25;

R_min = 0;
R_max = 1;

h = 0.01;
k = 0.001;
m = (R_max - R_min)/h;
n = ceil(T/k);

R = R_min:h:R_max;
times = 0:k:T;
indices = (0 <= R) & (R < 1);


H = FTCS(T, r, sig, R, times, h, k);
surf(R,times,H');
xlabel('R'); 
ylabel('t');
zlabel('H(R,t)');
title('H(R,t) usiqng FTCS');
saveas(gcf, sprintf('plots/q1_%d.png', plotNo));
plotNo = plotNo + 1;


H = BTCS(T, K, r, sig, R, times, h, k, is_terminal);


figure;
surf(R, times, H); 
xlabel('R');
ylabel('t'); 
zlabel('H(R,t)');
title('H(R,t) using BTCS');
saveas(gcf, sprintf('plots/q1_%d.png', plotNo)); 
plotNo = plotNo + 1;

H = CrankNicolson( T, K, r, sig, R, times, h, k, is_terminal);

figure;
surf(R, times, H); 
xlabel('R');
ylabel('t'); 
zlabel('H(R,t)');
title('H(R,t) using Crank-Nicolson');
saveas(gcf, sprintf('plots/q1_%d.png', plotNo));
plotNo = plotNo + 1;

function [y] = f(R, T)
	temp1 = zeros(size(R));
	temp2 = 1 - R./T;
	y = max([temp1; temp2]);
end

function [U] = FTCS(T, r, sig, R, Tau, h, k)
    m=length(R);
    n=length(Tau);
    
    c1 = @(x) sig^2*x^2/(2*h^2);
    c2 = @(x) (1-r*x)/(2*h);
   
    A=eye(m,m);
    B=A;
    for i=2:m-1
        A(i,i)=1/k;
        A(i,i-1)=0;
        A(i,i+1)=0;
        B(i,i)=1/k+2*c1(R(i));
        B(i,i-1)=-(c1(R(i))-c2(R(i)));
        B(i,i+1)=-(c1(R(i))+c2(R(i)));
    end
    A(2:end-1,:)=A(2:end-1,:)*k;
    B(2:end-1,:)=B(2:end-1,:)*k;
    B(1,1)=1+3*k/(2*h);
    B(1,2)=-2*k/h;
    B(1,3)=k/(2*h);
    U=zeros(m,n);
    U(:,n)=max(1-R/T,0);
    U(m,:)=0;
    for i=n-1:-1:1
        bb=A*U(:,i+1);
        U(:,i)=B\(bb);
    end
    
end

function [y] = fa(sig, R)
	y = sig.^2 .* R.^2 / 2;
end

function [y] = fb(r, R);
	y = 1 - r*R;
end

function [y] = fc(r)
	y = 0;
end

function [U] = BTCS(T, K, r, sig, R, Tau, h, k, isTerminal)
	m = length(R);
	n = length(Tau);
	U = zeros(n, m);

	if isTerminal
		k = -k;
	end

	% Initial Condition
	U(1, 1:end) = f(R, T);

	for i = 2:n
		A = zeros(m, m);
		b = zeros(m, 1);

		aa = fa(sig, R);
		bb = fb(r, R);
		cc = fc(r);

		A(1:m+1:end) = 1 - 2*aa*k/h^2 + cc*k;
		A(2:m+1:end) = aa(2:m)*k/h^2 - bb(2:m)*k/(2*h);
		A(m+1:m+1:end) = aa(1:m-1)*k/h^2 + bb(1:m-1)*k/(2*h);

		A(1,1) = 1 - (3*k)/(2*h);
		A(1,2) = (4*k)/(2*h);
		A(1,3) = (-k)/(2*h);
		% A(1,1) = 1 - k/h;
		% A(1,2) = k/h;
		A(m,m) = 1;
		A(m,m-1) = 0;

		b(2:m-1) = U(i-1,2:m-1);
		b(1) = U(i-1,1);
		b(end) = 0;

		U(i,:) = (A\b)';
	end

	if isTerminal
		U = flipud(U);
	end
end

function [U] = CrankNicolson(T, K, r, sig, R, Tau, h, k, isTerminal)
	m = length(R);
	n = length(Tau);
	U = zeros(n, m);

	if isTerminal
		k = -k;
	end

	% Initial Condition
	U(1, 1:end) = f(R, T);

	for i = 2:n
		A = zeros(m, m);
		b = zeros(m, 1);

		aa = fa(sig, R);
		bb = fb(r, R);
		cc = fc(r);

		A(1:m+1:end) = 2 - 2*aa*k/h^2 + cc*k;
		A(2:m+1:end) = aa(2:m)*k/h^2 - bb(2:m)*k/(2*h);
		A(m+1:m+1:end) = aa(1:m-1)*k/h^2 + bb(1:m-1)*k/(2*h);

		A(1,1) = 1 - (3*k)/(2*h);
		A(1,2) = (4*k)/(2*h);
		A(1,3) = (-k)/(2*h);
		% A(1,1) = 1 - k/h;
		% A(1,2) = k/h;
		A(m,m) = 1;
		A(m,m-1) = 0;

		b(2:m-1) = (-aa(2:m-1)*k/h^2 + bb(2:m-1)*k/(2*h)) .* U(i-1,1:m-2) ...
					+ (2 + 2*aa(2:m-1)*k/h^2 - cc*k) .* U(i-1,2:m-1) ...
					+ (-aa(2:m-1)*k/h^2 - bb(2:m-1)*k/(2*h)) .* U(i-1,3:m);
		b(1) = U(i-1,1);
		b(end) = 0;

		U(i,:) = (A\b)';
	end

	if isTerminal
		U = flipud(U);
	end
end
