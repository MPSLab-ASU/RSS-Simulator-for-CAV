clc
clear all
close all
load naIve
time = 0.05:0.05:180;
V1 = ALLDATA.V{1}(:,1);
V2 = ALLDATA.V{1}(:,2);
V3 = ALLDATA.V{1}(:,3);
V4 = ALLDATA.V{1}(:,4);
V5 = ALLDATA.V{1}(:,5);
V6 = ALLDATA.V{1}(:,6);
A1 = ALLDATA.A{1}(:,1);
A2 = ALLDATA.A{1}(:,2);
A3 = ALLDATA.A{1}(:,3);
A4 = ALLDATA.A{1}(:,4);
A5 = ALLDATA.A{1}(:,5);
A6 = ALLDATA.A{1}(:,6);
AVG1 = mean(mean([V1 V2 V3 V4 V5 V6]));

load CWTM
V11 = ALLDATA.V{1}(:,1);
V22 = ALLDATA.V{1}(:,2);
V33 = ALLDATA.V{1}(:,3);
V44 = ALLDATA.V{1}(:,4);
V55 = ALLDATA.V{1}(:,5);
V66 = ALLDATA.V{1}(:,6);
A11 = ALLDATA.A{1}(:,1);
A22 = ALLDATA.A{1}(:,2);
A33 = ALLDATA.A{1}(:,3);
A44 = ALLDATA.A{1}(:,4);
A55 = ALLDATA.A{1}(:,5);
A66 = ALLDATA.A{1}(:,6);
AVG2 = mean(mean([V11 V22 V33 V44 V55 V66]));


%% plot energy and fuel
subplot(6,1,1)
plot(time,V1, 'LineWidth', 2)
hold on
grid on
plot(time,V11, 'LineWidth', 2)
plot(time,ones(length(V1),1)*mean(V1), '--', 'LineWidth', 2)
plot(time,ones(length(V11),1)*mean(V11), ':', 'LineWidth', 2)
axis([0 180 0 12])
STR = 'Speed Profile for CAV1';
title(STR, 'FontSize', 11);
xlabel('Time(m)', 'FontSize',10, 'FontWeight','bold')
ylabel('Power (kW)', 'FontSize',10, 'FontWeight','bold')
set(gca,'FontSize',10, 'FontWeight','bold')

subplot(6,1,2)
plot(time,V2, 'LineWidth', 2)
hold on 
grid on
plot(time,V22, 'LineWidth', 2)
plot(time,ones(length(V2),1)*mean(V2), '--', 'LineWidth', 2)
plot(time,ones(length(V22),1)*mean(V22), ':', 'LineWidth', 2)
axis([0 180 0 12])
STR = 'Speed Profile for CAV2';
title(STR, 'FontSize', 11);
xlabel('Time(m)', 'FontSize',10, 'FontWeight','bold')
ylabel('Velocity(m/s)', 'FontSize',10, 'FontWeight','bold')
set(gca,'FontSize',10, 'FontWeight','bold')

subplot(6,1,3)
plot(time,V3, 'LineWidth', 2)
hold on 
grid on
plot(time,V33, 'LineWidth', 2)
plot(time,ones(length(V3),1)*mean(V3), '--', 'LineWidth', 2)
plot(time,ones(length(V33),1)*mean(V33), ':', 'LineWidth', 2)
axis([0 180 0 12])
STR = 'Speed Profile for CAV3';
title(STR, 'FontSize', 11);
xlabel('Time(m)', 'FontSize',10, 'FontWeight','bold')
ylabel('Velocity(m/s)', 'FontSize',10, 'FontWeight','bold')
set(gca,'FontSize',10, 'FontWeight','bold')

subplot(6,1,4)
plot(time,V4, 'LineWidth', 2)
hold on 
grid on
plot(time,V44, 'LineWidth', 2)
plot(time,ones(length(V4),1)*mean(V4), '--', 'LineWidth', 2)
plot(time,ones(length(V44),1)*mean(V44), ':', 'LineWidth', 2)
axis([0 180 0 12])
STR = 'Speed Profile for CAV4';
title(STR, 'FontSize', 11);
xlabel('Time(m)', 'FontSize',10, 'FontWeight','bold')
ylabel('Velocity(m/s)', 'FontSize',10, 'FontWeight','bold')
set(gca,'FontSize',10, 'FontWeight','bold')

