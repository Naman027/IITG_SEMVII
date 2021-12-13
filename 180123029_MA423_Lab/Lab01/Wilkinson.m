function WilkinsonMat = Wilkinson(n)
    WilkinsonMat = 2*eye(n) - tril(ones(n));
    WilkinsonMat(:,n) = ones(1, n);
end


