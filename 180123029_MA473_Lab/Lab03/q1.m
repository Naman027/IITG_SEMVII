clear all;
clc;
close all;

fprintf('Ques 1\n');
Q1();

function Q1
	% Terminal Condition flag
    isTerminal = true;
	plotNo = 1;
    T = 1;
    K = 10;
    r = 0.06;
    sig = 0.3;
    delta = 0;

    S_min = 0;
    S_max = 30;

    h = 1;
    k = h^2/70;
    m = (S_max - S_min)/h;
    n = ceil(T/k);

    S = S_min:h:S_max;
    Time = 0:k:T;

    % Tau = T - t
    U = FTCS(T, K, r, sig, delta, S, Time, h, k, isTerminal);
	% size(Time), size(S), size(U)
	figure; plot(S, U(1, :)); hold on; plot(S, U(end, :)); hold off;
	legend('Cost of option at t = 0', 'Cost of option at t = T'); xlabel('S'); ylabel('u(S, t)'); title('FTCS');
	saveas(gcf, sprintf('plots/q1_%d.png', plotNo)); plotNo = plotNo + 1;
	figure; surf(S, Time, U); xlabel('S'); ylabel('t'); zlabel('u(x,t)'); title('FTCS');
	saveas(gcf, sprintf('plots/q1_%d.png', plotNo)); plotNo = plotNo + 1;
    
    Methods = ["Direct"; "Gauss Seidel"; "Jacobi"; "SOR"];
    for meth = 1:4
        U = BTCS(T, K, r, sig, delta, S, Time, h, k, isTerminal, Methods{meth});
		figure; plot(S, U(1, :)); hold on; plot(S, U(end, :)); hold off;
		legend('Cost of option at t = 0', 'Cost of option at t = T'); xlabel('S'); ylabel('u(S, t)'); title(sprintf('BTCS using %s method', Methods{meth}));
		saveas(gcf, sprintf('plots/q1_%d.png', plotNo)); plotNo = plotNo + 1;
		figure; surf(S, Time, U); xlabel('S'); ylabel('t'); zlabel('u(S,t)'); title(sprintf('BTCS using %s method', Methods{meth}));
		saveas(gcf, sprintf('plots/q1_%d.png', plotNo)); plotNo = plotNo + 1;
    end

    for meth = 1:4  
        U = Crank_Nicolson(T, K, r, sig, delta, S, Time, h, k, isTerminal, Methods{meth});
		figure; plot(S, U(1, :)); hold on; plot(S, U(end, :)); hold off;
		legend('Cost of option at t = 0', 'Cost of option at t = T'); xlabel('S'); ylabel('u(S, t)'); title(sprintf('Crank-Nicolson using %s method', Methods{meth}));
		saveas(gcf, sprintf('plots/q1_%d.png', plotNo)); plotNo = plotNo + 1;
		figure; surf(S, Time, U); xlabel('S'); ylabel('t'); zlabel('u(S,t)'); title(sprintf('Crank-Nicolson using %s method', Methods{meth}));
		saveas(gcf, sprintf('plots/q1_%d.png', plotNo)); plotNo = plotNo + 1;
    end
end

function [y] = f(S, K)
	temp1 = zeros(size(S));
	temp2 = S - K;
	y = max([temp1; temp2]);
end

function [y] = g1(r, s, Tau, K)
	y = 0;
end

function [y] = g2(r, s, Tau, K)
	y = s - K*exp(-r.*Tau);
end


