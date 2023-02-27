%main
clc;
filedir=[];
filename='newGE1.wav';
fle=[filedir filename];
[s,fs]=audioread(fle);
N=length(s(:));
time=(0:N-1)/fs;
snr=5;
M=32;
mu=0.001;
[r1,r2]=add_n(s,'babble1.wav',fs,snr);%r1为语音+噪音，r2为噪音信号,此函数产生一个信噪比为snr的带噪语音
snr1=snr_length(s,r1);%s是纯净语音信号，r1是带噪信号
%如何使用dsp.lmsfilter函数？
r1 = r1';
lms1=dsp.LMSFilter(32,'StepSize',0.001);%dsp.LMSFilter
[z,e,w] = lms1(r1,s(:));%r1为语音+噪音，r2为噪音信号

output=z;%lms滤波的输出
snr2=snr_length(s,output');
fprintf('snr1=%.5f   snr2=%.5f   snr=%.5f\n',snr1,snr2,snr1-snr2);
figure(1)
subplot(3,1,1);plot(time,s(:),'k');ylabel('幅值');title('原始声音信号');
subplot(3,1,2);plot(time,r1,'k');ylabel('幅值');title('叠加噪音后的声音信号');
subplot(3,1,3);plot(time,output,'k');ylabel('幅值');title('LMS滤波后的声音信号');xlabel('时间/s');
figure(2)
plot(10*log(abs(e)));
ylabel('幅值（dB）');title('LMS滤波后的误差');xlabel('时间/s');
