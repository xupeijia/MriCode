
function snr=snr_length(s,signal)%计算信号的信噪比，s是语音信号，signal是带噪信号
signal=signal(:)';
s=s(:)';
E1=sum((s-mean(s)).^2);%信号的能量
E2=sum((s-signal).^2);%噪声的能量
snr=10*log10(E1/E2);
end