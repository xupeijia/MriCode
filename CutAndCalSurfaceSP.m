clear;
% 将50k采样的振动速度数据进行整数采样周期裁剪和求导并保存t、a、v
pathfrom = 'D:\Study\Projects\MRI\Data\Body\GE\';
pathto1 = 'D:\Study\Projects\MRI\Data\Body\GE\sample50k\v\';
pathto2 = 'D:\Study\Projects\MRI\Data\Body\GE\sample50k\a\';
filelist = dir(strcat(pathfrom, '*.txt'));
Fs = 50000;
for i = 1:length(filelist)
    filename = filelist(i).name;
    prefix = str(split(filename, '.')(1));
    [t, x] = ReadAndCutVibration(strcat(pathfrom, filename), 6);
    y = diff(x)/(1/Fs);
    a = [0;y];
    writematrix([t,x],strcat(pathto1, filename));
    writematrix([t,a],strcat(pathto2, filename));
    disp(i)
end