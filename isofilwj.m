% 时域Wj加速度计权
function y = isofilwj(x,fs)

f1 = 0.4;
f2 = 100;
f5 = 3.75;
Q5 = 0.91;
f6 = 5.32;
Q6 = 0.91;

% w3 = 2*pi*f3;
% w4 = 2*pi*f4;
w5 = 2*pi*f5;
w6 = 2*pi*f6;

nyq = fs/2;

[b1,a1] = butter(2,f1/nyq,'high');
[b2,a2] = butter(2,f2/nyq); 


B4 = [1/w5/w5 1/Q5/w5 1]*w5*w5/w6/w6;
A4 = [1/w6/w6 1/Q6/w6 1];
[b4,a4] = bilinear(B4,A4,fs);

y = filter(b2,a2,x);
y = filter(b1,a1,y);
y = filter(b4,a4,y);















