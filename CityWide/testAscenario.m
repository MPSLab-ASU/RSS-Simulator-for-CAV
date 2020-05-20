clc;clear all;close all;
h = 0.1;
N = 100;
k = 2;
x1(1) = 0;v1(1) = 5;dV1toC2 = 16; dV1toC1 = 1;
x2(1) = -4;v2(1) = 10;dV2toC1 = 5;dV2toC2 = 26;
d_RSS = 4;
for i = 1:N
    
    v1r(i) = v2(i)*(dV1toC2 - d_RSS)/ dV2toC2;
    v2r(i) = v1(i)*(dV2toC1 - d_RSS)/ dV1toC1;
    
    x1(i+1) = x1(i) + h * (v1(i));
    v1(i+1) = v1(i) + h * (k * (v1r(i) - v1(i)));
    x2(i+1) = x2(i) + h * (v2(i));
    v2(i+1) = v2(i) + h * (k * (v2r(i) - v2(i)));
    
    dV1toC2 = dV1toC2 - (x1(i+1) - x1(i));
    dV2toC1 = dV2toC1 - (x2(i+1) - x2(i));
    if v1(i+1) > v2(i+1)
        disp('resolved');
        v1(i+1) = 20;
    end
end
plot(v1)
hold
plot(v2)