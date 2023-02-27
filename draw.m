x = linspace(0,3*pi,1000);
y = sin(x);
y2 = -sin(x);
figure(1)
plot(x, y, x, y2, LineWidth=3);
y3 = 0.1*sin(5*x);
figure(2);
plot(y3,'black',LineWidth=3)
ylim([-1, 1])
