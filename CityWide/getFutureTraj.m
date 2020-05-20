function [Cx, Cy, Ct] = getFutureTraj(vehicle, duration, simulation, t0, World)
Cx = [];
Cy = [];
Ct = [];
N = duration/simulation.stepTime;
for i = 1:N
    vehicle = GlobalPlanner(vehicle, World);
    vehicle = localPlanner(vehicle, World);
    vehicle = vehicleStepForward(vehicle, simulation);
    
    %% Calculate occupying zones
%     X = [-vehicle.CarLength/2 vehicle.CarLength/2 vehicle.CarLength/2 -vehicle.CarLength/2];
%     Y = [-vehicle.CarWidth/2 -vehicle.CarWidth/2 vehicle.CarWidth/2 vehicle.CarWidth/2];
%     th = deg2rad(vehicle.phi);
%     tx = vehicle.x;
%     ty = vehicle.y;
%     RX = X * cos(th) - Y * sin(th);
%     RY = X * sin(th) + Y * cos(th);
%     TX = RX + tx;
%     TY = RY + ty;
%     xmin = floor(min(TX));
%     ymin = floor(min(TY));
%     xmax = ceil(max(TX));
%     ymax = ceil(max(TY));
%     
%     CX = [];CY =[];
%     for i = xmin-1:xmax
%         for j = ymin-1:ymax
%             CX = [CX i+0.5];
%             CY = [CY j+0.5];
%         end
%     end
    
%     Cx = [Cx CX];
%     Cy = [Cy CY];
%     Ct = [Ct (t0 + simulation.stepTime * i) * ones(1, length(CX))];
    Cx = [Cx vehicle.x];
    Cy = [Cy vehicle.y];
    Ct = [Ct (t0 + simulation.stepTime * i)];
end