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
[r1,r2]=add_n(s,'babble1.wav',fs,snr);%r1Ϊ����+������r2Ϊ�����ź�,�˺�������һ�������Ϊsnr�Ĵ�������
snr1=snr_length(s,r1);%s�Ǵ��������źţ�r1�Ǵ����ź�
%���ʹ��dsp.lmsfilter������
r1 = r1';
lms1=dsp.LMSFilter(32,'StepSize',0.001);%dsp.LMSFilter
[z,e,w] = lms1(r1,s(:));%r1Ϊ����+������r2Ϊ�����ź�

output=z;%lms�˲������
snr2=snr_length(s,output');
fprintf('snr1=%.5f   snr2=%.5f   snr=%.5f\n',snr1,snr2,snr1-snr2);
figure(1)
subplot(3,1,1);plot(time,s(:),'k');ylabel('��ֵ');title('ԭʼ�����ź�');
subplot(3,1,2);plot(time,r1,'k');ylabel('��ֵ');title('����������������ź�');
subplot(3,1,3);plot(time,output,'k');ylabel('��ֵ');title('LMS�˲���������ź�');xlabel('ʱ��/s');
figure(2)
plot(10*log(abs(e)));
ylabel('��ֵ��dB��');title('LMS�˲�������');xlabel('ʱ��/s');
