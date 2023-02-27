clear
% TODO:用循环把所有filename封装并遍历计算

% fc = [50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000];
% p0 = 2e-5;
% Lp1 = calOneThirdLevel(SP1, Fs1, fc, p0);



% LpRate = calRate(Lp2, Lp3);
% v0 = 5e-8;
% Lv1 = calOneThirdLevel(Y1, Fs1, fc, v0);
% LvRate = calRate(Lv2, Lv3);

% SheetNames = strsplit(filename1, '常规');
% SheetName = SheetNames{1};
% writematrix([fc; Lp1; Lp2; LpRate; Lv1; Lv2; LvRate], 'SiemensData3.xlsx', Sheet=SheetName, Range='B1:Y7');

% 
% ggg = (2:3:length(fc));
% gg = fc(2:3:length(fc));

% figure(1);
% subplot(3,1,1);
% bar(Lp1(1:end),'c');
% set(gca,'xtick',ggg);grid;
% set(gca,'xticklabel',gg);
% xlabel('1/3倍频程中心频率/Hz');ylabel('声压级/dB');
% title('未计权1/3倍频程表面声压级');
% set(gcf,'color','r');
% subplot(3,1,2);
% bar(Lp2(1:end),'c');
% set(gca,'xtick',ggg);grid;
% set(gca,'xticklabel',gg);
% xlabel('1/3倍频程中心频率/Hz');ylabel('振动速度级/dB');
% title('未计权1/3倍频程振动速度级');
% set(gcf,'color','w');
% subplot(3,1,3);
% bar(Lp3(1:end),'c');
% set(gca,'xtick',ggg);grid;
% set(gca,'xticklabel',gg);
% xlabel('1/3倍频程中心频率/Hz');ylabel('振动速度级/dB');
% title('未计权1/3倍频程振动速度级');
% set(gcf,'color','w');
% 
% figure(2);
% subplot(3,1,1);
% bar(Lv1(1:end),'c');
% set(gca,'xtick',ggg);grid;
% set(gca,'xticklabel',gg);
% xlabel('1/3倍频程中心频率/Hz');ylabel('声压级/dB');
% title('未计权1/3倍频程表面声压级');
% set(gcf,'color','w');
% subplot(3,1,2);
% bar(Lv2(1:end),'c');
% set(gca,'xtick',ggg);grid;
% set(gca,'xticklabel',gg);
% xlabel('1/3倍频程中心频率/Hz');ylabel('振动速度级/dB');
% title('未计权1/3倍频程振动速度级');
% set(gcf,'color','w');
% subplot(3,1,3);
% bar(Lv3(1:end),'c');
% set(gca,'xtick',ggg);grid;
% set(gca,'xticklabel',gg);
% xlabel('1/3倍频程中心频率/Hz');ylabel('振动速度级/dB');
% title('未计权1/3倍频程振动速度级');
% set(gcf,'color','w');


% 设置颜色
% 设置颜色为 SciPy Teal
% color1 = [0, 0.4470, 0.7410];  % 蓝色
% color2 = [0.8500, 0.3250, 0.0980];  % 橙色
% color3 = [0.9290, 0.6940, 0.1250];  % 黄色
% 
% % 创建一个新的图形窗口
% figure(1);
% % 绘制第一个子图
% subplot(3,1,1);  % 三行一列，第一个子图
% bar(Lp1, 'facecolor', color1);
% ylabel('声压级/dB');
% set(gca,'xtick',ggg);grid;
% set(gca,'xticklabel',gg);
% % 绘制第二个子图
% subplot(3,1,2);  % 三行一列，第二个子图
% bar(Lp2, 'facecolor', color2);
% ylabel('声压级/dB');
% set(gca,'xtick',ggg);grid;
% set(gca,'xticklabel',gg);
% % 绘制第三个子图
% subplot(3,1,3);  % 三行一列，第三个子图
% bar(Lp3, 'facecolor', color3);
% ylabel('声压级/dB');
% % 添加 x 轴标签和图标题
% xlabel('数据点');
% sgtitle('三个数据集的条形图');
% set(gca,'xtick',ggg);grid;
% set(gca,'xticklabel',gg);

