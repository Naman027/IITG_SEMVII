clear all;
clc;
close all;

fprintf('Ques 1\n');
Q1();

function Q1
    plotNo = 1;
    % Terminal Condition flag
    isTerminal = true;

    T = 1;
    r = 0.04;
    sig = 0.25;
    delta = 0.1;
    P = 1;

    % Boundary
    eta_min = 0;
    eta_max = 1; 

    h = 0.01;
    k = h/2;
    m = (eta_max - eta_min)/h;
    n = ceil(T/k);

    Eta = eta_min:h:eta_max;
    Time = 0:k:T;

    % Tau = T - t
    U = FTCS(T, r, sig, delta, Eta, Time, h, k);
    [S, Time, U] = transform_back(Eta, Time, U, P, T);
    figure; plot(S, U(1, :)); hold on; plot(S, U(end, :)); hold off;
    legend('Cost of call option at t = 0', 'Cost of call option at t = T'); xlabel('S'); ylabel('u(S, t)'); title('FTCS');
    saveas(gcf, sprintf('plots/q1_%d.png', plotNo)); plotNo = plotNo + 1;
    figure; surf(S, Time, U); xlabel('S'); ylabel('t'); zlabel('u(x,t)'); title('FTCS');
    saveas(gcf, sprintf('plots/q1_%d.png', plotNo)); plotNo = plotNo + 1;
    
    Methods = {'Matlab Back-Slash', 'Gauss-Seidel', 'Jacobi', 'SOR', 'CG'};
    for meth = 1:5
        U = BTCS(T, r, sig, delta, Eta, Time, h, k, Methods{meth});
        [S, Time, U] = transform_back(Eta, Time, U, P, T);
        figure; plot(S, U(1, :)); hold on; plot(S, U(end, :)); hold off;
        legend('Cost of call option at t = 0', 'Cost of call option at t = T'); xlabel('S'); ylabel('u(S, t)'); title(sprintf('BTCS using %s method', Methods{meth}));
        saveas(gcf, sprintf('plots/q1_%d.png', plotNo)); plotNo = plotNo + 1;
        figure; surf(S, Time, U); xlabel('S'); ylabel('t'); zlabel('u(S,t)'); title(sprintf('BTCS using %s method', Methods{meth}));
        saveas(gcf, sprintf('plots/q1_%d.png', plotNo)); plotNo = plotNo + 1;
    end

    for meth = 1:5
        U = Crank_Nicolson(T, r, sig, delta, Eta, Time, h, k, Methods{meth});
        [S, Time, U] = transform_back(Eta, Time, U, P, T);
        figure; plot(S, U(1, :)); hold on; plot(S, U(end, :)); hold off;
        legend('Cost of call option at t = 0', 'Cost of call option at t = T'); xlabel('S'); ylabel('u(S, t)'); title(sprintf('Crank-Nicolson using %s method', Methods{meth}));
        saveas(gcf, sprintf('plots/q1_%d.png', plotNo)); plotNo = plotNo + 1;
        figure; surf(S, Time, U); xlabel('S'); ylabel('t'); zlabel('u(S,t)'); title(sprintf('Crank-Nicolson using %s method', Methods{meth}));
        saveas(gcf, sprintf('plots/q1_%d.png', plotNo)); plotNo = plotNo + 1;
    end
end

function [y] = f(Eta)
	temp1 = zeros(size(Eta));
	temp2 = 2*Eta - 1;
	y = max([temp1; temp2]);
end

function [y] = g1(r, Tau)
	y = f(0) * exp(-r*Tau);
end

function [y] = g2(delta, Tau)
	y = f(1) * exp(-delta*Tau);
end

function [y] = fa(sig, eta)
	y = - sig.^2 .* eta.^2 .* (1 - eta.^2) / 2;
end

function [y] = fb(r, delta, eta);
	y = - (r - delta) .* eta .* (1 - eta);
end

function [y] = fc(r, delta, eta)
	y = r*(1 - eta) + delta*eta;
end

function [S, Time, U] = transform_back(Eta, Tau, U, P, T)
	S = P*Eta ./ (1 - Eta);
	m = sum(S < 4);
	S = S(1:m);
	U = U(:, 1:m);
	Time = Tau;
	U = flipud(U);
	U = (S + P) .* U;
end

