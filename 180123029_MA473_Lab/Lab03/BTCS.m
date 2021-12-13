%Function for BTCS
function [U] = BTCS(f, g1, g2, K, r, sig, delta, S, Tau, h, k, isTerminal, method)
    m = length(S);
	n = length(Tau);
	U = zeros(n, m);
	if isTerminal
		k = -k;
	end
	U(1:end, 1) = g1(r, S(1), Tau, K);
	U(1:end, end) = g2(r, S(end), Tau, K);
	U(1, 1:end) = f(S, K);

	for i = 2:n
		A = zeros(m, m);
		b = zeros(m, 1);
		c1 = sig.^2 .* S.^2 / 2;
		c2 = (r - delta) .* S;
		c3 = -r;
		A(1:m+1:end) = 1 - 2*c1*k/h^2 + c3*k;
		A(2:m+1:end) = c1(2:m)*k/h^2 - c2(2:m)*k/(2*h);
		A(m+1:m+1:end) = c1(1:m-1)*k/h^2 + c2(1:m-1)*k/(2*h);
		A(1,1) = 1;
		A(1,2) = 0;
		A(m,m) = 1;
		A(m,m-1) = 0;
		b(2:m-1) = U(i-1,2:m-1);
		b(1) = U(i,1);
		b(end) = U(i,end);
		if method == "Direct"
			U(i,:) = (A\b)';
		elseif method == "Gauss Seidel"
			U(i,:) = gaussSeidel(A,b,1000,1e-5);
		elseif method == "Jacobi"
			U(i,:) = jacobi(A,b,1000,1e-5);
		else
			U(i,:) = sor(A,b,1000,1e-5);
		end			
	end
    
	if isTerminal
		U = flipud(U);
	end
end

