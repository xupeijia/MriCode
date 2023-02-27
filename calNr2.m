function nr = calNr2(LpRound, nc)
%UNTITLED5 此处提供此函数的摘要
%   此处提供详细说明
nr = zeros(1, length(nc));
A = [55.4 35.5 22 12 4.8 0 -3.5 -6.1 -8];
B = [0.68 0.79 0.87 0.93 0.974 1 1.015 1.025 1.03];
for i = 1 : length(nc)
    nr(i) = round((LpRound(i) - A(i)) / B(i));
end