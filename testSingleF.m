filename = 'GE-SZNGA Premier-3D-AXT1-MPR.txt';
dataset = importdata(filename,'	',6);%导入数据
inputdata = dataset.data;
t = inputdata(:, 1);
x = inputdata(:, 2);
Fs = round(length(t)/(t(end) - t(1)));

% 截取Fs整数倍的信号
T = floor(length(t)/Fs);
t = t(1:T*Fs);
x = x(1:T*Fs);
nfft = length(x);

y = fft(x, nfft);
% for i = 1:Fs/2
%     fn = i*nfft/Fs+1;
%     a = zeros(1, nfft);
%     a(fn) = y(fn);
%     a(nfft-fn+2) = y(nfft-fn+2);
%     b = real(ifft(a, nfft));
% end
% 
% plot(b);

    
