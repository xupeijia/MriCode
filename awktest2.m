%pr_act01
clc; clear; close all;

%test of sin wave
fc = [0.4 0.5 0.63 0.8 1 1.25 1.6 2 2.5 3.15 4 5 6.3 8 10 12.5 16 20 25 31.5 40 50 63 80 100];
wk = 0.001*[352,418,459,477,482,484,494,531,631,804,967,1039,1054,1036,988,902,768,636,513,405,314,246,186,132,88.7];
nc = length(fc);
tt=linspace(0,5,2^14);
fs=2^14/5;
maxA = zeros(1,nc);
maxAwk = zeros(1,nc);
for i=1:nc
    fdd=fc(i);
    da=sin(2*pi*fdd*tt);
    
    %derivative
    xd = diff(da)/(1/fs);
    
    %construct data
    x=[tt(2:end)' xd'];
    
    %iso standard weighting
    y = isofilwk(x(:,2),fs);
    % y = secondOrderWk(x(:,2),fs);
    % y = thirdOrderWk(x(:,2),fs);
    % y = fourthOrderWk(x(:,2),fs);
    % y = fifthOrderWk(x(:,2),fs);

    [ff,yy]=ftf(xd,fs);
    [fss,yss]=ftf(y,fs);
    maxAwk(i) = max(yy);
    maxA(i) = max(yss);
end

%print and plot


figure(1);
plot(fc,maxA);hold on;
plot(fc,maxAwk);hold off;


figure(2);

plot(fc,maxA./maxAwk,'-');hold on;
plot(fc,wk,'p');hold off;
xlabel('Frequency(Hz)');ylabel('Difference');
title('Verification of frequency weighting function');


