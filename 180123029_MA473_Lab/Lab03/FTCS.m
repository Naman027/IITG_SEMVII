%function for FTCS
function [U] = FTCS(f, g1, g2, K, r, sig, delta, S, Tau, h, k, isTerminal)
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
		for j = 2:m-1
			c1 = sig^2 .* S(j)^2 / 2;
			c2 = (r - delta) .* S(j);
			c3 = -r;
			U(i, j) = (-c1*k/h^2 + 0.5*c2*k/h)*U(i-1,j-1) + (1 + 2*c1*k/h^2 - c3*k)*U(i-1,j) + (-c1*k/h^2 - 0.5*c2*k/h)*U(i-1,j+1);
		end
	end

	if isTerminal
		U = flipud(U);
	end
end
