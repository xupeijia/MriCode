clear;
path = 'D:\Study\Projects\MRI\Data\Body\GE\';
path2 = 'D:\Study\Projects\MRI\Data\Body\GE\else\';
filelist = dir(strcat(path2, '*.txt'));
filename = filelist(1).name;
dataset = importdata(strcat(path2, filename), '	', 5);
x = dataset.data;
t = x(:,1);
v = x(:,2);
% index = 95*50000;
% for i = 1:5*50000
%     if v(i+index)>0.01
%         v(i+index) = 0.0085;
%         disp(i+index);
%     elseif v(i+index)<-0.01
%         v(i+index) = -0.0085;
%         disp(i+index);
%     else 
%         continue
%     end
% end
% writematrix([t, v], strcat(path2, filename), Delimiter='	');

plot(t, v)