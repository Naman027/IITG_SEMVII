clear all;
clc;
close all;

fprintf('Ques 4\n');
Q4();

function Q4()
	h = 0.3;
	k = 0.05;
	m = 1;
	n = 4;
	X = (0:n)*k;
	Y = (0:m)*h;
	
	fprintf('Crank Nicolson Plot\n');
	Mat = Crank_Nicolson(h, k, m, n, @fun, @f, @g1, @g2);
	figure; 
	plot(Y, Mat(end, :)); xlabel('x'); ylabel('u(x, T)'); title('Crank-Nicolson');
	figure; 
	surf(X, Y, Mat'); xlabel('t'); ylabel('x'); zlabel('u(t,x)'); title('Crank-Nicolson');
end
	
function [y] = fun(x, t)
	y = 0;
end

function [y] = f(x)
	y = x.*(1-x);
end

function [y] = g1(t)
	y = 0;
end

function [y] = g2(t)
	y = t.^2;
end
