function [s,scf,scb] = semireciprocal(m,k)
   s = 0;
   scf = 0;
   scb = 0;

   % Part a
   for i=1:m
      s = s + 1/i;
   end
    
   % Part b
   for i=1:m
      scf = chop(scf + chop(1/i,k), k);
    end

   % Part c
   for i=m:-1:1
       scb = chop(scb + chop(1/i,k), k);
    end
end


