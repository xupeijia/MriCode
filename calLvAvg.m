function LvAvg = calLvAvg(x1, x2, fs, fc)
%UNTITLED 此处提供此函数的摘要
%   此处提供详细说明
Lv1 = calOneThirdLv(x1, fs, fc);
Lv2 = calOneThirdLv(x2, fs, fc);
LvAvg = 10 * log10((10.^(0.1*Lv1)+10.^(0.1*Lv2))/2);
end