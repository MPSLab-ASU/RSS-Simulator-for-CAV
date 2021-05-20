function [distanceIsLessThanRequired, NewDesiredVelocity] = chungWei(vehicle1, vehicle2, conflicts, vehicles, simulation, paths)

distanceIsLessThanRequired = 0;
geoBuffer = 1;
temporalBuffer = 2;
%% if the distance of the vehicle with advantage meets the condition, 
%% then the distance should be less than required ...
% trajD = trajs(conflicts.CAV.ID);
% trajA = trajs(conflicts.AdvCAV.ID);
% trajA = struct;
% trajA.x = World.Nodes.X(vehicle1.plan);
% trajA.y = World.Nodes.Y(vehicle1.plan);
% trajD = struct;
% trajD.x = World.Nodes.X(vehicle2.plan);
% trajD.y = World.Nodes.Y(vehicle2.plan);

trajA = paths(vehicle2.ID);
trajD = paths(vehicle1.ID);

dcAb = 0;
dcAe = 0;
if conflicts.AdvCavArrivalTimeID > 1
    for i = 1:conflicts.AdvCavArrivalTimeID - 1
        dcAb = dcAb + eDistance(trajA.x(i), trajA.x(i+1), trajA.y(i), trajA.y(i+1));
    end
end
if conflicts.AdvCavDepartureTimeID > 1
    for i = 1:conflicts.AdvCavDepartureTimeID - 1
        dcAe = dcAe + eDistance(trajA.x(i), trajA.x(i+1), trajA.y(i), trajA.y(i+1));
    end
end

%% Required Safe Distance Calculation
vehicleA = vehicles(conflicts.AdvCavID);
vehicleD = vehicles(conflicts.egoCavID);
NewDesiredVelocity = vehicleD.v_r;
d_stop_A = (vehicleA.v^2)/abs(2*simulation.amin);
d_stop_D = vehicleD.v * simulation.rho + 0.5 * simulation.amax * simulation.rho^2 + ...
    ((vehicleD.v+simulation.amax * simulation.rho)^2)/abs(2 * simulation.amin) + ...
    vehicleD.CarLength/2 + vehicleA.CarLength/2 + geoBuffer;


if  dcAe > d_stop_A 
%     && dcAb < d_stop_A
    distanceIsLessThanRequired = 1;
    dcDb = 0;
    if conflicts.egoCavArrivalTimeID > 1
        for i = 1:conflicts.egoCavArrivalTimeID - 1
            dcDb = dcDb + eDistance(trajD.x(i), trajD.x(i+1), trajD.y(i), trajD.y(i+1));
        end
    end
    if dcDb < d_stop_D 
%         disp('not safe!')
    end
    v_TH = (dcDb - d_stop_D)/conflicts.AdvCavArrivalTime;
    v_3s = dcDb/(conflicts.AdvCavArrivalTime + 3);    % three second rule
%     v_3s = simulation.vmax;
    DesiredVelocity = min(v_3s, v_3s);
    NewDesiredVelocity = min(DesiredVelocity, NewDesiredVelocity);
%     if vehicleD.ID == 2
%         dcAb
%     end
    if dcAb <= 6 && vehicleA.v < 1
        NewDesiredVelocity = 0;
    end
        
%     if v_SAFE < 0
%         v_SAFE = 0;
%     end
%     if NewDesiredVelocity > v_TH
%         distanceIsLessThanRequired = 1;
%         NewDesiredVelocity = v_SAFE;
        if NewDesiredVelocity < 1
            NewDesiredVelocity = 0;
        end
%     end
end
    