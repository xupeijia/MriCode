function y2 = realYNonlinear(x)
%UNTITLED2 此处提供此函数的摘要
%   此处提供详细说明
xAdd = zeros(12, 1);
x2 = cat(1, xAdd, x);
y2 = zeros(length(x), 1);
for i = 13:length(x2)
    y2(i-12) = 0.8*x2(i-6)+0.6*x2(i-7)-0.2*x2(i-8)-0.5*x2(i-9)-0.1*x2(i-10)+0.4*x2(i-11)-0.05*x2(i-12)+2.5*x2(i-6)^3;
    
end
end