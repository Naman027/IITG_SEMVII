clear all;
clc;
close all;

disp("Question 3");
geppTime = [];
invTime = [];

for n=200:50:1150
    A = rand(n);
    b = rand(n, 1);
    % Time using GEPP
    tic
    x = A\b;
    time = toc;
    geppTime = [geppTime;time];
    % Inverse time 
    tic
    x = inv(A)*b;
    time = toc;
    invTime = [invTime;time];
end

hold on
semilogy(linspace(200,1150,20), geppTime);
semilogy(linspace(200,1150,20), invTime);
legend('GEPP', 'INV');
xlabel('Matrix Size');
ylabel('Time');
hold off






















