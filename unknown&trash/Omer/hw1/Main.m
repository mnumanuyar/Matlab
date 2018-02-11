delete all
clear 
clc;
load('data.mat');
t = 0:0.001:1;

%plot of x5
figure
plot(t,X(5,:));
ylabel('X5');
xlabel('t');
title ( 'plot of X5' );

[a,b,c,d]=parameters_of_sin(0.001,X(5,:));
fprintf('x_5(t) = %+.2f %+.2fcos(%+.2f*t %+.2f)\n',a,b,2*pi*c,d);

%plot of x7
figure
plot(t,X(7,:));
ylabel('X7');
xlabel('t');
title ( 'plot of X7' );

[a,b,c,d]=parameters_of_sin(0.001,X(7,:));
fprintf('x_7(t) = %+.2f %+.2fcos(%+.2f*t %+.2f)\n',a,b,2*pi*c,d);

%plot of x10
figure
plot(t,X(10,:));
ylabel('X10');
xlabel('t');
title ( 'plot of X10' );

[a,b,c,d]=parameters_of_sin(0.001,X(10,:));
fprintf('x_10(t) = %+.2f %+.2fcos(%+.2f*t %+.2f)\n',a,b,2*pi*c,d);
