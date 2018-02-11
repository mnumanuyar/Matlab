clear all
close all
fc = 1000;                  % Frequency of the sinusoid
delta_t = 10^-4;            % Time step used in the simulation (greater than the Nyquist rate)
sigma = .05;                % Standard deviation of the additive Gaussian noise for each sample                     % Duration of the signal
t = 0:delta_t:3;            % time vector

theta = 0.85;               % Phase of the sinusiod (to be tracked)
s = cos(2*pi*fc*t + theta); % Noiseless sinusoidal signal
r = s + sigma*randn(1,length(s));   % Observation in white Gaussian noise

theta = 0.5;               % Phase of the sinusiod (to be tracked)
s = cos(2*pi*fc*t + theta); % Noiseless sinusoidal signal
r2 = s + sigma*randn(1,length(s));   % Observation in white Gaussian noise

% N_ord = 20;                 % Order of the filter
% cut_off = 0.1;              % Normalized cut-off frequency of the filter (one can 
%                             % determine the corresponding in Hz using the sampling rate). 
% b = fir1(N_ord,cut_off);    % Filter coefficients (fir1 uses a windowing function, default
%                             % a Hamming window) 
%                             
% K = 50;                     % gain of the integrator (for the VCO)


theta_prime = PLL( t,r,delta_t,fc,20,0.1,50);
plot(t,theta_prime,'b');
hold on
theta_prime2 = PLL( t,r2,delta_t,fc,20,0.1,50);
plot(t,theta_prime2,'g');
theta_prime3 = PLL( t,r,delta_t,fc,10,0.01,100);
plot(t,theta_prime3,'r');
legend('N=20, cutoff=0.1, K=50 for theta= 0.85','N=20, cutoff=0.1, K=50 for theta= 0.85','N=10, cutoff=0.01, K=100 for theta= 0.85')

a= [];
b= [];
for i = 1:1000
    theta = 0.85;               % Phase of the sinusiod (to be tracked)
    s = cos(2*pi*fc*t + theta); % Noiseless sinusoidal signal
    r = s + sigma*randn(1,length(s)); 
    theta_prime = PLL( t,r,delta_t,fc,20,0.1,50);
    theta_prime2 = PLL( t,r,delta_t,fc,10,0.01,100);
    a=[a theta_prime(end)];
    b=[b theta_prime2(end)];
    if(rem(i,10)==0), display(i);end
end
figure
histogram(a);
title('N=20, cutoff=0.1, K=50');
figure
histogram(b);
title('N=10, cutoff=0.01, K=100');