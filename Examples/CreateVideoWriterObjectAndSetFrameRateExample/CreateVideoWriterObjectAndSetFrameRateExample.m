
%% Create VideoWriter Object and Write Video
%%
% Create a |VideoWriter| object to write a Motion JPEG AVI file named
% |newfile.avi|.

% Copyright 2015 The MathWorks, Inc.

v = VideoWriter('newfile.avi');
%%
% Open the file for writing and write a 300-by-300 matrix of data to the
% file.
open(v)
writeVideo(v,rand(300))
%%
% Close the file.
close(v)