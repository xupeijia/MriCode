clc; clear; close all;
% 对振动速度进行求导、计权和评价指标计算
% 加载文件
path = 'D:\Study\Projects\MRI\Data\Body\GE\sample50k\a\';
filelist = dir(strcat(path, '*.csv'));
filename = filelist(1).name;
data = readmatrix(strcat(path, filename));
t = data(:,1);
a = data(:,2);

fs = 50000;
% 1/3倍频程中心频率
fc = [0.4 0.5 0.63 0.8 1 1.25 1.6 2 2.5 3.15 4 5 6.3 8 10 12.5 16 20 25 31.5 40 50 63 80 100];
nfc = length(fc);

% 健康、舒适、感知
[aw1, arms1, cf1, mtvv1, mtvvDivideAw1, vdv1, vdvDivideAwAndT1, Lwa1, LwaSum1] = VibrationEvaluate(t, a, fs, fc, 'wk');
[aw2, arms2, cf2, mtvv2, mtvvDivideAw2, vdv2, vdvDivideAwAndT2, Lwa2, LwaSum2] = VibrationEvaluate(t, a, fs, fc, 'wd');
[aw3, arms3, cf3, mtvv3, mtvvDivideAw3, vdv3, vdvDivideAwAndT3, Lwa3, LwaSum3] = VibrationEvaluate(t, a, fs, fc, 'wc');
[aw4, arms4, cf4, mtvv4, mtvvDivideAw4, vdv4, vdvDivideAwAndT4, Lwa4, LwaSum4] = VibrationEvaluate(t, a, fs, fc, 'we');
[aw5, arms5, cf5, mtvv5, mtvvDivideAw5, vdv5, vdvDivideAwAndT5, Lwa5, LwaSum5] = VibrationEvaluate(t, a, fs, fc, 'wj');

% 运动病 wf计权
[aw6, arms6, cf6, mtvv6, mtvvDivideAw6, vdv6, vdvDivideAwAndT6, Lwa6, LwaSum6] = VibrationEvaluate(t, a, fs, fc, 'wf');


A = [arms1, cf1, mtvv1, mtvvDivideAw1, vdv1, vdvDivideAwAndT1, LwaSum1;
    arms2, cf2, mtvv2, mtvvDivideAw2, vdv2, vdvDivideAwAndT2, LwaSum2;
    arms3, cf3, mtvv3, mtvvDivideAw3, vdv3, vdvDivideAwAndT3, LwaSum3;
    arms4, cf4, mtvv4, mtvvDivideAw4, vdv4, vdvDivideAwAndT4, LwaSum4;
    arms5, cf5, mtvv5, mtvvDivideAw5, vdv5, vdvDivideAwAndT5, LwaSum5;
    arms6, cf6, mtvv6, mtvvDivideAw6, vdv6, vdvDivideAwAndT6, LwaSum6;
    ];
disp(A);
B = [Lwa1;Lwa2;Lwa3;Lwa4;Lwa5;Lwa6];
C = ["wk";"wd";"wc";"we";"wj";"wf"];
set(0,'DefaultTextFontSize',10.5); % 设置字体大小为10.5
set(0,'DefaultAxesFontSize',10.5); % 设置坐标轴的字体大小为10.5
% 刻度
ggg = (1:3:nfc);
gg = fc(1:3:nfc);
for i=1:6
    figure(i);
    Lwa = B(i,:);
    bar(Lwa(1:end));
    set(gca,'XTick',ggg);grid%网格线
    set(gca,'XTickLabels',gg);
    set(gca,'Units','centimeters','Position',[5 5 6 4.5],'linewidth',1);
    if i==5 || i==6
        xlabel({'\fontname{Times}(a)','\fontname{宋体}频率\fontname{Times} (Hz)'});
    else
        xlabel('\fontname{Times}(a)');
    end

    if mod(i,2)==1
        ylabel({'\fontname{宋体}振动加速度级\fontname{Times} (dB)'});
    end
    title('\fontname{Times}\itW_k\fontname{宋体}计权');
end


