clear
N = 64; %number of samples
fs = 10; %sampling frequency
ts = 1/fs; %sample interval
tmax = (N-1)*ts;
t = 0:ts:tmax;
y = exp(1i*2*pi*t);
ycheck = cos(2*pi*t);

% plot test signals
figure(1)
% plot(t,y)
% hold on
plot(t,ycheck,'r--')

% fft
Y = fft(y);
% Ycheck = fft(ycheck);
% 
% % phase shift
% Y = abs(Y).*exp(1i*angle(Y)-1i*pi/4); % -pi/4 shift
% % Ycheck = abs(Ycheck).*exp(1i*angle(Ycheck)-1i*pi/4); % -pi/4 shift
% phi = -pi/4; %/ desired phase shift
% ind = 1:numel(Ycheck)/2+1; %// lower half
% Ycheck(ind) = abs(Ycheck(ind)).*exp(1i*angle(Ycheck(ind))+1i*phi); %// add 1i*phi
% ind = numel(Ycheck)/2+2:numel(Ycheck); %// upper half
% Ycheck(ind) = abs(Ycheck(ind)).*exp(1i*angle(Ycheck(ind))-1i*phi); %// subtract 1i*phi
%   
% Ycheck2 = Ycheck;
% Ycheckuper = conj(Ycheck2(1:numel(Ycheck)/2+1));
% Ycheck2(numel(Ycheck2)/2+2:end) = Ycheckuper(end-1:-1:2);
% 
% %ifft
% u = ifft(Y);
% ucheck = ifft(Ycheck);
% ucheck2 = ifft(Ycheck2);
% 
% % plot
% figure(2)
% plot(t,real(u),'k')
% hold on    
% plot(t,real(y),'r')
% hold on
% plot(t,real(ucheck),'g')
% hold on
% plot(t,ycheck,'b--')
% hold on
% plot(t, real(ucheck2), '*');
% % legend('ifft(exp(1i*2*pi*t)) %-pi/4shift','real(cos(2*pi*t))','ifft(cos(2*pi*t)) %-pi/4 shift','cos(2*pi*t)')