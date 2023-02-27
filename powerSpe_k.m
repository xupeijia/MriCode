%pr_act01
clc; clear; close all;

%加载文件
filename = 'act-001-time.txt';
dataset = importdata(filename);%此方式只加载数据，不加载开头的文字信息
x = dataset.data;

% [x,fs] = audioread('m_noise.wav');

%求导
x = deriva(x);

fs=48000; %采样频率
x=x(:,2); %定义三分之一倍频程的中心频率
fc = [.1 .125 .16 .2 .25 .315 .4 .5 .63 .8 1 1.25 1.6 2 2.5 3.15 4 5 6.3 8 10 12.5 16 20 25 31.5 40 50 63 80 100 125 160 200 250 315 400];
wk = 0.001*[31.2,48.6,79.0,121,182,263,352,418,459,477,482,484,494,531,631,804,967,1039,1054,1036,988,902,768,636,513,405,314,246,186,132,88.7,54.0,28.5,15.2,7.90,3.98,1.95];
%中心频率与下限频率的比值
oc6=2^(1/6);
%取中心频率总的长度
nc=length(fc);
%输入数据的长度
n=length(x);
%大于并接近n的2的幂次方长度
%fft=2^nextpow2(n);
%FFT变换
%a=fft(Y,nfft);
% 计算功率谱密度
[Pxx,f]=periodogram(x,rectwin(n),n,fs);

for j=1:nc
    fl=fc(j)/oc6;             % 求出1/3倍频程下限截止频率
    fu=fc(j)*oc6;             % 求出1/3倍频程上限截止频率
    nl=round(fl*n/fs+1);   % 下限截止频率对应的频率索引
    nu=round(fu*n/fs+1);   % 上限截止频率对应的频率索引
    if nu>(n)/2, break; end
    b=zeros(1,(n)/2);          % b初始化
    b(nl:nu)=Pxx(nl:nu);        % 把1/3倍频程滤波器的谱线放于b中

%    b(nfft-nu+2:nfft-nl+2)=a(nfft-nu+2:nfft-nl+2);
%    c=real(ifft(b,nfft));     % IFFT逆变换
%    yc(j)=sqrt(var((c(1:n))));% 求出均方根值
    Pw(j)=sum(b);
end

ak = Pw.*wk;
Ak = sum(ak);

% ajrms = sqrt(var(ak(1:end)));
% bar(VLj(1:nc)); %绘制1/3倍频程Z振级图谱  1-400Hz直方图
% set(gca,'xtick',ggg);grid;
% set(gca,'xticklabel',gg); %横坐标
% xlabel('1/3倍频程中心频率/Hz');ylabel('振级/dB');
% title('1/3倍频程Wj计权输出振级');
% set(gcf,'color','w');


nc=nc-1;

Pw1=Pw/max(Pw);
   bar(Pw1);
   set(gca,'XTick',[2:3:nc]);
   grid;     
   set(gca,'XTickLabels',fc(2:3:length(fc)));  
   xlabel('中心频率/Hz'); ylabel('归一化功率谱/N');
   title('三分之一倍频程功率谱')
   set(gcf,'color','w');
