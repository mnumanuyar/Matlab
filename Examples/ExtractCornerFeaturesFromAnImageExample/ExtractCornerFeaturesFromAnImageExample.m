%% Extract Corner Features from an Image.

% Copyright 2015 The MathWorks, Inc.


%% Read the image.
  I = imread('cameraman.tif');
  
%% Find and extract corner features.
  corners = detectHarrisFeatures(I);
  [features, valid_corners] = extractFeatures(I, corners);

%% Display image.
  figure; imshow(I); hold on

%% Plot valid corner points.
  plot(valid_corners);