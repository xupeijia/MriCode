clc;clear;close all;
% 对振动速度数据进行裁剪为整数采样周期、求导、带通滤波和绘制时频图像
% 加载数据
path = 'D:\Study\Projects\MRI\Data\Body\GE\sample50k\a\';
filelist = dir(strcat(path, '*.csv'));
filename1 = filelist(1).name;
filename2 = filelist(2).name;
filename3 = filelist(3).name;
filename4 = filelist(4).name;


[t1, y1, f1, Y1] = BandPassAndAft(path, filename1);
[t2, y2, f2, Y2] = BandPassAndAft(path, filename2);
[t3, y3, f3, Y3] = BandPassAndAft(path, filename3);
[t4, y4, f4, Y4] = BandPassAndAft(path, filename4);

% 计算功率谱密度
[ff1, psd1] = CalPSD(y1);
[ff2, psd2] = CalPSD(y2);
[ff3, psd3] = CalPSD(y3);
[ff4, psd4] = CalPSD(y4);

% 频域-功率谱
% set(0,'DefaultTextFontName','TimesSimSun'); % 设置字体样式为'TimesSimSun'
% set(0,'DefaultAxesFontName','TimesSimSun'); % 设置轴的字体为'TimesSimSun'
set(0,'DefaultTextFontSize',10.5); % 设置字体大小为10.5
set(0,'DefaultAxesFontSize',10.5); % 设置坐标轴的字体大小为10.5
figure(1);
plot(ff1,psd1);
xlabel(('\fontname{Times}(a)'));
ylabel('\fontname{宋体}功率谱密度\fontname{Times} (dB)');
set(gca,'Units','centimeters','Position',[5 5 6 4.5],'linewidth',1);

figure(2);
plot(ff2,psd2);
xlabel(('\fontname{Times} (b)'));
set(gca,'Units','centimeters','Position',[5 5 6 4.5],'linewidth',1);

figure(3);
plot(ff3,psd3);
xlabel({'\fontname{Times}(c)','\fontname{宋体}频率\fontname{Times} (Hz)'});
ylabel('\fontname{宋体}功率谱密度\fontname{Times} (dB)');
set(gca,'Units','centimeters','Position',[5 5 6 4.5], 'linewidth',1);

figure(4);
plot(ff4,psd4);
xlabel({'\fontname{Times}(d)','\fontname{宋体}频率\fontname{Times} (Hz)'});
set(gca,'Units','centimeters','Position',[5 5 6 4.5],'linewidth',1);

% % 时域
% figure(1);
% plot(t1,y1);
% xlabel(('\fontname{Times} (a)'), "FontSize",10.5);
% ylabel('\fontname{宋体}加速度\fontname{Times} (m/s^{2})');
% % 设置刻度范围
% ylim([-2 2])
% yticks(-2:1:2)
% set(gca,'Units','centimeters','Position',[5 5 6 4.5],'linewidth',1);
% 
% figure(2);
% plot(t2,y2);
% xlabel(('\fontname{Times} (b)'), 'FontSize',10.5);
% set(gca,'Units','centimeters','Position',[5 5 6 4.5],'linewidth',1);
% 
% figure(3);
% plot(t3,y3);
% xlabel(('\fontname{宋体}时间\fontname{Times} (s)'));
% ylabel('\fontname{宋体}加速度\fontname{Times} (m/s^{2})');
% set(gca,'Units','centimeters','Position',[5 5 6 4.5], 'linewidth',1);
% 
% figure(4);
% plot(t4,y4);
% xlabel(('\fontname{宋体}时间\fontname{Times} (s)'));
% set(gca,'Units','centimeters','Position',[5 5 6 4.5],'linewidth',1);

% % 频域-频谱
% figure(1);
% plot(f1,Y1);
% xlabel(('\fontname{Times}(a)'), "FontSize",10.5);
% ylabel('\fontname{宋体}加速度\fontname{Times} (m/s^{2})');
% % 设置刻度范围
% ylim([0 0.03])
% yticks(0:0.01:0.03)
% %设置刻度科学计数表示方式
% ax = gca;
% ax.YAxis.Exponent = -2;
% set(gca,'Units','centimeters','Position',[4 4 6 4.5],'linewidth',1)
% 
% figure(2);
% plot(f2,Y2);
% xlabel(('\fontname{Times}(b)'), 'FontSize',10.5);
% % 设置刻度范围
% ylim([0 0.008])
% yticks(0:0.002:0.008)
% %设置刻度科学计数表示方式
% ax = gca;
% ax.YAxis.Exponent = -3;
% set(gca,'Units','centimeters','Position',[4 4 6 4.5],'linewidth',1);
% 
% figure(3);
% plot(f3,Y3);
% xlabel({'\fontname{Times}(c)', '\fontname{宋体}频率\fontname{Times} (Hz)'});
% ylabel('\fontname{宋体}加速度\fontname{Times} (m/s^{2})');
% ylim([0 0.3])
% yticks(0:0.1:0.3)
% ax = gca;
% ax.YAxis.Exponent = -1;
% set(gca,'Units','centimeters','Position',[4 4 6 4.5], 'linewidth',1);
% 
% figure(4);
% plot(f4,Y4);
% xlabel({'\fontname{Times}(d)', '\fontname{宋体}频率\fontname{Times} (Hz)'});
% ax = gca;
% ylim([0 0.03])
% yticks(0:0.01:0.03)
% ax.YAxis.Exponent = -2;
% set(gca,'Units','centimeters','Position',[4 4 6 4.5],'linewidth',1);






%计权因子
% figure(4)
% %zji=[-6,-5,-4,-3,-2,-1,0,0,0,0,-2,-4,-6,-8,-10,-12,-14,-16,-18,-20];
% zji = [-30.18,-26.32,-22.11,-18.38,-14.86,-11.65,-9.10,-7.60,-6.78,-6.42,-6.30,-6.28,-6.32,-6.34,-6.22,-5.62,-4.04,-2.01,-0.48,0.15,0.25,0.22,0.16,0.10,0.06,0.00,-0.08,-0.24,-0.62,-1.48,-3.01,-5.36,-8.78,-12.30,-16.03,-19.89,-24.10];
function [t, x, f, Y] = BandPassAndAft(path, filename)
    Fs = 50000;
    data = readmatrix(strcat(path, filename), Delimiter=',');
    t = data(:,1);
    x = data(:,2);
    % 进行带通滤波操作
    f1 = 0.4;
    f2 = 100;
    nyq = 0.5*Fs;
    [b1, a1] = butter(2, f1/nyq, 'high');
    [b2, a2] = butter(2, f2/nyq, 'low');
    y1 = filter(b1, a1, x);
    x = filter(b2, a2, y1);
    % 进行fft操作
    window = hann(length(x));
    y = x.*window;
    [f, Y] = aft(y, Fs);
    nfft = length(f);
    nf100 = (nfft-1)*(f2/nyq);
    f = f(2:nf100);
    Y = 2*Y(2:nf100);
end


function [f, psd] = CalPSD(x)
    % pwelch(x,window,noverlop,nfft,fs),其中window越分辨率越高，越能看到更低的频率
    [pxx,f] = pwelch(x,50000,25000,50000,50000);
    psd = 10*log10(pxx);
    % 2:101是因为分辨率为fs/window=1，所以查看1-100Hz就是2:101
    f = f(2:101);
    psd = psd(2:101);
end