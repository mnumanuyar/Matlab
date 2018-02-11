function [ ErrorVector, MSE ,sqnr  ] = ErrorCalculator( u, uq,theTitle )
%ERRORCALCULATOR Summary of this function goes here
%   Detailed explanation goes here
ErrorVector = u-uq;
MSE = mean(ErrorVector.*ErrorVector);
P = mean(u.^2);
sqnr = P/MSE;
figure;
a=histogram(ErrorVector,'Normalization','pdf');
title ( theTitle );
saveas(a, [theTitle,'.png'],'png');

end

