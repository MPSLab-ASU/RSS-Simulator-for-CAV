clear all;
close all;
load nodeadlock
figure 
hold on
t = 0.1:0.1:8.9;
plot(t,ALLDATA.V{1}(2:end,1), '--', 'Color', [1 0 0], 'LineWidth', 1)
plot(t,ALLDATA.V{1}(2:end,2), '--', 'Color', [0 1 0], 'LineWidth', 1)
plot(t,ALLDATA.V{1}(2:end,3), '--', 'Color', [0 0 1], 'LineWidth', 1)
plot(t,ALLDATA.V{1}(2:end,4), '--', 'Color', [0.7 0.7 0], 'LineWidth', 1)
load deadlock
plot(t,ALLDATA.V{1}(2:end,1), '-', 'Color', [1 0 0], 'LineWidth', 1)
plot(t,ALLDATA.V{1}(2:end,2), '-', 'Color', [0 1 0], 'LineWidth', 1)
plot(t,ALLDATA.V{1}(2:end,3), '-', 'Color', [0 0 1], 'LineWidth', 1)
plot(t,ALLDATA.V{1}(2:end,4), '-', 'Color', [0.7 0.7 0], 'LineWidth', 1)

legend('CAV1','CAV2','CAV3','CAV4')
grid on
xlabel('Time (s)')
ylabel('Velocity (m/s)')