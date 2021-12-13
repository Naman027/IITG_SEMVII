clear all;
clc;
clear all;

error = zeros(5,1);
Mat_Chol = zeros(5,1);

disp("Question 5");
disp("5 different cases comparing mychol and chol function");
for i = 1:5
    n = input('Input the size of Positive Symmetric Matrix A: ');
    X = rand(n);
    A = X'*X;
    disp('Output for chol function');
    chol(A)
    disp('Output for mychol function');
    mychol(A)
    error(i) = norm(mychol(A) -  chol(A));
    Mat_Chol(i) = i;
end

varnames = ["Test Case No", "Norm Difference"];
T = table(Mat_Chol, error, 'VariableNames', varnames);
disp(T);


