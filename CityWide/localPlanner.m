function vehicle = localPlanner(vehicle, World, simulation)
minDistance = 100000;
P = vehicle.plan;
% planID = vehicle.planID;
% frontX = vehicle.x + (vehicle.CarLength/2)*cos(deg2rad(vehicle.phi));
% frontY = vehicle.y + (vehicle.CarWidth/2)*sin(deg2rad(vehicle.phi));
distance = sqrt((World.Nodes.X(P(1)) - vehicle.x)^2 + (World.Nodes.Y(P(1)) - vehicle.y )^2);


while distance < 4 && length(P) > 2
    P = P(2:end);
    vehicle.plan = P;
    %     frontX = vehicle.x + (vehicle.CarLength/2)*cos(deg2rad(vehicle.phi));
    %     frontY = vehicle.y + (vehicle.CarWidth/2)*sin(deg2rad(vehicle.phi));
    distance = sqrt((World.Nodes.X(P(1)) - vehicle.x)^2 + (World.Nodes.Y(P(1)) - vehicle.y )^2);
end
d_max = simulation.vmax*(simulation.rho + simulation.vmax/abs(simulation.amin));
path = struct;
path.x = World.Nodes.X(vehicle.plan);
path.y = World.Nodes.Y(vehicle.plan);
plan = [];
d1 = 0;
i = 1;
while d1 < d_max && i < length(path.x)
    %     if length(path.x) < i
    %         disp('error')
    %     end
    d1 = getGraphDistance(path, i);
    distances(i) = d1;
    plan = vehicle.plan(1:i);
    i = i + 1;
end
vehicle.planHorizon = plan;
%% add waypoints for the vehicle occupying area
% frontX = vehicle.x + (vehicle.CarLength/2)*cos(deg2rad(vehicle.phi));
% frontY = vehicle.y + (vehicle.CarWidth/2)*sin(deg2rad(vehicle.phi));
% rearX = vehicle.x - (vehicle.CarLength/2)*cos(deg2rad(vehicle.phi));
% rearY = vehicle.y - (vehicle.CarWidth/2)*sin(deg2rad(vehicle.phi));
% minDistance = 100000;
% for i = 1:length(World.Nodes.X)
%     distance = sqrt((World.Nodes.X(i) - frontX)^2 + (World.Nodes.Y(i) - frontY)^2);
%     if distance < minDistance
%         minDistance = distance;
%         ID0 = i;
%     end
% end
% 
% minDistance = 100000;
% for i = 1:length(World.Nodes.X)
%     distance = sqrt((World.Nodes.X(i) - vehicle.x)^2 + (World.Nodes.Y(i) - vehicle.y)^2);
%     if distance < minDistance
%         minDistance = distance;
%         ID1 = i;
%     end
% end
% 
% minDistance = 100000;
% for i = 1:length(World.Nodes.X)
%     distance = sqrt((World.Nodes.X(i) - rearX)^2 + (World.Nodes.Y(i) - rearY)^2);
%     if distance < minDistance
%         minDistance = distance;
%         ID2 = i;
%     end
% end
% vehicle.planHorizon = [ID0 ID1 ID2 vehicle.planHorizon];



vehicle.xref = (World.Nodes.X(P(1)) + World.Nodes.X(P(2)) ) / 2;
vehicle.yref = (World.Nodes.Y(P(1)) + World.Nodes.Y(P(2)) ) / 2;



