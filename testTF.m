clear
T=1000; % 仿真持续时间
% 我们不知道p(z)和S(z)，所以我们必须建立dummy虚拟路径
Pw=[0.01 0.25 0.5 1 0.5 0.25 0.01];
Sw=Pw*0.25;

filename = 'GE-SZNGA Premier-3D-AXT1-MPR.txt';
startLine = 6;
dataset = importdata(filename,'	', startLine);
inputdata = dataset.data;
x = inputdata(:, 2);
x = x';
len = length(x);

% 送至actuator执行，在传感器位置测量，
y_iden=filter(Pw, 1, x);
x = [0 0 0 0 0 0 x];
y = zeros(1,len);
for i = 7:len+6
    y(i) = 0.01*x(i)+0.25*x(i-1)+0.5*x(i-2)+1*x(i-3)+0.5*x(i-4)+0.25*x(i-5)+0.01*x(i-6);
end