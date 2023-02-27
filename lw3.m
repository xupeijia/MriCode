% 按照1/3倍频程频带进行计算分析
clc; clear; close all;

% 加载数据
% filename = 'Siemens-MAGNETOM-HEAD.txt';
% filename1 = 'GE-SZNGA Premier-3D-AXT1-MPR.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-HEAD.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-1.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-2.txt';

% filename1 = 'bed-shell-西门子-头部常规序列-MPRAGE-20220226.txt';
% filename2 = 'bed-shell-西门子-头部静音序列-PETRA-20220226.txt';
% filename = 'bed-shell-西门子-脊柱常规序列-病人实测-20220226.txt';

% filename1 = '梯度线圈左侧-头颅常规序列.txt';
% filename2 = '梯度线圈左侧-头颅静音序列.txt';

filename1 = '梯度线圈上侧-头颅常规序列.txt';
filename2 = '梯度线圈上侧-头颅静音序列.txt';

% filename1 = '梯度线圈左侧-脊柱常规序列.txt';
% filename2 = '梯度线圈左侧-脊柱静音序列.txt';

% filename1 = '梯度线圈上侧-脊柱常规序列.txt';
% filename2 = '梯度线圈上侧-脊柱静音序列.txt';

% filename1 = '梯度线圈左侧-盆腔常规序列.txt';
% filename2 = '梯度线圈左侧-盆腔静音序列.txt';

% filename1 = '梯度线圈左侧-膝关节常规序列.txt';
% filename2 = '梯度线圈左侧-膝关节静音序列.txt';

dataset1 = importdata(filename1,'	',6);%导入数据
dataset2 = importdata(filename2,'	',6);%导入数据
% dataset = importdata(filename);%导入数据
x1 = dataset1.data;% 只加载数字部分
t1 = x1(:,1);
y1 = x1(:,2);
x2 = dataset2.data;% 只加载数字部分
t2 = x2(:,1);
y2 = x2(:,2);

fs = round(length(x1)/(t1(end) - t1(1)));

color1 = [68, 114, 196]/256;
color2 = [237, 125, 49]/256;


% 输出结果
figure(1)
plot(t1,y1, Color=color1, LineWidth=1);hold on;
plot(t2,y2, Color=color2, LineWidth=1);hold off;
xlabel(('\fontname{宋体}时间\fontname{Arial Unicode MS} (s)'));
ylabel('\fontname{宋体}速度\fontname{Arial Unicode MS} (m/s)', FontSize=9);
legend('梯度线圈上侧-头颅常规序列', '梯度线圈上侧-头颅静音序列', Orientation='horizontal', Box='off', Location='north', FontName='宋体', FontSize=9);
% title('时域图');
set(gcf,'color','w');

figure(2)
[ff1,yy1]=ftf(y1,fs);
[ff2,yy2]=ftf(y2,fs);
plot(ff1,yy1, Color=color1, LineWidth=1);hold on;
plot(ff2,yy2, Color=color2, LineWidth=1);hold off;
xlabel(('\fontname{宋体}频率\fontname{Arial Unicode MS} (Hz)'), FontSize=9);
ylabel('\fontname{宋体}幅值', FontSize=9);
legend('梯度线圈上侧-头颅常规序列', '梯度线圈上侧-头颅静音序列', Orientation='horizontal', Box='off', Location='north', FontName='宋体', FontSize=9);
% title('频域图');
set(gcf,'color','w');

