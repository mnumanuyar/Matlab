delete all
clear 
clc;
 a = 100000;
U = rand(1,a);
X = (U<=1/2).*(sqrt(2*U)-1)+(U>1/2).*(-1*sqrt(2*(1-U))+1);
histogram(X,'Normalization','pdf');

[ Xq8 ] = UniformQuantizer( X,8 );
[ ErrorVector8, d8,sqnr8  ] = ErrorCalculator( X, Xq8, 'Estimated PDF of Errors of 8 bit uniform quantization of X' );

[ Xq128] = UniformQuantizer( X,128 );
[ ErrorVector128, d128,sqnr128  ] = ErrorCalculator( X, Xq128, 'Estimated PDF of Errors of 128 bit uniform quantization of X' );

[ XqLM8 ] = LloydMaxQuantizer( 8 , X);
[ ErrorVectorLM8, DLM8,sqnrLM8  ] = ErrorCalculator( X, XqLM8, 'Estimated PDF of Errors of 8 bit Llyod-Max quantization of X' );

[  XqLM128 ] = LloydMaxQuantizer( 128 , X);
[ ErrorVectorLM128, DLM128,sqnrLM128  ] = ErrorCalculator( X, XqLM128, 'Estimated PDF of Errors of 128 bit Llyod-Max quantization of X' );

data = importdata('HW.m4a');
data = data.data;

data = data/max(abs(data));
data ((data > -1*10^(-2)) & (data < 1*10^(-2)))= [];
%data ((data > 0.5) | (data < -0.5))= [];
%data = data/max(abs(data));

%part2
[ quantizedSpeech8u] = UniformQuantizer( data,8 );
[ ErrorVector8u, MSE8u ,sqnr8u  ] = ErrorCalculator( data, quantizedSpeech8u , 'Estimated PDF of Errors of 8 bit uniform quantization of speech');


[ quantizedSpeech128u] = UniformQuantizer( data,128 );
[ ErrorVector128u, MSE128u ,sqnr128u  ] = ErrorCalculator( data, quantizedSpeech128u , 'Estimated PDF of Errors of 128 bit uniform quantization of speech');

[ quantizedSpeech8M ] = LloydMaxQuantizer( 8 , data);
[ ErrorVector8M, MSE8M ,sqnr8M  ] = ErrorCalculator( data, quantizedSpeech8M , 'Estimated PDF of Errors of 8 bit Llyod-Max quantization of speech');


[ quantizedSpeech128M ] = LloydMaxQuantizer( 128 , data);
[ ErrorVector128M, MSE128M ,sqnr128M  ] = ErrorCalculator( data, quantizedSpeech128M , 'Estimated PDF of Errors of 128 bit Llyod-Max quantization of speech');





