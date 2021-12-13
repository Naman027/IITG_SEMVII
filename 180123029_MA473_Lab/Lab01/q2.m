clear all;
clc;
close all;

fprintf('Ques 2\n');
fprintf('for f(x) = sin(pi*x)\n');
Q2_1();
fprintf('f(x) = x*(1-x)\n');
Q2_2();

function Q2_1()
	h = 0.025;
	k = 0.0025;
	m = 1/h;
	n = 4;
	X = (0:n)*k;
	Y = (0:m)*h;

	%Forward Time Centre Space
	fprintf('FTCS Plot\n');
	Mat = FTCS(h, k, m, n, @fun, @f1, @g1, @g2);
	figure; 
	plot(Y, Mat(end, :)); xlabel('x'); ylabel('f(x, T)'); title('FTCS');
	figure; 
	surf(X, Y, Mat'); xlabel('t'); ylabel('x'); zlabel('f(t,x)'); title('FTCS');

	%Backward Time Center Space
	fprintf('BTCS Plot\n');
	Mat = BTCS(h, k, m, n, @fun, @f1, @g1, @g2);
	figure; 
	plot(Y, Mat(end, :)); xlabel('x'); ylabel('f(x, T)'); title('BTCS');
	figure; 
	surf(X, Y, Mat'); xlabel('t'); ylabel('x'); zlabel('f(t,x)'); title('BTCS');

	fprintf('Crank Nicolson Plot\n');
	Mat = Crank_Nicolson(h, k, m, n, @fun, @f1, @g1, @g2);
	figure; 
	plot(Y, Mat(end, :)); xlabel('x'); ylabel('f(x, T)'); title('Crank Nicolson');
	figure; 
	surf(X, Y, Mat'); xlabel('t'); ylabel('x'); zlabel('f(t,x)'); title('Crank Nicolson');
end

function Q2_2()
	h = 0.025;
	k = 0.0025;
	m = 1/h;
	n = 4;
	X = (0:n)*k;
	Y = (0:m)*h;

	%Forward Time Centre Space
	fprintf('FTCS Plot\n');
	Mat = FTCS(h, k, m, n, @fun, @f2, @g1, @g2);
	figure; 
	plot(Y, Mat(end, :)); xlabel('x'); ylabel('f(x, T)'); title('FTCS');
	figure; 
	surf(X, Y, Mat'); xlabel('t'); ylabel('x'); zlabel('f(t,x)'); title('FTCS');

	%Backward Time Center Space
	fprintf('BTCS Plot\n');
	Mat = BTCS(h, k, m, n, @fun, @f2, @g1, @g2);
	figure; 
	plot(Y, Mat(end, :)); xlabel('x'); ylabel('f(x, T)'); title('BTCS');
	figure; 
	surf(X, Y, Mat'); xlabel('t'); ylabel('x'); zlabel('f(t,x)'); title('BTCS');

	fprintf('Crank Nicolson Plot\n');
	Mat = Crank_Nicolson(h, k, m, n, @fun, @f2, @g1, @g2);
	figure; 
	plot(Y, Mat(end, :)); xlabel('x'); ylabel('f(x, T)'); title('Crank Nicolson');
	figure; 
	surf(X, Y, Mat'); xlabel('t'); ylabel('x'); zlabel('f(t,x)'); title('Crank Nicolson');
end

function [y] = fun(x, t)
	y = 0;
end

function [y] = f1(x)
	y = sin(pi*x);
end

function [y] = f2(x)
	y = x.*(1-x);
end

function [y] = g1(t)
	y = 0;
end

function [y] = g2(t)
	y = 0;
end