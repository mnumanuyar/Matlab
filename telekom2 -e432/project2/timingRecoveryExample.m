
% Binary PAM timing recovery code maximizing the output energy
% (a non-decision directed approach)
% Implemented by Tolga M. Duman

clear all
Tb = 10^-3;                       % Bit duration
oversampling_factor = 200;        % Oversampling factor (taken large)
delta_t = Tb/oversampling_factor; % Time step size
sigma = 0.01;                      % Additive Gaussian noise standand deviation.

Num_of_symbols = 500;             % Number of bits considered in the transmission
T = Tb*Num_of_symbols;            % Length of transmission in seconds
t = 0:delta_t:T-delta_t;          % Time vector
      
baseband_s = [];                  % Transmitted signal initialized
symb = [];                        % Symbol sequence initialized
tx_pulse = ones(1,oversampling_factor);         % A rectangular pulse is used in transmission
for i=1:Num_of_symbols,         
   symb = [symb 2*(rand>0.5)-1];                % Next binary symbol          
   baseband_s = [baseband_s symb(i)*tx_pulse];  % Transmitted signal (corresponding to the current bit)
end;

s = baseband_s;                           % Assume baseband transmission (no carrier modulation)
r = s + sigma*randn(1,length(s));         % Received signal in additive Gaussian noise


y = conv(r,tx_pulse(length(tx_pulse):-1:1));  % Matched filter output (without worrying about normalization)

offset = 45;                      % initial error in the sampling instance (in terms of number of samples)

samp_index = [length(tx_pulse) - offset];     % Initial time instance where the matched filter output is sampled
loop_filter_out = 0;              % Loop filter initialization
mu = 0.002;                       % Step size in the update of the sampling instance for the next bit
err = [];                         % Vector containing the sampling error (initialized)

% Timing loop follows
for i=1:Num_of_symbols-1,
    y_sample = y(samp_index(i));  % Next sample is obtained (using the estimated timing phase - not the correct one)
    y_prime_sample = (y(samp_index(i)+1)-y(samp_index(i)-1));
                                  % Difference in the sample values used to estimate the derivative of "y" (no
                                  % division by the time difference is used, since it is taken care of in the
                                  % update equation below
    next_sample = length(tx_pulse) + samp_index(i) + mu*y_sample*y_prime_sample;
                                  % Sampling instance for the next bit is updated using the product of "y" and "y'" 
                                  % No filtering or averaging is used (of course this can be done as well) 
    samp_index = [samp_index round(next_sample)];
                                  % Vector containing the sampling indices is updated.
    err = [err samp_index(i)-i*length(tx_pulse)]; 
                                  % error vector between the estimated and the correct sampling instances updated
end;

% Error vector is plotted to see if the correct sampling instances are
% obtained with the loop above.

plot(err);