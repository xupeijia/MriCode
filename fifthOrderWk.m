function y = fifthOrderWk(x,fs)

B1 = [87.72,1138,11336,5453,5509];
A1 = [1,92.6854,2549.83,25969,81057,79783];
[b1,a1] = bilinear(B1,A1,fs);

y = filter(b1,a1,x);