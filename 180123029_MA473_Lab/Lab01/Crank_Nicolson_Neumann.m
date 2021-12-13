%Function for Crank Nicolson (Neumann)
function [Mat] = Crank_Nicolson_Neumann(h, k, m, n, fun, f, g1, g2)
	lamda = k / h^2;
	%Defined 0x0 matrix Mat
	Mat = zeros(n+1, m+1);
	Mat(1, 1:end) = f((0:m)*h);
	Mat(1:end, 1) = g1((0:n)*k);
	Mat(1:end, end) = g2((0:n)*k);
	for i = 2:n+1
		A = zeros(m+1, m+1);
		b = zeros(m+1, 1);
		A(1:m+2:end) = 1 + lamda;
		A(2:m+2:end) = -lamda/2;
		A(m+2:m+2:end) = -lamda/2;
		A(1,1) = 1;
		A(1,2) = 0;
		A(m+1,m+1) = 1;
		A(m+1,m) = 0;
		b(2:m) = Mat(i-1,1:m-1)*lamda/2 + (1-lamda)*Mat(i-1,2:m) + Mat(i-1,3:m+1)*lamda/2 + k*fun((1:m-1)*h,(i-1)*k);
		b(1) = Mat(i-1,1) + 2*lamda*(Mat(i-1,2) - Mat(i-1,1));
		b(end) = Mat(i,end);
		Mat(i,:) = (A\b)';
	end
	Mat;
end
