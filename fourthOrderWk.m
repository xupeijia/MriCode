function y = fourthOrderWk(x,fs)

B1 = [81.89,796.6,1937,0.1446];
A1 = [1,80.00,2264,7172,21196];
[b1,a1] = bilinear(B1,A1,fs);

y = filter(b1,a1,x);