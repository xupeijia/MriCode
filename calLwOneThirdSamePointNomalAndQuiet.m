% 按照1/3倍频程频带进行计算分析
clc; clear; close all;

% 加载数据
% filename = 'Siemens-MAGNETOM-HEAD.txt';
% filename = 'GE-SZNGA Premier-3D-AXT1-MPR.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-HEAD.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-1.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-2.txt';

% filename = 'bed-shell-西门子-脊柱常规序列-病人实测-20220226.txt';
filename1 = 'gradient-coil-left-西门子-头颅常规序列-20220526.txt';
filename2 = 'gradient-coil-left-西门子-头颅静音序列-20220526.txt';
% filename1 = 'gradient-coil-up-西门子-头颅常规序列-20220526.txt';
% filename2 = 'gradient-coil-up-西门子-头颅静音序列-20220526.txt';
% filename1 = 'bed-shell-西门子-头部常规序列-MPRAGE-20220226.txt';
% filename2 = 'bed-shell-西门子-头部静音序列-PETRA-20220226.txt';
% filename1 = 'head-coil-left-西门子-头部常规序列-MPRAGE-20220226.txt';
% filename2 = 'head-coil-left-西门子-头部静音序列-PETRA-20220526.txt';
% filename1 = 'gradient-coil-left-西门子-盆腔常规序列-20220526.txt';
% filename2 = 'gradient-coil-left-西门子-盆腔静音序列-20220526.txt';
% filename1 = 'gradient-coil-left-西门子-脊柱常规序列-20220526.txt';
% filename2 = 'gradient-coil-left-西门子-脊柱静音序列-20220526.txt';
% filename1 = 'gradient-coil-left-西门子-膝关节常规序列-20220526.txt';
% filename2 = 'gradient-coil-left-西门子-膝关节静音序列-20220526.txt';
% filename1 = 'gradient-coil-up-西门子-脊柱常规序列-20220526.txt';
% filename2 = 'gradient-coil-up-西门子-脊柱静音序列-20220526.txt';
dataset1 = importdata(filename1,'	',6);%导入数据
dataset2 = importdata(filename2,'	',6);%导入数据
% dataset = importdata(filename);%导入数据
x1 = dataset1.data;% 只加载数字部分
t1 = x1(:,1);
y1 = x1(:,2);
x2 = dataset2.data;% 只加载数字部分
t2 = x2(:,1);
y2 = x2(:,2);

% 定义参数
fs = round(length(x1)/(t1(end) - t1(1)));
wa = [-39.4 -34.6 -30.2 -26.2 -22.5 -19.1 -16.1 -13.4 -10.9 -8.6 -6.6 -4.8 -3.2 -1.9 -0.8 0 0.6 1.0 1.2 1.3 1.2 1.0 0.5 -0.1 -1.1 -2.5 -4.3 -6.6 -9.3];
fc = [31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
fcs = 1:29;
nc = length(fc);
s1 = "头颅常规";
s2 = "头颅静音";

% 输出结果
% 时域对比
figure(1)
plot(t1,y1);hold on;
plot(t2,y2);hold off;
xlabel('s');ylabel('m/s');legend(s1, s2');
title('时域图');
set(gcf,'color','w');

% 频域对比
figure(2)
[ff1,yy1]=ftf(y1,fs);
[ff2,yy2]=ftf(y2,fs);
plot(ff1,yy1);hold on;
plot(ff2,yy2);hold off;
xlabel('Hz');ylabel('幅值');legend(s1, s2);
title('频域图');
set(gcf,'color','w');

[Lv1,Lw1,Lwa1] = calLvLwLwa(y1,fs,fc,wa,nc);
fprintf('头颅常规序列：\n');
LvSum1 = 10*log10(sum((10.^(0.1*Lv1))));
fprintf('LvSum：%.2fdB\n', LvSum1);
LwSum1 = 10*log10(sum((10.^(0.1*Lw1))));
fprintf('LwSum：%.2fdB\n', LwSum1);
LwaSum1 = 10*log10(sum((10.^(0.1*Lwa1))));
fprintf('LwaSum：%.2fdB\n', LwaSum1);

[Lv2,Lw2,Lwa2] = calLvLwLwa(y2,fs,fc,wa,nc);
fprintf('头颅静音序列：\n');
LvSum2 = 10*log10(sum((10.^(0.1*Lv2))));
fprintf('LvSum：%.2fdB\n', LvSum2);
LwSum2 = 10*log10(sum((10.^(0.1*Lw2))));
fprintf('LwSum：%.2fdB\n', LwSum2);
LwaSum2 = 10*log10(sum((10.^(0.1*Lwa2))));
fprintf('LwaSum：%.2fdB\n', LwaSum2);

difference = (Lwa1 - Lwa2)./Lwa1*100;

figure(3);
Lv = [Lwa1;Lwa2];
yyaxis left;
h = bar(fcs,Lv); ylabel('dB');
set(h(1),'FaceColor',[0 0.45 0.74]);
set(h(2),'FaceColor',[0.85 0.33 0.10]);

yyaxis right;
plot(fcs,difference,'r-','linewidth',1.5);ylabel('降噪百分比');
set(gca,'yticklabel',{'-60%', '-50%', '-40%', '-30%' ,'-20%','-10%','0%','10%','20%','30%'});
text(fcs,difference,strcat(num2str(difference.','%.2f'),'%'));


set(gca,'xtick',fcs);grid;%横坐标值
set(gca,'xticklabel',fc); %横坐标
xlabel('Hz');
title('头颅序列常规与静音1/3倍频程声功率级对比');legend(s1,s2);
set(gcf,'color','w');

figure(4);
LwaSum = [LwaSum1,LwaSum2];
color_matrix = [0 0.45 0.74;0.85 0.33 0.10];  %每个柱子的颜色设置
bar(LwaSum);
hold on;
for i = 1:2
    b = bar(i,LwaSum(i));
    text(i,LwaSum(i)+0.5,num2str(LwaSum(i).','%.2f'),'VerticalAlignment','bottom','HorizontalAlignment','center');
    set(b,'facecolor',color_matrix(i,:));
end
set(gca,'XTickLabel',{'头颅常规序列', '头颅静音序列'});%设置柱状图每个柱子的横坐标
ylabel('dB');
title('头颅序列常规与静音A计权声功率级对比');
