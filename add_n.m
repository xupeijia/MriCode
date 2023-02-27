
function[signal,noise]=add_n(s,n_path,fs,snr)%s为信号，n_path为噪音路径及其名字，fs为信号的采样频率，snr为噪声设置的信噪比
s=s(:)';
sl=length(s);
[n,fs1]=audioread(n_path);
n=n(:)';
if fs~=fs1
    n1=resample(n,fs,fs1);
else
    n1=n;
end
noise=n1(1:sl);

E1=1/sl*sum(s.*s);%求出信号能量
E2=1/sl*sum(noise.*noise);%噪声能量
noise=sqrt(E1/(10^(snr/10))/E2)*noise;
signal=s+noise;