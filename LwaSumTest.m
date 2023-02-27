figure(5);
LwaSum1 = 74.5765;
LwaSum2 = 65.7218;
LwaSum = [LwaSum1,LwaSum2];
color_matrix = [0 0.45 0.74;0.85 0.33 0.10];  %每个柱子的颜色设置
bar(LwaSum);
hold on;
for i = 1:2
    b = bar(i,LwaSum(i));
    text(i,LwaSum(i)+0.5,num2str(LwaSum(i).','%.2f'),'VerticalAlignment','bottom','HorizontalAlignment','center');
    set(b,'facecolor',color_matrix(i,:));
end
set(gca,'XTickLabel',{'头颅常规序列', '头颅静音序列'});%设置柱状图每个柱子的横坐标
ylabel('dB');