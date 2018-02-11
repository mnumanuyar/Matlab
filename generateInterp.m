function [ p ] = generateInterp(type,Ts,dur)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

t = -1*dur/2:Ts/1000:dur/2;
p = zeros(1,dur*1000/Ts+1);

if(type ==0)
    for k = 1: dur*1000/Ts+1
       if(t(k)/Ts >= -1/2 && t(k)/Ts < 1/2)
        p(k)= 1;
       end
    end
elseif (type==1)
    for k = 1: dur*1000/Ts+1
       if(t(k)/(2*Ts) >= -1/2 && t(k)/(2*Ts) <= 1/2)
        p(k)= 1-abs(t(k))/Ts;
       end
    end
elseif (type==2)
        for k = 1: dur*1000/Ts+1
            if(t(k) == 0)
               p(k)= 1;
            else
              p(k) = sin(pi*(t(k)/Ts))/(pi*(t(k)/Ts));
            end
        end
end


end

