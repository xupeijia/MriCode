
function snr=snr_length(s,signal)%�����źŵ�����ȣ�s�������źţ�signal�Ǵ����ź�
signal=signal(:)';
s=s(:)';
E1=sum((s-mean(s)).^2);%�źŵ�����
E2=sum((s-signal).^2);%����������
snr=10*log10(E1/E2);
end