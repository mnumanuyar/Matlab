% Script to generate random numbers drawn from a Rayleigh distribution.
% Uses the well known method of inverting the CDF of the desired probability
% function to get a function that can generate random numbers drawn
% from that desired distribution function,
% given as input numbers that have been drawn from a uniform distribution.
% by ImageAnalyst

clc; % Clear the command window.
close all; % Close all figures (except those of imtool.)
clear; % Erase all existing variables.
workspace; % Make sure the workspace panel is showing.
fontSize = 14;

% Change the current folder to the folder of this m-file.
if(~isdeployed)
cd(fileparts(which(mfilename)));
end

% Plot the Rayleigh cumulative distribution function
% over the range 0-20 with a sigma of 5.
x = 0:20;
sigma = 5;
rayleighCDF = 1 - exp(-x.^2 / (2*sigma^2));

subplot(3,1,1);
plot(x, rayleighCDF, 'LineWidth', 3);
caption = sprintf('Rayleigh CDF with sigma = %.2f', sigma);
title(caption, 'FontSize', fontSize);
set(gcf, 'Position', get(0,'Screensize')); % Enlarge figure to full screen.

% Ask user for a number of random numbers to generate.
userPrompt = 'Enter an integer number of random numbers to generate';
caNumberOfRandoms = inputdlg(userPrompt, 'Enter an integer',1, {'1000'});
numberOfRandoms = str2num(cell2mat(caNumberOfRandoms));

% Generate numberOfRandoms uniformly distributed random numbers.
uniformlyDistributedRandomNumbers = rand(numberOfRandoms, 1);
subplot(3,2,3);
bar(uniformlyDistributedRandomNumbers);
xlim([0 numberOfRandoms]);
caption = sprintf('%d Uniformly Distributed Numbers',numberOfRandoms);
title(caption, 'FontSize', fontSize);

%-----------------------------------------------------------------
% KEY PART, RIGHT HERE!!!!
% Invert the CDF of the Rayleigh function to get a function that can
% generate random numbers drawn from a Rayleigh distribution,
% given numbers drawn from a uniform distribution.
rayleighDistNumbers = sqrt(-log(1-uniformlyDistributedRandomNumbers)*(2*sigma^2));
%-----------------------------------------------------------------

% Plot the Rayleigh distributed numbers.
subplot(3,2,4);
bar(rayleighDistNumbers);
xlim([0 numberOfRandoms]);
caption = sprintf('%d Rayleigh Distributed Numbers', numberOfRandoms);
title(caption, 'FontSize', fontSize);

% Get histogram of uniformly distributed numbers.
[countsU, binsU] = hist(uniformlyDistributedRandomNumbers, 50);
% Plot the uniformly distributed numbers.
subplot(3,2,5);
bar(binsU, countsU);
caption = sprintf('Histogram of %d Uniformly Distributed Numbers',numberOfRandoms);
title(caption, 'FontSize', fontSize);

% Get histogram of Rayleigh distributed numbers.
% Observe that it's distribution is not flat like it is
% for the uniformly distributed numbers.
% It will take on the Rayleigh distribution shape.
[countsR, binsR] = hist(rayleighDistNumbers, 50);
subplot(3,2,6);
bar(binsR, countsR);
caption = sprintf('Histogram of %d Rayleigh Distributed Numbers',numberOfRandoms);
title(caption, 'FontSize', fontSize);