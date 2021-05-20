function [vehicle, allConflicts] = M_planning(vehicle, World, vehicles, simulation, Now, paths, SimulationWorld, found, Resolution)
tempWorld = World;
allConflicts = [];
tDeadlock = -1;
replan = 0;
d_max = simulation.vmax*(simulation.rho + simulation.vmax/abs(simulation.amin));

for j = 1:length(vehicles)
    %% Path conflict check
    if vehicle.ID ~= vehicles(j).ID
        if eDistance(vehicle.x, vehicles(j).x, vehicle.y, vehicles(j).y) < 100
            %% calculate conflicts
            
            [vehicle, conflicts] = conflictCalc(vehicle, vehicles(j), simulation, paths);
            
            %% Advantage determination
            if ~isempty(conflicts)
                conflicts = rightOfTheWayCalc(conflicts, Now);
                %% apply deadlock resolution if any
                if found == 1
                    for m = size(Resolution, 1)
                        if vehicle.ID == Resolution(m,1) && vehicles(j).ID == Resolution(m,2)
                            for n = 1:length(conflicts)
                                conflicts(n).hasDisadvantage = 0;
                            end
                        end
                        if vehicle.ID == Resolution(m,2) && vehicles(j).ID == Resolution(m,1)
                            for n = 1:length(conflicts)
                                conflicts(n).hasDisadvantage = 1;
                            end
                        end
                    end
                end
                allConflicts = [allConflicts conflicts];
            end
            
        end
    end
end

if vehicle.ID == 7
    %     disp('7')
end
%% conflict resolution

for k = 1:length(allConflicts)
    if allConflicts(k).hasDisadvantage == 1
        [distanceIsLessThanRequired, desiredVelocity] = checkRSSdistance(vehicle, vehicles(allConflicts(k).AdvCavID), allConflicts(k), vehicles, simulation, paths);
        if vehicle.v_r > desiredVelocity
            vehicle.v_r = desiredVelocity;
        end
        if distanceIsLessThanRequired == 1
            [vehicle, tempWorld] = WorldUpdate(vehicle, tempWorld, vehicles(allConflicts(k).AdvCavID), desiredVelocity, allConflicts(k), paths);
            %             vehicle.replanTime = allConflicts(k).AdvCavDepartureTime + Now;
            vehicle.replanTime = 1 + Now; % 1 second later
            replan = 1;
        end
    end
end

%% resume the plan

if vehicle.replanTime ~= -1
    if Now > vehicle.replanTime
        vehicle.v_r = vehicle.v0;   % resume the initial velocity
        vehicle.replanTime = -1;
    end
end

tic
%% replanning if needed
if replan == 1
    SourceID = vehicle.plan(1);
    DestinationID = vehicle.Destination.ID;
    [P, W] = shortestpath(tempWorld.G,SourceID,DestinationID);
    found = 0;
    %% register the new path
    newpath = struct;
    newpath.x = World.Nodes.X(P);
    newpath.y = World.Nodes.Y(P);
    plan = [];
    d1 = 0;
    i = 1;
    d_max = simulation.vmax*(simulation.rho + simulation.vmax/abs(simulation.amin));
    while d1 < d_max && i < length(newpath.x)
        d1 = getGraphDistance(newpath, i);
        distances(i) = d1;
        plan = P(1:i);
        i = i + 1;
    end
    newpath.x = World.Nodes.X(plan);
    newpath.y = World.Nodes.Y(plan);
    newpath.d = distances;
    paths(vehicle.ID) = newpath;
    %% check any conflict is created
    for j = 1:length(vehicles)
        if vehicle.ID ~= vehicles(j).ID
            [vehicle, conflicts] = conflictCalc(vehicle, vehicles(j), simulation, paths);
            if ~isempty(conflicts)
                for k = 1:length(conflicts)
                    found = 1;
                    break;
                end
            end
        end
        if found == 1
            break;
        end
    end
    if found == 0
        vehicle.plan = P;
        vehicle.W = W;
    end
end

%% high-level planner
% (when a CAV reaches its destination, it has to make a new plan in order to achieve continuity)
vehicle = GlobalPlanner(vehicle, tempWorld, SimulationWorld);
%% local Planner (find the next way point based on CAV position and World waypoints)
vehicle = localPlanner(vehicle, tempWorld, simulation);

