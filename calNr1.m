function nr = calNr1(LpRound, fc, nrTable)
%UNTITLED3 此处提供此函数的摘要
%   此处提供详细说明
[m, n] = size(nrTable);
nr = zeros(1, length(fc));
for i = 2 : n
    for j = 2 : m - 1
        now = LpRound(i - 1);
        low = nrTable(j, i);
        high = nrTable(j + 1, i);
        if (now <= low) 
            nr(i - 1) = nrTable(j, 1);
            break;
        elseif (now > low && now < high)
            rate = (now - low) / (high - low);
            scale = nrTable(j + 1, 1) - nrTable(j, 1);
            nr(i - 1) = round(scale * rate) + nrTable(j, 1);
            break;
        elseif (now == high)
            nr(i - 1) = nrTable(j + 1, 1);
            break;
        else
            continue;
        end
    end
end
end