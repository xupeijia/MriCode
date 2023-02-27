clear;
% 绘制振动评价过程中各种计权曲线
data = readmatrix("振动评价数据.xlsx", Sheet="Sheet2");
fc=data(:,1);
nfc = length(fc);
f1 = 9:45;
f2 = 2:25;
wk=data(:,2);wk = wk(9:end);
wd=data(:,3);wd = wd(9:end);
wf=data(:,4);wf = wf(2:25);
wc=data(:,5);wc = wc(9:end);
we=data(:,6);we = we(9:end);
wj=data(:,7);wj = wj(9:end);
ggg = (1:3:nfc);
gg = fc(1:3:nfc);

set(0,'DefaultTextFontSize',10.5); % 设置字体大小为10.5
set(0,'DefaultAxesFontSize',10.5); % 设置坐标轴的字体大小为10.5
figure(1);
plot(f1, wk,LineWidth=1);
hold on;
plot(f1, wd, '--', LineWidth=1);
plot(f2, wf, '-.',LineWidth=1);
set(gca,'XTick',ggg);grid%网格线
set(gca,'XTickLabels',gg, 'Fontsize', 10.5);
set(gca,'Units','centimeters','Position',[3 3 12 7],'linewidth',1);
xlabel('\fontname{宋体}频率\fontname{Times} (Hz)', 'Fontsize', 10.5);
ylabel('\fontname{宋体}频率计权\fontname{Times} (dB)', 'Fontsize', 10.5);
legend('\fontname{Times} \itW_k', '\fontname{Times} \itW_d', '\fontname{Times} \itW_d', Orientation='horizontal', Box='off', Location='northeast', Fontsize=10.5);
hold off;

figure(2);
plot(f1, wc,LineWidth=1);
hold on;
plot(f1, we, '--', LineWidth=1);
plot(f1, wj, '-.',LineWidth=1);
set(gca,'XTick',ggg);grid%网格线
set(gca,'XTickLabels',gg, 'Fontsize', 10.5);
set(gca,'Units','centimeters','Position',[3 3 12 7],'linewidth',1, 'Fontsize', 10.5);
ylim([-80 20])
yticks(-80:20:20)
xlabel('\fontname{宋体}频率\fontname{Times} (Hz)', 'Fontsize', 10.5);
ylabel('\fontname{宋体}频率计权\fontname{Times} (dB)', 'Fontsize', 10.5);
legend('\fontname{Times} \itW_k', '\fontname{Times} \itW_d', '\fontname{Times} \itW_d', Orientation='horizontal', Box='off', Location='northeast', Fontsize=10.5);
hold off;