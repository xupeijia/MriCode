%pr_act01
clc; clear; close all;

%加载文件
filename = 'act-001-time.txt';
dataset = importdata(filename);%此方式只加载数据，不加载开头的文字信息
originData = dataset.data;

% [x,fs] = audioread('m_noise.wav');

fs = 48000;
%derivative
x = diff(originData(:,2))/(1/fs);

% x=linspace(0,2,4000);
% x=sin(x*pi);

%1/3倍频程中心频率
%fc = [0.1 0.125 0.16 0.2 0.25 0.315 0.4 0.5 0.63 0.8 1 1.25 1.6 2 2.5 3.15 4 5 6.3 8 10 12.5 16 20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
%fc = [0.1 0.125 0.16 0.2 0.25 0.315 0.4 0.5 0.63 0.8 1 1.25 1.6 2 2.5 3.15 4 5 6.3 8 10 12.5 16 20 25 31.5 40 50 63 80 100 125 160 200 250 315 400];
fc = [0.4 0.5 0.63 0.8 1 1.25 1.6 2 2.5 3.15 4 5 6.3 8 10 12.5 16 20 25 31.5 40 50 63 80 100];
% f = [20,25,31.5,40,50,63,80,100,125,160];
% fc = [f,10*f,100*f];
%基准加速度
a0 = 10e-6;

%核心代码
nc = length(fc);
n = length(x);
nfft = 2^nextpow2(n);
a = fft(x,nfft);
oc6 = 2^(1/6);
yc = zeros(1,nc);
VL = zeros(1,nc);
for j = 1:nc
    fl = fc(j)/oc6;
    fu = fc(j)*oc6;
    nl = round(fl*nfft/fs+1);
    nu = round(fu*nfft/fs+1);
%     if fu > fs/2
%         m = i-1;break
%     end

    b = zeros(1,nfft);
    b(nl:nu) = a(nl:nu);
%     b(nfft-nu+1:nfft-nl+1) = a(nfft-nu+1:nfft-nl+1);
    b(nfft-nu+2:nfft-nl+2) = a(nfft-nu+2:nfft-nl+2);
    c = real(ifft(b,nfft));
    yc(j) = sqrt(var(c(1:n)));
    VL(j) = 20*log10(yc(j)/a0);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%作图%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%%%

%加速度
t = originData(:,1);
val = x;
plot(t(2:end),val,'k');
xlabel('时间/s');ylabel('加速度/m/s^2');
title('原始数据');
set(gcf,'color','w');

%未计权振级
ggg = (2:3:nc);
gg = fc(2:3:nc);
figure(2);
bar(VL(1:nc));
set(gca,'XTick',ggg);grid%网格线
set(gca,'XTickLabels',gg);
xlabel('1/3倍频程中心频率/Hz');ylabel('振级/dB');
title('未计权1/3倍频程输出振级');
set(gcf,'color','w');

% Wj计权振级
figure(3);
% 计权因子
%Wj = [-30.18,-26.32,-22.11,-18.38,-14.86,-11.65,-9.10,-7.60,-6.78,-6.42,-6.30,-6.28,-6.32,-6.34,-6.22,-5.62,-4.04,-2.01,-0.48,0.15,0.25,0.22,0.16,0.10,0.06,0.00,-0.08,-0.24,-0.62,-1.48,-3.01,-5.36,-8.78,-12.30,-16.03,-19.89,-24.10];
%Wj = [-9.10,-7.60,-6.78,-6.42,-6.30,-6.28,-6.32,-6.34,-6.22,-5.62,-4.04,-2.01,-0.48,0.15,0.25,0.22,0.16,0.10,0.06,0.00,-0.08,-0.24,-0.62,-1.48,-3.01,-5.36,-8.78,-12.30,-16.03,-19.89,-24.10];
%Wk = [-30.11,-26.26,-22.05,-18.33,-14.81,-11.60,-9.07,-7.57,-6.77,-6.43,-6.33,-6.29,-6.12,-5.49,-4.01,-1.90,-0.29,0.33,0.46,0.31,-0.10,-0.89,-2.28,-3.93,-5.80,-7.86,-10.05,-12.19,-14.61,-17.56,-21.04,-25.35,-30.91,-36.38,-42.04,-48,-54.20];
Wk = [-9.07,-7.57,-6.77,-6.43,-6.33,-6.29,-6.12,-5.49,-4.01,-1.90,-0.29,0.33,0.46,0.31,-0.10,-0.89,-2.28,-3.93,-5.80,-7.86,-10.05,-12.19,-14.61,-17.56,-21.04];
%wj = 0.001*[31 48.3 78.5 120 181 262 351 417 458 478 484 485 483 482 489 524 628 793 946 1017 1030 1026 1018 1012 1007 1001 991 972 931 843 708 539 364 243 158 100 62.4];
%wk = 0.001*[31.2,48.6,79.0,121,182,263,352,418,459,477,482,484,494,531,631,804,967,1039,1054,1036,988,902,768,636,513,405,314,246,186,132,88.7,54.0,28.5,15.2,7.90,3.98,1.95];
wk = 0.001*[352,418,459,477,482,484,494,531,631,804,967,1039,1054,1036,988,902,768,636,513,405,314,246,186,132,88.7];
VLj=zeros(1,nc);
for i=1:nc
     VLj(i)=VL(i)+Wk(i);
end
ak = yc.*wk;
akrms = rms(ak);
bar(VLj(1:nc)); %绘制1/3倍频程Z振级图谱  1-400Hz直方图
set(gca,'xtick',ggg);grid;
set(gca,'xticklabel',gg); %横坐标
xlabel('1/3倍频程中心频率/Hz');ylabel('振级/dB');
title('计权1/3倍频程Wj计权输出振级');
set(gcf,'color','w');
