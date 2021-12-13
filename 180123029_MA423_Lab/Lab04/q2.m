clear all;
clc;
close all;

disp("Question 2");

coeff = [1, -18, 144, -672, 2016, -4032, 5376, -4608, 2304, -512];
low = 1.97;
high = 2.04;
tolerance = 1e-6;
fprintf("%.6f\n", Bisect(coeff, low, high, tolerance));
