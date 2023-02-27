%A计权
function y = adsgn(x, Fs)
f1 = 20.598997; 
f2 = 107.65265;
f3 = 737.86223;
f4 = 12194.217;
A1000 = 1.9997;
pi = 3.14159265358979;
NUMs = [ (2*pi*f4)^2*(10^(A1000/20)) 0 0 0 0 ];
DENs = conv([1 +4*pi*f4 (2*pi*f4)^2],[1 +4*pi*f1 (2*pi*f1)^2]); 
DENs = conv(conv(DENs,[1 2*pi*f3]),[1 2*pi*f2]);

[B,A] = bilinear(NUMs,DENs,Fs);

y = filter(B, A, x);