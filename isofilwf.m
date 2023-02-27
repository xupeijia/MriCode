function y = isofilwf(x,fs)


f1 = 0.08;
f2 = 0.63;
% f3 = 12.5;
f4 = 0.25;
Q4 = 0.86;
f5 = 0.0625;
Q5 = 0.80;
f6 = 0.1;
Q6 = 0.80;

% w3 = 2*pi*f3;
w4 = 2*pi*f4;
w5 = 2*pi*f5;
w6 = 2*pi*f6;

nyq = fs/2;

[b1,a1] = butter(2,f1/nyq,'high');
[b2,a2] = butter(2,f2/nyq);

B3 = [0,1];
A3 = [1/w4/w4,1/Q4/w4,1];
[b3,a3] = bilinear(B3,A3,fs);

B4 = [1/w5/w5 1/Q5/w5 1]*((w5*w5)/(w6*w6));
A4 = [1/w6/w6 1/Q6/w6 1];
[b4,a4] = bilinear(B4,A4,fs);


y1 = filter(b2,a2,x);
y2 = filter(b1,a1,y1);
y3 = filter(b3,a3,y2);
y = filter(b4,a4,y3);















