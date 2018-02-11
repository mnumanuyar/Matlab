%% Calculate Radon Transform and Display Plot
% 
%%
% Make the axes scale visible for this image.
iptsetpref('ImshowAxesVisible','on')
%%
% Create a sample image. 
I = zeros(100,100);
I(25:75, 25:75) = 1;
%%
% Calculate the Radon transform.
theta = 0:180;
[R,xp] = radon(I,theta);
%%
% Display the transform.
imshow(R,[],'Xdata',theta,'Ydata',xp,'InitialMagnification','fit')
xlabel('\theta (degrees)')
ylabel('x''')
colormap(gca,hot), colorbar
%%
% Make the axes scale invisible.
iptsetpref('ImshowAxesVisible','off')
