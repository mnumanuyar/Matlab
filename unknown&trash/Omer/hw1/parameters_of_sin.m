function [C,A,f,phi] = parameters_of_sin(fs,x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
m=max(x);
n=min(x);
C = (m+n)/2;
A = (m-n)/2;
i=find(x>(C+A-A/1000),1)*fs;

j=find(x<(C-A+A/1000),1)*fs;
f=1/2*abs(i-j);
phi = i*2*pi*f;

end

