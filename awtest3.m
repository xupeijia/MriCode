%pr_act01
clc; clear; close all;

%test of sin wave
fc = [10 12.5 16 20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
wa = [-70.4 -63.4 -56.7 -50.5 -44.7 -39.4 -34.6 -30.2 -26.2 -22.5 -19.1 -16.1 -13.4 -10.9 -8.6 -6.6 -4.8 -3.2 -1.9 -0.8 0 0.6 1.0 1.2 1.3 1.2 1.0 0.5 -0.1 -1.1 -2.5 -4.3 -6.6 -9.3];
nc = length(fc);
tt=linspace(0,5,2^14);
fs=2^14/5;
maxA = zeros(1,nc);
maxAw = zeros(1,nc);
for i=1:nc
    fdd=fc(i);
    da=sin(2*pi*fdd*tt);
    
    %iso standard weighting
    [B, A] = adsgn(fs);
    y = filter(B, A, da);

    [ff,yy]=ftf(da,fs);
    [fss,yss]=ftf(y,fs);
    maxA(i) = max(yy);
    maxAw(i) = max(yss);
end

%print and plot


figure(1);
plot(fc,maxA);hold on;
plot(fc,maxAwk);hold off;


figure(2);

plot(fc,maxA./maxAwk,'-');hold on;
plot(fc,wa,'p');hold off;
xlabel('Frequency(Hz)');ylabel('Difference');
title('Verification of frequency weighting function');