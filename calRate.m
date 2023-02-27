function outputArg1 = calRate(inputArg1,inputArg2)
%UNTITLED4 此处提供此函数的摘要
%   此处提供详细说明
len = length(inputArg1);
a = zeros(1, len);
outputArg1 = string(a);
for i = 1:len
    temp = round((inputArg1(i)-inputArg2(i))*100/inputArg1(i));
    outputArg1(i) =  strcat(num2str(temp), '%');
end

end