function [Lpn1, Lpn2, Lpn3] = calLpn(noy, LpaSum)
%UNTITLED 此处提供此函数的摘要
%   此处提供详细说明
Nm = max(noy);
% 计算方式一、环境噪声控制工程第二版.毛东兴；（P72）所给定公式：
F = 0.5;
Nt = Nm + F * (sum(noy) - Nm);
Lpn1 = 40 + 10 * log2(Nt);

% 计算方式二、环境噪声控制工程第二版.毛东兴；（P73）所给定近似计算法：
Lpn2 = LpaSum + 13;

% 计算方式三、噪声与振动控制工程手册.马大猷；（P719）所给定公式：
F3 = 0.15;
Nt3 = Nm + F3 * (sum(noy) - Nm);
Lpn3 = 40 + 33.3 * log10(Nt3);
end