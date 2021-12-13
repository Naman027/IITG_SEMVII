clear all;
clc;
close all;

disp("Question 3");

x = linspace(1.93,2.08,151);
z1 = (x - 2).^9;
coeff = [1,-18,144,-672,2016,-4032,5376,-4608,2304,-512];
funUsingPoly = [];
for i = x
    funUsingPoly = [funUsingPoly; Horner(coeff,i)];
end

plot(x,funUsingPoly);
xlabel('x');
ylabel('p(x)');
hold on

plot(x,z1);
legend('Horner(p,x)','Direct Formula: (x - 2)^9');