subplot(6,1,5)
plot(time,V5, 'LineWidth', 2)
hold on 
grid on
plot(time,V55, 'LineWidth', 2)
plot(time,ones(length(V5),1)*mean(V5), '--', 'LineWidth', 2)
plot(time,ones(length(V55),1)*mean(V55), ':', 'LineWidth', 2)
axis([0 180 0 12])
STR = 'Speed Profile for CAV5';
title(STR, 'FontSize', 11);
xlabel('Time(m)', 'FontSize',10, 'FontWeight','bold')
ylabel('Velocity(m/s)', 'FontSize',10, 'FontWeight','bold')
set(gca,'FontSize',10, 'FontWeight','bold')

subplot(6,1,6)
plot(time,V6, 'LineWidth', 2)
hold on 
grid on
plot(time,V66, 'LineWidth', 2)
plot(time,ones(length(V6),1)*mean(V6), '--', 'LineWidth', 2)
plot(time,ones(length(V66),1)*mean(V66), ':', 'LineWidth', 2)
axis([0 180 0 12])
STR = 'Speed Profile for CAV5';
title(STR, 'FontSize', 11);
xlabel('Time(m)', 'FontSize',10, 'FontWeight','bold')
ylabel('Velocity(m/s)', 'FontSize',10, 'FontWeight','bold')
set(gca,'FontSize',10, 'FontWeight','bold')

legend('Naive Traffic Management','Cooperative Traffic Management','Naive AVG Speed','Cooperative Naive Speed')
ax = gcf;
ax.Position= [680 168 745 810];


figure
[PT1,ft1] = fuelAndPowerConsumptionCalculation(A1,V1);
[PT2,ft2] = fuelAndPowerConsumptionCalculation(A2,V2);
[PT3,ft3] = fuelAndPowerConsumptionCalculation(A3,V3);
[PT4,ft4] = fuelAndPowerConsumptionCalculation(A4,V4);
[PT5,ft5] = fuelAndPowerConsumptionCalculation(A5,V5);
[PT6,ft6] = fuelAndPowerConsumptionCalculation(A6,V6);

[PT11,ft11] = fuelAndPowerConsumptionCalculation(A11,V11);
[PT22,ft22] = fuelAndPowerConsumptionCalculation(A22,V22);
[PT33,ft33] = fuelAndPowerConsumptionCalculation(A33,V33);
[PT44,ft44] = fuelAndPowerConsumptionCalculation(A44,V44);
[PT55,ft55] = fuelAndPowerConsumptionCalculation(A55,V55);
[PT66,ft66] = fuelAndPowerConsumptionCalculation(A66,V66);

% P1 = mean([mean(PT1) mean(PT2) mean(PT3) mean(PT4) mean(PT5) mean(PT6)]);
% P11 = mean([mean(PT11) mean(PT22) mean(PT33) mean(PT44) mean(PT55) mean(PT66)]);
% percentageOfEnergy = 1 - f11/f1;

f1 = mean([mean(ft1) mean(ft2) mean(ft3) mean(ft4) mean(ft5) mean(ft6)]);
f11 = mean([mean(ft11) mean(ft22) mean(ft33) mean(ft44) mean(ft55) mean(ft66)]);
c = categorical({'Naive Traffic Management','Our Approach'});
bar(c, [f1 f11])
ylabel('Fuel Consumption (mL/s)')
title('Comparing the average fuel consumption')
percentageOfFuel = 1 - f11/f1;

