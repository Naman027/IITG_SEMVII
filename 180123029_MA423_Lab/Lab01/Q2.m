clear all;
clc;
close all;

disp("Question 2");
m = 1000;
k = 5;
[s,scf,scb] = semireciprocal(m,k);
fprintf("s : %0.5f\nscf : %0.5f\nscb : %0.5f\n",s,scf,scb);

if scf == scb
   disp("Both (b) and (c) are equal from (a)")
elseif abs(s-scf)<abs(s-scb)
   disp("(b) is more closer to (a) than (c)")
else
   disp("(c) is more closer to (a) than (b)")
end




