 hMod = comm.PAMModulator(2);
    hAWGN = comm.AWGNChannel('NoiseMethod', ...
                    'Signal to noise ratio (SNR)', ...
                    'SNR',20, 'SignalPower', 85);
    hDemod = comm.PAMDemodulator(2);
    %Create an error rate calculator
    hError = comm.ErrorRate;
    for counter = 1:100
      % Transmit a 50-symbol frame
      data = randi([0 hMod.ModulationOrder-1],50,1);
      modSignal = step(hMod, data);
      noisySignal = step(hAWGN, modSignal);
      receivedData = step(hDemod, noisySignal);
      errorStats = step(hError, data, receivedData);
    end
    fprintf('Error rate = %f\nNumber of errors = %d\n', ...
      errorStats(1), errorStats(2))