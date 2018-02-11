%%
% w = logspace(-1,2,100);
% 
% for k = 1:100
%     X = 1i * w(k);
%     G2(k) = 60 / (X+7);
% end 
% subplot(2,1,1)
% semilogx(w,20*log10(abs(G2)));
% grid on
% subplot(2,1,2)
% semilogx(w,angle(G2)*180/pi)
% grid on
clear
%%
w = logspace(-1,2,100);
t = (-4*pi:0.01:4*pi);
G2 = tf(60,[1,7]);

for k = 1:100

    X2 = sin(w(k)*t);
    Y = lsim(G2,X2,t);
    
    FX2 = fft(X2);
    FY = fft(Y);

    
    [~, idx_FX2] = max(abs(FX2));

    [~, idx_FY] = max(abs(FY));
    dif(k) = FY(idx_FY)/FX2(idx_FX2);
end

subplot(2,1,1);
hold on
semilogx(w, 20*log10(abs(dif)),'x');
grid on
subplot(2,1,2);
hold on
semilogx(w, angle(dif)*180/pi ,'x');
grid on
% w = logspace(0.1,100,100);
% 
% t = (-4*pi:0.01:4*pi);
% G2 = tf(60,[1,7]);
% 
% for i = 1:100
%     
%     X2 = sin(w(i)*t);
%     Y = lsim(G2,X2,t);
%     
%     FX2 = fft(X2);
%     FY = fft(Y);
% 
%     
%    [mag_FX2, idx_FX2] = max(abs(FX2));
%     ang1 = angle(FX2(idx_FX2))*180/pi;
% 
%     [mag_FY, idx_FY] = max(abs(FY));
%     ang2 = angle(FY(idx_FY))*180/pi;
% 
%     mag(i) = mag_FY/mag_FX2;
%     
%     phase(i) = ang2-ang1; 
%     dif(i) = FY(idx_FY)/FX2(idx_FX2);
%     
% end
% subplot(2,1,1);
% semilogx(w, 20*log10(mag));
% grid on
% subplot(2,1,2);
% semilogx(w, phase );
% grid on
% 
% subplot(2,1,1);
% semilogx(w, 20*log10(abs(dif)));
% grid on
% subplot(2,1,2);
% semilogx(w, angle(dif)*180/pi );
% grid on

% subplot(2,1,1);
% semilogx(w,20*log10(abs(G2)));
% grid on
% hold on
% semilogx(w, 20*log10(abs(dif)));
% subplot(2,1,2);
% semilogx(w,angle(G2)*180/pi)
% grid on
% hold on
% semilogx(w, angle(dif)*180/pi );