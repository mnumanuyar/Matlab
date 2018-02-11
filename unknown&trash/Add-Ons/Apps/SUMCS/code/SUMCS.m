function [ xs ] = SUMCS(t,a,omega )
%SUMCS asdasd
%   Detailed explanation goes here
m=a.length;
 xs=0;
for i = 1:m
    xs=xs+a(1,i)*exp(1i*omega(1,i)*t);
             
end

end

