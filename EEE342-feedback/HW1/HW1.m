clc
clear
load('lab1motordata.mat');
plot(time,velocity)
hold on

plot(time,180*(1-exp(-time*4)))
title('Experimental Results')
xlabel('Time (t)')
ylabel('Angular Velocity (w)')
figure
plot(time,(velocity-180*(1-exp(-time*4)))./velocity)
title('Errors')
xlabel('Time (t)')
ylabel('% error')