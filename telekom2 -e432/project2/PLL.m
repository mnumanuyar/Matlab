function [ theta_prime ] = PLL( t,r,delta_t,fc,N_ord,cut_off,K)

% PLL simulation for a sinusoid with a constant amplitude
% implemented by Tolga M. Duman

% clear all
% fc = 1000;                  % Frequency of the sinusoid
% delta_t = 10^-4;            % Time step used in the simulation (greater than the Nyquist rate)
% sigma = .05;                % Standard deviation of the additive Gaussian noise for each sample
% T = 3;                      % Duration of the signal
% t = 0:delta_t:T;            % time vector
% 
% theta = 0.85;               % Phase of the sinusiod (to be tracked)
% 
% s = cos(2*pi*fc*t + theta); % Noiseless sinusoidal signal
% r = s + sigma*randn(1,length(s));   % Observation in white Gaussian noise

% The signal embedded in Gaussian noise is generated at this point. The
% rest of the code is used to implement a PLL to lock on to the unknown
% channel phase.

% Note: An FIR filter is used as the loop filter. Its bandwidth should be
% selected to remove the double frequency term (at 2*fc) (paying attention
% to the sampling period delta_t being used). "b" are the loop filter
% coefficients.

% N_ord = 20;                 % Order of the filter
% cut_off = 0.1;              % Normalized cut-off frequency of the filter (one can 
%                             % determine the corresponding in Hz using the sampling rate). 
 b = fir1(N_ord,cut_off);    % Filter coefficients (fir1 uses a windowing function, default
%                             % a Hamming window) 
%                             
% K = 50;                     % gain of the integrator (for the VCO)

int_of_v = 0;               % Integrator output initialized
e = zeros(1,N_ord);         % Error signal (input to the loop filter) is initialized
theta_prime = [];           % Estimated sinusoidal phase values
for i=1:length(t),
    theta_prime = [theta_prime K*int_of_v];        % Estimate of the phase at the current step
    vco_out = -sin(2*pi*fc*t(i)+theta_prime(i));   % output of the voltage controlled oscillator
    e = [e r(i)*vco_out];   % Error signal is extended with the next sample
    v_of_t = 0;             % loop filter output for the current time step is initialized
    for j=1:N_ord+1,
        v_of_t = v_of_t + b(j)*e(i+N_ord-j+1);
    end;
                            % Loop filter output sample is obtained at this point. 
                           
    int_of_v = int_of_v + delta_t*v_of_t;   %Integrator output is obtained. 
end;

% This completes the run of the PLL for "T" seconds. Next, we can plot the PLL output to observe
% the estimated phase values.

end

