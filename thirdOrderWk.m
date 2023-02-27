function y = thirdOrderWk(x,fs)

B1 = [80.03 989.0 0.02108];
A1 = [1 78.92 2412 5614];
[b1,a1] = bilinear(B1,A1,fs);

y = filter(b1,a1,x);