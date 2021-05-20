clc
clear all
close all

load CWTM1
% load uuu
time = 0.2:0.1:100;
V = zeros(length(time),size(ALLDATA.V{1},2));
A = V;PT = A; ft = A;
for i = 1:size(ALLDATA.V{1},2)
    V(:,i) = ALLDATA.V{1}(2:end,i);
end
for i = 1:size(ALLDATA.A{1},2)
    A(:,i) = ALLDATA.A{1}(2:end,i);
end
for i = 1:size(V,2)
    [PT(:,i),ft(:,i)] = fuelAndPowerConsumptionCalculation(A(:,i),V(:,i));
end
mean(mean(ft))
mean(mean(V))


load naIve1
% load uuu
time = 0.2:0.1:100;
V = zeros(length(time),size(ALLDATA.V{1},2));
A = V;PT = A; ft = A;
for i = 1:size(ALLDATA.V{1},2)
    V(:,i) = ALLDATA.V{1}(2:end,i);
end
for i = 1:size(ALLDATA.A{1},2)
    A(:,i) = ALLDATA.A{1}(2:end,i);
end
for i = 1:size(V,2)
    [PT(:,i),ft(:,i)] = fuelAndPowerConsumptionCalculation(A(:,i),V(:,i));
end
mean(mean(ft))
mean(mean(V))

function [PT,ft] = fuelAndPowerConsumptionCalculation(a,v)

beta2 = 0.03; % mL/(kJ.m/s^2)
beta1 = 0.0926; % mL/kJ
Pmax = 100; % kW
MV = 1250; % Kg
b2 = 0.0005; % kN/(m/s)^2
b1 = 0.1316; % kN
fi = 888.8; % mL/h
alpha = fi/3600; % ml/s
PG = 0;
PI = MV * a .* v / 1000;
PC = b1 * v + b2 * v.^3;
PT = min(Pmax, PC + PI + PG);
for i = 1:length(PT)
    if PT(i) > 0
        ft(i) = alpha + beta1 * PT(i) + beta2 * a(i) * PI(i);
    else
        ft(i) = alpha;
    end
end
end