clc;clear all;close all;
%% De-marshaling
% simulation constants
h=0.01;
saimax=pi/4;
saimin=-pi/4;
vmax=10;
vmin=0;
amax=5;
amin=-5;

% vehicle variables
x(1) = 0;
y(1) = 0;
phi(1) = 0;
v(1) = 10;
v_r = 10;
% yref = vehicle.yref;
% xref = vehicle.xref;
% e_I_angle = vehicle.e_I_angle;
% e_angle_prev = vehicle.e_angle_prev;
% control_mode = vehicle.control_mode;
% 
% % vehicle constants
% L = vehicle.wheelbase;
% k_v_P = vehicle.k_v_P;
% k_d_P = vehicle.k_d_P;
% k_a_P = vehicle.k_a_P;
% k_a_I = vehicle.k_a_I; 
% k_a_D = vehicle.k_a_D;

%% error calc. and control
% speed and distance error
% e_distance = sqrt((yref - y)^2+(xref - x)^2);
% e_velocity = v_r - v;
% % acceleration control law
% if strcmp(control_mode, 'speed')
%     a = k_v_P * e_velocity; % p-controller
% end
% if strcmp(control_mode, 'distance')
%     a = k_d_P * e_distance;
% end
% 
% % orientation error
% phi_r = atan2(yref - y, xref - x);
% 
% 
% e_angle = phi_r - phi;
% 
% if e_angle > pi
%     e_angle = -(2*pi - e_angle);
% end
% if e_angle < -pi
%     e_angle = 2*pi + e_angle;
% end
% 
% e_I_angle = e_I_angle + h * (e_angle);
% e_D = (e_angle - e_angle_prev)/h;
% e_angle_prev = e_angle;
% steering control law
sai = pi/4; % PID controller
a = 0;
% saturation
% if sai > saimax
%     sai = saimax;
% end
% if sai < saimin
%     sai = saimin;
% end
% if a > amax
%     a = amax;
% end
% if a < amin
%     a = amin;
% end
L = 0.35;
%% Dynamics
for i = 1:100
x(i+1) = x(i) + h * v(i) * cos(phi(i));
y(i+1) = y(i) + h * v(i) * sin(phi(i));
phi(i+1) = phi(i) + h * v(i)/L * tan(sai);
v(i+1) = v(i) + h * a;
end
plot(x,y)



