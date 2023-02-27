
function[signal,noise]=add_n(s,n_path,fs,snr)%sΪ�źţ�n_pathΪ����·���������֣�fsΪ�źŵĲ���Ƶ�ʣ�snrΪ�������õ������
s=s(:)';
sl=length(s);
[n,fs1]=audioread(n_path);
n=n(:)';
if fs~=fs1
    n1=resample(n,fs,fs1);
else
    n1=n;
end
noise=n1(1:sl);

E1=1/sl*sum(s.*s);%����ź�����
E2=1/sl*sum(noise.*noise);%��������
noise=sqrt(E1/(10^(snr/10))/E2)*noise;
signal=s+noise;