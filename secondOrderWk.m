function y = secondOrderWk(x,fs)

B1 = [86.51 546.1];
A1 = [1 82.17 1892];
[b1,a1] = bilinear(B1,A1,fs);

y = filter(b1,a1,x);