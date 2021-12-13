%Function of mychol
function G = mychol(A)
    n = size(A,1);
    G = zeros(n,n);
    G(1,1) = sqrt(A(1,1));
    for j=1:n
        sum_1 = 0;
        for k = 1:j-1
            sum_1 = sum_1 + (G(k,j)^2);
        end
        G(j,j) = sqrt(A(j,j) - sum_1);
        for k = j+1:n
            sum_2 = 0;
            for i = 1:j-1
                sum_2 = sum_2 + (G(i,j)*G(i,k));
            end
            G(j,k) = (A(j,k) - sum_2)/G(j,j);
        end
    end    
end