% %% plot velocity
% 
% subplot(6,1,1)
% 
% plot(time,V1, 'LineWidth', 2)
% hold on 
% grid on
% plot(time,V11, 'LineWidth', 2)
% plot(time,ones(length(V1),1)*mean(V1), '--', 'LineWidth', 2)
% plot(time,ones(length(V11),1)*mean(V11), ':', 'LineWidth', 2)
% axis([0 180 0 12])
% STR = 'Speed Profile for CAV1';
% title(STR, 'FontSize', 11);
% xlabel('Time(m)', 'FontSize',10, 'FontWeight','bold')
% ylabel('Velocity(m/s)', 'FontSize',10, 'FontWeight','bold')
% set(gca,'FontSize',10, 'FontWeight','bold')
% 
% subplot(6,1,2)
% plot(time,V2, 'LineWidth', 2)
% hold on 
% grid on
% plot(time,V22, 'LineWidth', 2)
% plot(time,ones(length(V2),1)*mean(V2), '--', 'LineWidth', 2)
% plot(time,ones(length(V22),1)*mean(V22), ':', 'LineWidth', 2)
% axis([0 180 0 12])
% STR = 'Speed Profile for CAV2';
% title(STR, 'FontSize', 11);
% xlabel('Time(m)', 'FontSize',10, 'FontWeight','bold')
% ylabel('Velocity(m/s)', 'FontSize',10, 'FontWeight','bold')
% set(gca,'FontSize',10, 'FontWeight','bold')
% 
% subplot(6,1,3)
% plot(time,V3, 'LineWidth', 2)
% hold on 
% grid on
% plot(time,V33, 'LineWidth', 2)
% plot(time,ones(length(V3),1)*mean(V3), '--', 'LineWidth', 2)
% plot(time,ones(length(V33),1)*mean(V33), ':', 'LineWidth', 2)
% axis([0 180 0 12])
% STR = 'Speed Profile for CAV3';
% title(STR, 'FontSize', 11);
% xlabel('Time(m)', 'FontSize',10, 'FontWeight','bold')
% ylabel('Velocity(m/s)', 'FontSize',10, 'FontWeight','bold')
% set(gca,'FontSize',10, 'FontWeight','bold')
% 
% subplot(6,1,4)
% plot(time,V4, 'LineWidth', 2)
% hold on 
% grid on
% plot(time,V44, 'LineWidth', 2)
% plot(time,ones(length(V4),1)*mean(V4), '--', 'LineWidth', 2)
% plot(time,ones(length(V44),1)*mean(V44), ':', 'LineWidth', 2)
% axis([0 180 0 12])
% STR = 'Speed Profile for CAV4';
% title(STR, 'FontSize', 11);
% xlabel('Time(m)', 'FontSize',10, 'FontWeight','bold')
% ylabel('Velocity(m/s)', 'FontSize',10, 'FontWeight','bold')
% set(gca,'FontSize',10, 'FontWeight','bold')
% 
% subplot(6,1,5)
% plot(time,V5, 'LineWidth', 2)
% hold on 
% grid on
% plot(time,V55, 'LineWidth', 2)
% plot(time,ones(length(V5),1)*mean(V5), '--', 'LineWidth', 2)
% plot(time,ones(length(V55),1)*mean(V55), ':', 'LineWidth', 2)
% axis([0 180 0 12])
% STR = 'Speed Profile for CAV5';
% title(STR, 'FontSize', 11);
% xlabel('Time(m)', 'FontSize',10, 'FontWeight','bold')
% ylabel('Velocity(m/s)', 'FontSize',10, 'FontWeight','bold')
% set(gca,'FontSize',10, 'FontWeight','bold')
% 
% subplot(6,1,6)
% plot(time,V6, 'LineWidth', 2)
% hold on 
% grid on
% plot(time,V66, 'LineWidth', 2)
% plot(time,ones(length(V6),1)*mean(V6), '--', 'LineWidth', 2)
% plot(time,ones(length(V66),1)*mean(V66), ':', 'LineWidth', 2)
% axis([0 180 0 12])
% STR = 'Speed Profile for CAV5';
% title(STR, 'FontSize', 11);
% xlabel('Time(m)', 'FontSize',10, 'FontWeight','bold')
% ylabel('Velocity(m/s)', 'FontSize',10, 'FontWeight','bold')
% set(gca,'FontSize',10, 'FontWeight','bold')
% 
% legend('Naive Traffic Management','Cooperative Traffic Management','Naive AVG Speed','Cooperative Naive Speed')
% ax = gcf;
% ax.Position= [680 168 745 810];


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