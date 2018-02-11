delete all
clear 
clc;

dur = 5;
Ts = dur/4;
type=0;
t = -1*dur/2:Ts/1000:dur/2;
T = -1*dur/2:Ts:dur/2;
g = zeros(size(T,2),1);
% plot(t,generateInterp(0,Ts,dur),'b');
% hold on;
% plot(t,generateInterp(1,Ts,dur),'g');
% hold on;
% plot(t,generateInterp(2,Ts,dur),'r');
% hold on;
% figure
for k = 1 : size(t,2)/1000
    if(T(k) >= -1&& T(k)<0)
        g(k)= -1;
        
    elseif (T(k) >= 0 && T(k)<= 1)
        g(k)= 2;
    end
end
% 
%disp(size(DtoA(type,Ts,dur,g)))
Xn=g;
plot(T,g,'r');
figure;
plot(t,DtoA(2,Ts,dur,Xn));


 