%Function for Crank Nicolson
function [U] = Crank_Nicolson(T, r, sig, delta, Eta, Tau, h, k, method)
	fprintf('Running Crank Nicolson\n');
	fprintf('Using %s method\n', method);
	m = length(Eta);
	n = length(Tau);
	U = zeros(n, m);
	U(1:end, 1) = g1(r, Tau);
	U(1:end, end) = g2(delta, Tau);
	U(1, 1:end) = f(Eta);

	for i = 2:n
		A = zeros(m, m);
		b = zeros(m, 1);
		aa = fa(sig, Eta);
		bb = fb(r, delta, Eta);
		cc = fc(r, delta, Eta);
		A(1:m+1:end) = 2 - 2*aa*k/h^2 + cc*k;
		A(2:m+1:end) = aa(2:m)*k/h^2 - bb(2:m)*k/(2*h);
		A(m+1:m+1:end) = aa(1:m-1)*k/h^2 + bb(1:m-1)*k/(2*h);
		A(1,1) = 1;
		A(1,2) = 0;
		A(m,m) = 1;
		A(m,m-1) = 0;
		b(2:m-1) = (-aa(2:m-1)*k/h^2 + bb(2:m-1)*k/(2*h)) .* U(i-1,1:m-2) ...
					+ (2 + 2*aa(2:m-1)*k/h^2 - cc(2:m-1)*k) .* U(i-1,2:m-1) ...
					+ (-aa(2:m-1)*k/h^2 - bb(2:m-1)*k/(2*h)) .* U(i-1,3:m);
		b(1) = U(i,1);
		b(end) = U(i,end);
		if method(1) == 'B'
			U(i,:) = (A\b)';
		elseif method(1) == 'G'
			U(i,:) = gaussSiedel(A,b,1000,1e-5);
		elseif method(1) == 'J'
			U(i,:) = jacobi(A,b,1000,1e-5);
        elseif method == 'S'
			U(i,:) = sor(A,b,1000,1e-5);
        else
            U(i,:) = cg(A,b,1000,1e-5);
		end	
	end
end

%Function for FTCS
function [U] = FTCS(T, r, sig, delta, Eta, Tau, h, k)
	fprintf('Running FTCS\n');
	m = length(Eta);
	n = length(Tau);
	U = zeros(n, m);
	U(1:end, 1) = g1(r, Tau);
	U(1:end, end) = g2(delta, Tau);
	U(1, 1:end) = f(Eta);

	for i = 2:n
		for j = 2:m-1
			aa = fa(sig, Eta(j));
			bb = fb(r, delta, Eta(j));
			cc = fc(r, delta, Eta(j));
			U(i, j) = (-aa*k/h^2 + 0.5*bb*k/h)*U(i-1,j-1) + (1 + 2*aa*k/h^2 - cc*k)*U(i-1,j) + (-aa*k/h^2 - 0.5*bb*k/h)*U(i-1,j+1);
		end
	end
end

%Function for BTCS
function [U] = BTCS(T, r, sig, delta, Eta, Tau, h, k, method)
	fprintf('Running BTCS\n');
	fprintf('Using %s method\n', method);
	m = length(Eta);
	n = length(Tau);
	U = zeros(n, m);
	U(1:end, 1) = g1(r, Tau);
	U(1:end, end) = g2(delta, Tau);
	U(1, 1:end) = f(Eta);

	for i = 2:n
		A = zeros(m, m);
		b = zeros(m, 1);
		aa = fa(sig, Eta);
		bb = fb(r, delta, Eta);
		cc = fc(r, delta, Eta);
		A(1:m+1:end) = 1 - 2*aa*k/h^2 + cc*k;
		A(2:m+1:end) = aa(2:m)*k/h^2 - bb(2:m)*k/(2*h);
		A(m+1:m+1:end) = aa(1:m-1)*k/h^2 + bb(1:m-1)*k/(2*h);
		A(1,1) = 1;
		A(1,2) = 0;
		A(m,m) = 1;
		A(m,m-1) = 0;
		b(2:m-1) = U(i-1,2:m-1);
		b(1) = U(i,1);
		b(end) = U(i,end);
		if method(1) == 'B'
			U(i,:) = (A\b)';
		elseif method(1) == 'G'
			U(i,:) = gaussSiedel(A,b,1000,1e-5);
		elseif method(1) == 'J'
			U(i,:) = jacobi(A,b,1000,1e-5);
        elseif method == 'S'
			U(i,:) = sor(A,b,1000,1e-5);
        else
            U(i,:) = cg(A,b,1000,1e-5);
		end				
	end
end

