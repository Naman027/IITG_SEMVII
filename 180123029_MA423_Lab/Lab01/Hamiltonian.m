function HamiltonMat = Hamiltonian(n)
    H_11 = randn(floor(n));
    H_12_lower = tril(randn(n));
    H_12 = H_12_lower + H_12_lower';
    H_21_lower = tril(randn(n));
    H_21 = H_21_lower + H_21_lower';
    HamiltonMat = [H_11 H_12; H_21 -H_11'];
end


