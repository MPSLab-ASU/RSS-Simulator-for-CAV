function [vehicle, path] = broadcastFuturePath(vehicle, World, simulation)
d_max = simulation.vmax*(simulation.rho + simulation.vmax/abs(simulation.amin)) + 0;
%% Finding the plan that is d_max long
path = struct;
path.x = World.Nodes.X(vehicle.plan);
path.y = World.Nodes.Y(vehicle.plan);
plan = [];
d1 = 0;
i = 1;
while d1 < d_max
    d1 = getGraphDistance(path, i);
    distances(i) = d1;
    plan = vehicle.plan(1:i);
    i = i + 1;
end
% vehicle.planHorizon = plan;
vehicle.path.x = World.Nodes.X(plan);
vehicle.path.y = World.Nodes.Y(plan);
vehicle.path.d = distances;
path.x = vehicle.path.x;
path.y = vehicle.path.y;
path.d = vehicle.path.d;
X = path.x;
Y = path.y;
D = path.d;
X0 = [vehicle.x-vehicle.CarLength/2*cos(deg2rad(vehicle.phi)) vehicle.x vehicle.x+vehicle.CarLength/2*cos(deg2rad(vehicle.phi))];
Y0 = [vehicle.y-vehicle.CarLength/2*sin(deg2rad(vehicle.phi)) vehicle.y vehicle.y+vehicle.CarLength/2*sin(deg2rad(vehicle.phi))];
D0 = [0.1 0.2 0.3];
path.x = [X0 X];
path.y = [Y0 Y];
path.d = [D0 D];
vehicle.path.x = [X0 vehicle.path.x];
vehicle.path.y = [Y0 vehicle.path.y];
vehicle.path.d = [D0 vehicle.path.d];


