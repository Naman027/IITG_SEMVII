clear all;
clc;
close all;

fprintf('Ques 3\n');
Q3();

function Q3()
	h = 0.10;
	k = 0.005;
	m = 1/h;
	n = 20;
	X = (0:n)*k;
	Y = (0:m)*h;
	
	%Forward Time Centre Space
	fprintf('FTCS with Neumann Plot\n');
	Mat = FTCS_Neumann(h, k, m, n, @fun, @f, @g1, @g2);
	figure; 
	plot(Y, Mat(end, :)); xlabel('x'); ylabel('u(x, T)'); title('FTCS');
	figure; 
	surf(X, Y, Mat'); xlabel('t'); ylabel('x'); zlabel('u(t,x)'); title('FTCS');
	
	%Backward Time Center Space
	fprintf('BTCS with Neumann Plot\n');
	Mat = BTCS_Neumann(h, k, m, n, @fun, @f, @g1, @g2);
	figure; 
	plot(Y, Mat(end, :)); xlabel('x'); ylabel('f(x, T)'); title('BTCS');
	figure; 
	surf(X, Y, Mat'); xlabel('t'); ylabel('x'); zlabel('u(t,x)'); title('BTCS');

	fprintf('Crank Nicolson with Neumann Plot\n');
	Mat = Crank_Nicolson_Neumann(h, k, m, n, @fun, @f, @g1, @g2);
	figure; 
	plot(Y, Mat(end, :)); xlabel('x'); ylabel('u(x, T)'); title('Crank-Nicolson');
	figure; 
	surf(X, Y, Mat'); xlabel('t'); ylabel('x'); zlabel('u(t,x)'); title('Crank-Nicolson');
end

function [y] = fun(x, t)
	y = 0;
end

function [y] = f(x)
	y = cos(pi*x/2);
end

function [y] = g1(t)
	y = 0;
end

function [y] = g2(t)
	y = 0;
end


