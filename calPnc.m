function pnc = calPnc(LpRound, fc, pncTable)
%UNTITLED 此处提供此函数的摘要
%   此处提供详细说明
[m, n] = size(pncTable);
pnc = zeros(1, length(fc));
for i = 2 : n
    for j = 2 : m - 1
        now = LpRound(i - 1);
        low = pncTable(j, i);
        high = pncTable(j + 1, i);
        mid = (low + high)/2;
        if (now < mid) 
            pnc(i - 1) = pncTable(j, 1);
            break;
        elseif (now <= high)
            pnc(i - 1) = pncTable(j + 1, 1);
            break;
        else 
            continue;
        end
    end
end
% 如果超过PNC65，则取为65
for j = 1 : length(fc)
    if (pnc(j) == 0)
        pnc(j) = pncTable(m, 1);
    end
end