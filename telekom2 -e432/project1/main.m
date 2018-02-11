clc
clear
close all
length = 1000; 
 
%perror = zeros(size(p));
%for i = 1: size(p,2)
m=2;
gen = [5,7];
gen2 = [6,3];
rng('shuffle');
x=rand(1,length)>1/2;% 0 or 1 with eual probability
%left first
%x=[1 1 0 0 0;1 1 0 0 0];
%% convolutional encoding 
y = (convEncoder(x,gen));% 0s and 1s
y(y==0)=-1;
y2 = (convEncoder(x,gen2));% 0s and 1s
y2(y2==0)=-1;
%% binary symetric channel
 p=0:0.01:1;
 n = rand (size(y2))>p';% n=0 with p probability
 recived = y.*n + (-y).*(~n);%change if ~n
% %left first
%% AWGN channel
%N0 =[ 0.01 0.1 0.17 0.18 0.19 1  2 ];%hdd
% N0 =[ 0.32 0.34 0.38 0.6 0.7 0.8 0.9 1 1.1 1.2 1.3];%sdd
% n = N0'*randn (size(y));
% recived = n+y;
% N0 =[ 0.32 0.34 0.38 0.6 0.7 0.8 0.9 1 1.1 1.2 1.3];%sdd
% n2 = N0'*randn (size(y2));
% recived2 = n2+y2;
%% 
% recived8= recived;
% recived8([(4:10:end) (5:10:end) (8:10:end) (10:10:end)]) =0;%puncturing to 5/6 -2
% result8 = trellis(recived8,gen,1,[]);
%  
% recived7 = recived;
% recived7([(3:10:end) (6:10:end) (7:10:end) (9:10:end)]) =0;%puncturing to 5/6 -1
% result7 = trellis(recived7,gen,1,[]);
%  
%  
% recived6 = recived;
% recived6([(3:6:end) (6:6:end)]) =0;%puncturing to 3/4
% result6 = trellis(recived6,gen,1,[]);
%  
% recived5 = recived;
% recived5(3:4:end) =0;%puncturing to 2/3
% result5 = trellis(recived5,gen,1,[]);
%  
% result4 = trellis(recived3,gen2,1,[]);%caotic over bsc
% result3 = trellis(recived2,gen2,1,[]);%caotic over awgn
% result2 = trellis(recived,gen,1,[]);%no quantisation
% result1 = trellis(recived,gen,1,[(-1+0.125):0.25:(1-0.125)]);%2 bit quantisation
% result = trellis(recived,gen,1,[-0.75:0.5:0.75]);
result = trellis(recived,gen,0,[]);%hdd
 
perror = sum(abs(result(:,1:end-2)-x),2)/length;
%end
loglog(p,perror);% for BSC
%loglog(1./N0,perror);% Es is always = 1
hold on
BSCUnionBound=((4*p.*(1-p)).^(5/2))./((1-2*sqrt(4*p.*(1-p))).^2);
%HDDUnionBound=((exp((-5/4)*(1./N0)+5*log(2)))./((1-2*exp(-1./(4*N0)+log(2)))).^2);
%SDDUnionBound=((exp((-5/2)*(1./N0)+5*log(2)))./((1-2*exp(-1./(2*N0)+log(2)))).^2);
 
loglog(p,BSCUnionBound);
grid on
function [result] = trellis(recived,gen,sqrtEs,quantisation)
% sqrtEs = 0 if HDD
if(sqrtEs==0) % case is HDD,will work on binary versions
recived(recived>1/2)=1;
recived(recived<=1/2)=0;
elseif(size(quantisation,1)~=0)
    %quantisation only works in SDD
    % will discretize received signal in to closest value in quantisation
    %quantisation is asumed to be ordered, did not know if this work if
    %quantisation is not ordered.
    edges = (quantisation(2:end)+quantisation(1:end-1))/2; % set up the boundary values (aka edges)
    edges = [quantisation(1) edges quantisation(end)];
    % trim the recived down so discretize will not give nan
    recived(recived < edges(1)) = edges(1);
    recived(recived > edges(end)) = edges(end);
    
    recived = discretize (recived,edges,quantisation);
end
n = size(recived,1);
m=size(gen,2);
length=size(recived,2)/m-2;
expected = convEncoder([0 0 0;0 0 1;0 1 0; 0 1 1;1 0 0; 1 0 1; 1 1 0; 1 1 1],gen);
expected = expected(:,m*2 +1:m*3); % these are the expected encoded bits that \
%results in respected trellis state change (first is 0 to 0, 
%second is 1 to 0, third is 2 to 1 forth is 3 to 1 etc.) 
if(sqrtEs ~=0)
    expected(expected==0)=-sqrtEs;%  
    expected(expected==1)=sqrtEs;% 
end
 
winnerpaths= zeros(n,4,(length+2)); % i store all winner paths for 
%debugging and posibly ploting porpouses
inputs = winnerpaths;
weights = repmat([0 10 10 10]*(1+sqrtEs),n,1); % starting wights, 10 represents significantly 
%high weight that would make first 3 starting positions to die out
 
for i = 1:m:m*(length+2) % for every step of the decoding, where  a step is 
    % a colum of the trellis diagram
    
    r_ = recived (:,i:i+m-1); % respected part of the received code for the current step
  
    %w_ = sum(xor(permute(expected,[3,1,2]),permute(repmat(r_,1,1,8),[1,3,2])),3);
    %above code is true for HDD but below code is equally true
     w_ = sum((permute(expected,[3,1,2])-permute(repmat(r_,1,1,8),[1,3,2])).^2,3); % weight changes for this step
   
    % weight changes for this step
    w_ = w_ + [weights weights];
    winnerpaths = [w_(:,1)>=w_(:,2) w_(:,3)>=w_(:,4) w_(:,5)>=w_(:,6) w_(:,7)>=w_(:,8)];
    inputs = winnerpaths.*inputs(:,[2 4 2 4],:) + (~winnerpaths).*inputs(:,[1 3 1 3],:) ;
    inputs(:,:,1+(i-1)/m)=repmat([0 0 1 1],n,1,1);
    weights = ~winnerpaths.*w_(:,1:2:7) + winnerpaths.*w_(:,2:2:8);
end
result= permute(inputs(:,1,:),[1,3,2]);
end
function [y] = convEncoder (x,gen)
% octave generators
%if x is a n by m matrix and gen is 1 by k matrice which represents the 
%type of concolutional encoder in octav then this function encodes every 
%ith row of x according to gen and puts it to ith row of y.
%here y is n by k*(m+2) matrix  
temp = size(x,1);
x1= [zeros(temp,1) zeros(temp,1) x];
x2 = [zeros(temp,1) x zeros(temp,1)];
x3 = [x zeros(temp,1) zeros(temp,1)];
gen = de2bi(gen);
y=zeros(temp,size(x1,2)*size(gen,1));
for i = 1: temp
y_ = xor(xor(gen(:,1)*x1(i,:) , gen(:,2)*x2(i,:)), gen(:,3)*x3(i,:));
y(i,:) = y_(:);
end
end