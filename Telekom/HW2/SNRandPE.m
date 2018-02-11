function [ r,Pe,SNR ] = SNRandPE( s,sigma )
    %mean = 0;
    noise = sigma*randn(size(s)) ;%+ mean;
    r = s + noise;
   
    SNR = sum(sum(r.*r))/sum(sum(noise.*noise));
    %since basis function is a rectengular with same size no need to
    %multiplication. in the end it simplifies to Ml rule as fallowing

    ML = (sum(r)>0)*4-2;
    Pe = (sum(ML~=s(1,:)))/size(s,2);
end

