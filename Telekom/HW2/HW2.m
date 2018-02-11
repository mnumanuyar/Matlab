delete all
close all
clear 
clc;
%%a
A=2;
T=0.05;
t=0:T/25:24*T/25;
bits = randi ([0,1],1,10^6);
s(bits==0)=A;
s(bits==1)=-A;
s = repmat (s,25,1);
figure;
mesh( s(:,1:15));
%for a = [0 5 10]
 %   figure
  %  for i = 1:5
   %     subplot(5,1,i);
    %     plot( t,s(:,a+1:a+5));
    %end
%end
%%b
for sigma = [0.01 5 45 2];
    [ r,Pe,SNR ] = SNRandPE( s,sigma );
    SNR
    figure;
    mesh( r(:,1:15));
end
Pe
Pe = zeros(1,10);
SNR = zeros(1,10);
i=1;
for sigma = 3:1.2:15;
    
    [ r,Pe(i),SNR(i) ] = SNRandPE( s,sigma );
    i = i + 1;
end
semilogy(10*log(SNR),Pe);


%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%part 2
%%%%%%%%%%%%%%%%

SymbolCount = 41667;
f=100;
t=0.25/150:0.25/150:0.25;
bits = randi (64,1,SymbolCount);
b1=sin(2*pi*f*t);
b2=cos(2*pi*f*t);
si = zeros(64,150);

for a = 1:8
    for b = 1:8
        si(b+8*a-8,:) = ((2*a-9)*b1 - (9-2*b)*b2)*sqrt(2/0.25);
    end
end

s = si(bits,:);
%%b

for i =1:6
    subplot(6,1,i)

    plot(t,s(i,:))
end

%mean = 0;
sigma = 20;
noise = sigma*randn(size(s)) ;%+ mean;
r = s + noise;

r1 = sum(r.*repmat(b1,SymbolCount,1),2)/(75*sqrt(2/0.25));
r2 = sum(r.*repmat(b2,SymbolCount,1),2)/(75*sqrt(2/0.25));

figure;
plot(r1(1:100),r2(1:100),'x');
hold;

c1 = sum(si.*repmat(b1,64,1),2)/75;
c2 = sum(si.*repmat(b2,64,1),2)/75;

plot(c1,c2,'xr');
%%c
m1 = discretize(r1,[-inf, -6,-4,-2,0,2,4,6,inf],[-7,-5,-3,-1,1,3,5,7]);
m2 = discretize(r2,[-inf, -6,-4,-2,0,2,4,6,inf],[-7,-5,-3,-1,1,3,5,7]);

s1 = int8(sum(s.*repmat(b1,SymbolCount,1),2)/(75*sqrt(2/0.25)));
s2 = int8(sum(s.*repmat(b2,SymbolCount,1),2)/(75*sqrt(2/0.25)));

Pse =1 - sum(s1==m1&s2==m2)/SymbolCount;

Pbe1=length(find(dec2bin(bitxor(uint8((8*s1-s2+65)/2)-1,uint8((8*m1-m2+65)/2)-1))=='1'))/(SymbolCount*6);
Pbe2=length(find(dec2bin(bitxor(bin2gray(uint8((8*s1-s2+65)/2)-1,'qam',64),bin2gray(uint8((8*m1-m2+65)/2)-1,'qam',64)))=='1'))/(SymbolCount*6);




close all
