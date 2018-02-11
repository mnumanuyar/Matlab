function [  Xq ] = LloydMaxQuantizer( Q , X)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Xn =  -1 + 1/(Q) + ((1:Q)-1)/(Q/2);
A = Xn +1/(Q);
Xq = discretize(X,[ -1 A ],Xn);
D = mean((X-Xq).^2);
change = 1;
while(change>0.01)
 for i = 1:Q
     a = sum(X(Xq==Xn(i)))/sum(Xq==Xn(i));
     if ~isnan(a)
         Xn(i) = a;
     end
 end
 
 A(1,1:Q-1)=(Xn(1,1:Q-1) + Xn(1,2:Q))/2;
 Xq = discretize(X,[ -1 A ],Xn);
 change = 1-(mean((X-Xq).^2)/D);
 D = mean((X-Xq).^2);
end

end

