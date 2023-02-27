clear;
% 将50k采样的振动速度数据进行整数采样周期分割后求导并保存t,v,a
pathfrom = 'D:\Study\Projects\MRI\Data\Body\GE\';
pathto1 = 'D:\Study\Projects\MRI\Data\Body\GE\sample50k\v\';
pathto2 = 'D:\Study\Projects\MRI\Data\Body\GE\sample50k\a\';
filelist = dir(strcat(pathfrom, '*.txt'));
Fs = 50000;
for i = 1:length(filelist)
    filename = filelist(i).name;
    % 取出filename的前缀用于拼接，其中filenames为cell类型，要提取里面的str类型需要用{}索引
    filenames = split(filename, '.');
    prefix = filenames{1};
    [t, v] = ReadAndCutVibration(strcat(pathfrom, filename), 5);
    a = diff(v)/(1/Fs);
    writematrix([t',v],strcat(pathto1, prefix, '.csv'));
    writematrix([t(1:end-1)',a],strcat(pathto2, prefix, '.csv'));
    disp(i)
end