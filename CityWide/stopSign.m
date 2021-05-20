function vehicle = stopSign(vehicle, World, simulation, traj, vehicles, Now)
% plot(World.G, 'XData',World.Nodes.X,'YData',World.Nodes.Y)
%% detect intersections
readyToStop = 0;
List = World.Intersection;
index = find(ismember(vehicle.planHorizon,World.Intersection));
if ~isempty(index) && isempty(vehicle.resumeTime)
    for i = 1:length(index)
        distance = getGraphDistance(traj(vehicle.ID), index);
        if distance < vehicle.v^2/abs(2*simulation.amin) + 9 && distance > 6.5
            readyToStop = 1;
            vehicle.v_r = 0;
            break
        end
    end
end


if readyToStop == 1
    if vehicle.v == 0
        vehicle.resumeTime = Now + 2;
%         Now
%         vehicle.resumeTime 
    end
end

go = 1;
if ~isempty(vehicle.resumeTime)
    if vehicle.resumeTime < Now         % if it's time to go
        for j = 1:length(vehicles)
            if vehicles(j).ID ~= vehicle.ID
                index2 = find(ismember(vehicles(j).planHorizon, World.Intersection));
                if ~isempty(index2)     % if there is a CAV waiting at the same intersection
                    idx = World.IntersectionSets(find(World.Intersection==vehicle.planHorizon(index)));
                    idx2 = World.IntersectionSets(find(World.Intersection==vehicles(j).planHorizon(index2)));
                    IDX = find(ismember(idx,idx2));
                    if ~isempty(IDX)
                        if vehicle.resumeTime > vehicles(j).resumeTime
                            go = 0;
                            vehicle.resumeTime = vehicles(j).resumeTime + 2;
                            break;
                        elseif vehicle.resumeTime == vehicles(j).resumeTime
                            if vehicle.ID > vehicles(j).ID
                                go = 0;
                                break;
                            end
                        end
                    end
                end
            end
        end
    else
        go = 0;
    end
end

if go == 1 && ~isempty(vehicle.resumeTime)
    vehicle.v_r = vehicle.v0;
    vehicle.resumeTime = [];
%     Now
%     disp(vehicle.ID)
end