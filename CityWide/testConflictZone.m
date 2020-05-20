clc;clear all;close all
figure;hold on;
X = [-2.5 2.5 2.5 -2.5];
Y = [-1 -1 1 1];
th = pi/4;

tx = 10;
ty = 12;
RX = X * cos(th) - Y * sin(th);
RY = X * sin(th) + Y * cos(th);
TX = RX + tx;
TY = RY + ty;
XX = [TX TX(1)];
YY = [TY TY(1)];
line(XX,YY)
plot(tx,ty,'*')
axis([0 20 0 20])
grid on
set(gca,'xtick',[0:20])
set(gca,'ytick',[0:20])

xmin = floor(min(TX));
ymin = floor(min(TY));
xmax = ceil(max(TX));
ymax = ceil(max(TY));

CX = [];CY =[];
for i = xmin-1:xmax
    for j = ymin-1:ymax
        CX = [CX i+0.5];
        CY = [CY j+0.5];
    end
end
plot(CX,CY,'o')