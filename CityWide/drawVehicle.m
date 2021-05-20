function drawVehicle(vehicle, World, conflicts, paths)

CarLength = vehicle.CarLength;
CarWidth = vehicle.CarWidth;
PosX = vehicle.x;
PosY = vehicle.y;
phi = deg2rad(vehicle.phi);
color = vehicle.color;
recX0=[-CarLength/2 CarLength/2 CarLength/2 -CarLength/2 -CarLength/2];
recY0=[-CarWidth/2 -CarWidth/2 CarWidth/2 CarWidth/2 -CarWidth/2];
RrecX0=recX0*cos(phi)-recY0*sin(phi);
RrecY0=recX0*sin(phi)+recY0*cos(phi);
recX=RrecX0 + PosX;
recY=RrecY0 + PosY;
line(recX,recY,'Color', color, 'LineWidth' , 2);
hold on
% plot(vehicle.xref, vehicle.yref, 'O', 'Color', color );

plot(World.Nodes.X(vehicle.plan), World.Nodes.Y(vehicle.plan), '-', 'Color', color, 'LineWidth', 1 );
% plot(traj.x, traj.y, '-', 'Color', color)
% for k = 1:length(conflicts)
%     range = conflicts(k).CAV.arrivalID:conflicts(k).CAV.departureID;
%     plot(traj.x(range), traj.y(range), '-', 'Color', color, 'LineWidth', 2.5)
% end
% plot(vehicle.CX, vehicle.CY, 'o', 'Color', color);
plot([vehicle.x World.Nodes.X(vehicle.planHorizon(4:end))], [vehicle.y World.Nodes.Y(vehicle.planHorizon(4:end))], '-', 'Color', color, 'LineWidth', 3 );
for k = 1:length(conflicts)
    range = conflicts(k).egoCavArrivalTimeID:conflicts(k).egoCavDepartureTimeID;
%     plot(World.Nodes.X(vehicle.planHorizon(range)), World.Nodes.Y(vehicle.planHorizon(range)), '-', 'Color', color, 'LineWidth', 2.5)
    X = paths(vehicle.ID).x;
    Y = paths(vehicle.ID).y;
%     plot(X(range),Y(range), '-O', 'Color', color, 'LineWidth', 0.5)
end
str = sprintf("v = %2.1f - ID = %d", vehicle.v, vehicle.ID);
t = text(PosX - 5,PosY + 5,str);
t.FontSize = 12;

% plot(vehicle.xref,vehicle.yref, 'O', 'Color', color, 'LineWidth', 2.5)