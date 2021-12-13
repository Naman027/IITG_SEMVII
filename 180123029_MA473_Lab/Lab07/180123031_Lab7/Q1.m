clear; clc; 
close all;
format long e;

disp("Question 1");
flag=true;
qn=1;
T=0.2;
K=100;
r=0.05;
sig=0.25;

R0=0;
R1=1;

h=0.01;
k=0.001;
m=(R0-R1)/h;
n=ceil(T/k);

R=R0:h:R1;
Time=0:k:T;
ind=(0<=R)&(R<1);

f=@(R,T) max([zeros(size(R)); 1-R./T]); 
fa=@(R,sig) sig.^2.* R.^2/2;
fb=@(r,R) 1-r*R;
fc=@(x,t,q,qd) 0;

H=ftcs(T,K,r,sig,R,Time,h,k,f,fa,fb,fc,flag);
graph3d(R,H,Time,1,qn,"FTCS");

H=btcs(T,K,r,sig,R,Time,h,k,f,fa,fb,fc,flag);
graph2d(R,H,3,qn,ind,"BTCS");
graph3d(R,H,Time,4,qn,"BTCS");

H=crank_nicolson(T,K,r,sig,R,Time,h,k,f,fa,fb,fc,flag);
graph2d(R,H,5,qn,ind,"Crank Nicolson");
graph3d(R,H,Time,6,qn,"Crank Nicolson");