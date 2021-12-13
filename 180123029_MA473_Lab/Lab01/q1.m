clear all;
clc;
close all;

fprintf('Ques 1\n');
Q1();

function Q1()
    h = 0.025;
    k = 0.05;
    m = 1/h;
	n = 4;
    X = (0:n)*k;
    Y = (0:m)*h;
	
	%Forward Time Centre Space
	fprintf('FTCS Plot\n');
	Mat = FTCS(h, k, m, 4, @fun, @f, @g1, @g2);
	figure; 
	surf(X, Y, Mat'); xlabel('t'); ylabel('x'); zlabel('f(t,x)'); title('FTCS');

	%Backward Time Center Space
	fprintf('BTCS Plot\n');
	Mat = BTCS(h, k, m, 4, @fun, @f, @g1, @g2);
	figure; 
	surf(X, Y, Mat'); xlabel('t'); ylabel('x'); zlabel('f(t,x)'); title('BTCS');
	
	fprintf('Crank Nicolson Plot\n');
	Mat = Crank_Nicolson(h, k, m, 4, @fun, @f, @g1, @g2);
	figure; 
	surf(X, Y, Mat'); xlabel('t'); ylabel('x'); zlabel('f(t,x)'); title('Crank-Nicolson');
end

function [y] = fun(x, t)
	y =  sin(4*pi*t) .* sin(2*pi*x);
end

function [y] = f(x)
	y = 0;
end

function [y] = g1(t)
	y = 0;
end

function [y] = g2(t)
	y = 0;
end


