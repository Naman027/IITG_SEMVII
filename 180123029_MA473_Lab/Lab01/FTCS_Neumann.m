%Function for FTCS (Neumann)
function [Mat] = FTCS_Neumann(h, k, m, n, fun, f, g1, g2)
	lamda = k / h^2;
	%Defined 0x0 matrix Mat
	Mat = zeros(n+1, m+1);
	Mat(1, 1:end) = f((0:m)*h);
	Mat(1:end, 1) = g1((0:n)*k);
	Mat(1:end, end) = g2((0:n)*k);
	for i = 2:n+1
		Mat(i,1) = Mat(i-1,1) + 2*lamda*(Mat(i-1,2) - Mat(i-1,1));
		for j = 2:m
			t = (i-1)*k;
			x = (j-1)*h;
			Mat(i, j) = lamda*Mat(i-1,j-1) + (1-2*lamda)*Mat(i-1,j) + lamda*Mat(i-1,j+1) + k*fun(x,t);
		end
	end
	Mat;
end
