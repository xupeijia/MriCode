% filename='newGE1.wav';
% [x,fs]=audioread(filename);

filename = 'GE-SZNGA Premier-3D-AXT1-MPR.txt';
dataset = importdata(filename,'	',6);%导入数据
% dataset = importdata(filename);%导入数据
data = dataset.data;% 只加载数字部分
t = data(:,1);
x = data(:,2);

Pw=[0.01 0.25 0.5 1 0.5 0.25 0.01];
Sw=Pw*0.25;
[H, w] = freqz(Pw, 1);
H0 = abs(H(1));
Yd=filter(Pw, 1, x);

fxlms = dsp.FilteredXLMSFilter(16,"StepSize",1,"SecondaryPathCoefficients",Sw);
[y, error] = fxlms(x, Yd);
figure(1)
subplot(2,1,1)
plot(t, error)
ylim([-0.6, 0.6])
ylabel('幅值');
xlabel('时间');
legend('残余噪声')
subplot(2,1,2)
plot(t, y)

hold on 
plot(t, y - error);
ylabel('幅值');
xlabel('时间');
legend('噪声信号', '控制信号')
hold off;

figure(2);
plot(t, y, t, x)