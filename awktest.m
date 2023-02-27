%pr_act01
clc; clear; close all;

%test of sin wave
tt=linspace(0,5,2^14);
fs=2^14/5;
fdd=100;
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

%RMSend
arms =rms(y);
VL = 20*log10(arms/1e-5);

%print and plot

figure(1)
plot(tt,da);
xlabel('time/s');ylabel('velocity/m/s');
title('OriginalVelocityData');
set(gcf,'color','w');

figure(2)
plot(x(:,1),x(:,2));
xlabel('time/s');ylabel('acceleration/m/s^2');
title('OriginalData');
set(gcf,'color','w');
% axis([0 45 -0.1 0.08])
tn=maketime(y,fs);
figure(3)
plot(tn,y,'k');
xlabel('time/s');ylabel('wkAcceleration/m/s^2');
title('WeightedData');
set(gcf,'color','w');
% axis([0 45 -0.1 0.08])
% tmp=[arms, VL];
% disp('       arms         VL')
% disp(tmp);
%
[ff,yy]=ftf(xd,fs);
[fss,yss]=ftf(y,fs);
figure(4)
plot(ff,yy);
figure(5);
plot(fss,yss,'r')
