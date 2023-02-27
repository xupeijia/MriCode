function noy = calNoy(Lpval, nc, noyTable)
%UNTITLED4 此处提供此函数的摘要
%   此处提供详细说明
noy = zeros(1,24);
for i = 1:nc
    noy(i) = noyTable(Lpval(i), i);
end