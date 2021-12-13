%Function for rowforward
function b = rowforward(L,b)
    n = size(L,1);
    for k=1:n
       for j=1:k-1
          b(k) = b(k) - L(k,j)*b(j);
       end
         
       if L(k,k) ~= 0
          b(k) = b(k)/L(k,k);
       else
          disp('Matrix is singular');
          quit;
       end
    end
 end 
 