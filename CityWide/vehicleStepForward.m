function vehicle = vehicleStepForward(vehicle,simulation)
%% De-marshaling
% simulation constants
h=simulation.stepTime;
saimax=simulation.saimax;
saimin=simulation.saimin;
vmax=simulation.vmax;
vmin=simulation.vmin;
amax=simulation.amax;
amin=simulation.amin;

% vehicle variables
x = vehicle.x;
y = vehicle.y;
phi = deg2rad(vehicle.phi);
v = vehicle.v;
v_r = vehicle.v_r;
yref = vehicle.yref;
xref = vehicle.xref;
e_I_angle = vehicle.e_I_angle;
e_angle_prev = vehicle.e_angle_prev;
control_mode = vehicle.control_mode;
e_velocity_p = vehicle.e_velocity_p;

% vehicle constants
L = vehicle.wheelbase;
k_v_P = vehicle.k_v_P;
k_v_D = vehicle.k_v_D;
k_d_P = vehicle.k_d_P;
k_a_P = vehicle.k_a_P;
k_a_I = vehicle.k_a_I; 
k_a_D = vehicle.k_a_D;

%% error calc. and control
% speed and distance error
e_distance = sqrt((yref - y)^2+(xref - x)^2);
e_velocity = v_r - v;
e_velocity_d = (e_velocity_p - e_velocity )/simulation.stepTime;
e_velocity_p = e_velocity;
% acceleration control law
if strcmp(control_mode, 'speed')
    a = k_v_P * e_velocity + k_v_D * e_velocity_d; % p-controller
end
if strcmp(control_mode, 'distance')
    a = k_d_P * e_distance;
end

% orientation error
phi_r = atan2(yref - y, xref - x);


e_angle = phi_r - phi;

if e_angle > pi
    e_angle = -(2*pi - e_angle);
end
if e_angle < -pi
    e_angle = 2*pi + e_angle;
end

e_I_angle = e_I_angle + h * (e_angle);
e_D = (e_angle - e_angle_prev)/h;
e_angle_prev = e_angle;
% steering control law
sai = k_a_P*(e_angle) + k_a_I*(e_I_angle) +k_a_D * (e_D); % PID controller

% saturation
if sai > saimax
    sai = saimax;
end
if sai < saimin
    sai = saimin;
end
if a > amax
    a = amax;
end
if a < amin
    a = amin;
end

%% Dynamics
x_out = x + h * v * cos(phi);
y_out = y + h * v * sin(phi);
phi_out = phi + h * v/L * tan(sai);
v_out = v + h * a;

% saturation
if v_out > vmax
    v_out = vmax;
end
if v_out < vmin
    v_out = vmin;
end
if phi_out > pi
    phi_out = phi_out - 2*pi;
end
if phi_out < -pi 
    phi_out = phi_out + 2*pi;
end

%% Marshaling
vehicle.x = x_out;
vehicle.y = y_out;
vehicle.phi = rad2deg(phi_out);
vehicle.v = v_out;
vehicle.a = a;
vehicle.e_velocity_p = e_velocity_p;
vehicle.e_I_angle = e_I_angle;
vehicle.e_angle_prev = e_angle_prev;
vehicle.bearing = phi_r;
end

