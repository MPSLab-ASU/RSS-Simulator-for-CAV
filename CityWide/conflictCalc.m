function [vehicle1, conflicts] = conflictCalc(vehicle1, vehicle2, simulation, paths)
distanceThreshold = 2.6;
counter = 1;
begin = 0;
conflicts = [];
d_max = simulation.vmax*(simulation.rho + simulation.vmax/abs(simulation.amin));
traj1 = paths(vehicle1.ID);
traj2 = paths(vehicle2.ID);

%% Conflict checking
isDistanceLessThanThreshold = 0;
for i = 1:length(traj1.x)
    isDistanceLessThanThreshold = 0;
    for j = 1:length(traj2.x)
        if eDistance(traj1.x(i), traj2.x(j), traj1.y(i), traj2.y(j)) < distanceThreshold
            isDistanceLessThanThreshold = 1;
            break;
        end
    end
    if begin == 0 && isDistanceLessThanThreshold == 1
        % add arrival time for ego
        begin = 1;
        conflict = struct;
        conflict.hasDisadvantage = 0;
        conflict.egoCavID = vehicle1.ID;
        conflict.AdvCavID = vehicle2.ID;
        conflict.egoCavArrivalTimeID = i;
        conflict.egoCavArrivalDistance = getGraphDistance(traj1, i);
        if vehicle1.v < 0.1
            conflict.egoCavArrivalTime = 1000;
        else
            conflict.egoCavArrivalTime = getGraphDistance(traj1, i)/vehicle1.v;
        end
    end
    if begin == 1 && (isDistanceLessThanThreshold == 0 || i == length(traj1.x))
        % add departure time for ego
        begin = 0;
        conflict.egoCavDepartureTimeID = i;
        conflict.egoCavDepartureDistance = getGraphDistance(traj1, i);
        if vehicle1.v < 0.1
            conflict.egoCavDepartureTime = 2000;
        else
            conflict.egoCavDepartureTime = getGraphDistance(traj1, i)/vehicle1.v;
        end
        conflicts = [conflicts conflict];
    end
end




for i = 1:length(conflicts)
    begin = 0;
    for j = 1:length(traj2.x)
        isDistanceLessThanThreshold = 0;
        for k = conflicts(i).egoCavArrivalTimeID:conflict.egoCavDepartureTimeID
            if eDistance(traj1.x(k), traj2.x(j), traj1.y(k), traj2.y(j)) < distanceThreshold
                isDistanceLessThanThreshold = 1;
                break;
            end
        end
        if begin == 0 && isDistanceLessThanThreshold == 1
            % add arrival time for ego
            begin = 1;
            conflicts(i).AdvCavArrivalTimeID = j;
            conflicts(i).AdvCavArrivalDistance = getGraphDistance(traj2, j);
            if vehicle2.v < 0.1
                conflicts(i).AdvCavArrivalTime = 1000;
            else
                conflicts(i).AdvCavArrivalTime = getGraphDistance(traj2, j)/vehicle2.v;
            end
        end
        if begin == 1 && (isDistanceLessThanThreshold == 0 || j == length(traj2.x))
            % add departure time for ego
            begin = 0;
            conflicts(i).AdvCavDepartureTimeID = j;
            conflicts(i).AdvCavDepartureDistance = getGraphDistance(traj2, j);
            if vehicle2.v < 0.1
                conflicts(i).AdvCavDepartureTime = 2000;
            else
                conflicts(i).AdvCavDepartureTime = getGraphDistance(traj2, j)/vehicle2.v;
            end
        end
    end
end


found = 0;
for i = 1:length(traj1.x)-1
    for j = 1:length(traj2.x)-1
        m1 = (traj1.y(i+1)-traj1.y(i))/(traj1.x(i+1)-traj1.x(i));
        m2 = (traj2.y(j+1)-traj2.y(j))/(traj2.x(j+1)-traj2.x(j));
        if ~isinf(m1) && ~isinf(m2) && m1 ~= 0 && m2 ~= 0
            b1 = traj1.y(i) - m1 * traj1.x(i);
            b2 = traj2.y(j) - m2 * traj2.x(j);
            CX = (b2 - b1)/(m1 - m2);
            CY = CX * m1 + b1;
            if CX <= max(traj1.x(i), traj1.x(i+1)) && CX >= min(traj1.x(i), traj1.x(i+1))
                if CY <= max(traj1.y(i), traj1.y(i+1)) && CY >= min(traj1.y(i), traj1.y(i+1))
                    if CX <= max(traj2.x(j), traj2.x(j+1)) && CX >= min(traj2.x(j), traj2.x(j+1))
                        if CY <= max(traj2.y(j), traj2.y(j+1)) && CY >= min(traj2.y(j), traj2.y(j+1))
%                             disp('cross')
                            found = 1;
                            conflict = struct;
                            conflict.hasDisadvantage = 0;
                            conflict.egoCavID = vehicle1.ID;
                            conflict.AdvCavID = vehicle2.ID;
                            conflict.egoCavArrivalTimeID = i;
                            conflict.egoCavArrivalDistance = getGraphDistance(traj1, i);
                            if vehicle1.v < 0.1
                                conflict.egoCavArrivalTime = 1000;
                            else
                                conflict.egoCavArrivalTime = getGraphDistance(traj1, i)/vehicle1.v;
                            end
                            conflict.egoCavDepartureTimeID = i+1;
                            conflict.egoCavDepartureDistance = getGraphDistance(traj1, i+1);
                            if vehicle1.v < 0.1
                                conflict.egoCavDepartureTime = 2000;
                            else
                                conflict.egoCavDepartureTime = getGraphDistance(traj1, i+1)/vehicle1.v;
                            end
                            conflict.AdvCavArrivalTimeID = j;
                            conflict.AdvCavArrivalDistance = getGraphDistance(traj2, j);
                            if vehicle2.v < 0.1
                                conflict.AdvCavArrivalTime = 1000;
                            else
                                conflict.AdvCavArrivalTime = getGraphDistance(traj2, j)/vehicle2.v;
                            end
                            conflict.AdvCavDepartureTimeID = j+1;
                            conflict.AdvCavDepartureDistance = getGraphDistance(traj2, j+1);
                            if vehicle2.v < 0.1
                                conflict.AdvCavDepartureTime = 2000;
                            else
                                conflict.AdvCavDepartureTime = getGraphDistance(traj2, j+1)/vehicle2.v;
                            end
                            conflicts = [conflicts conflict];
                            break;
                        end
                    end
                end
            end
        end
    end
    if found == 1
        break;
    end
end






% found = 0;
% for i = 1:length(traj1.x)-1
%     for j = 1:length(traj2.x)-1
%         m1 = (traj1.y(i+1)-traj1.y(i))/(traj1.x(i+1)-traj1.x(i));
%         m2 = (traj2.y(j+1)-traj2.y(j))/(traj2.x(j+1)-traj2.x(j));
%         if m1 ~= m2
%             if m1 == 0.8 || m1 == -0.8 || m1 == 1.25 || m1 == -1.25
%                 if m2 == 0.8 || m2 == -0.8 || m2 == 1.25 || m2 == -1.25
%                     if traj1.x(i) == traj2.x(j) || traj1.x(i) == traj2.x(j+1)
%                         if traj1.x(i+1) == traj2.x(j) || traj1.x(i+1) == traj2.x(j+1)
%
%                             found = 1;
%                             conflict = struct;
%                             conflict.hasDisadvantage = 0;
%                             conflict.egoCavID = vehicle1.ID;
%                             conflict.AdvCavID = vehicle2.ID;
%                             conflict.egoCavArrivalTimeID = i;
%                             conflict.egoCavArrivalDistance = getGraphDistance(traj1, i);
%                             if vehicle1.v < 0.1
%                                 conflict.egoCavArrivalTime = 1000;
%                             else
%                                 conflict.egoCavArrivalTime = getGraphDistance(traj1, i)/vehicle1.v;
%                             end
%                             conflict.egoCavDepartureTimeID = i+1;
%                             conflict.egoCavDepartureDistance = getGraphDistance(traj1, i+1);
%                             if vehicle1.v < 0.1
%                                 conflict.egoCavDepartureTime = 2000;
%                             else
%                                 conflict.egoCavDepartureTime = getGraphDistance(traj1, i+1)/vehicle1.v;
%                             end
%                             conflict.AdvCavArrivalTimeID = j;
%                             conflict.AdvCavArrivalDistance = getGraphDistance(traj2, j);
%                             if vehicle2.v < 0.1
%                                 conflict.AdvCavArrivalTime = 1000;
%                             else
%                                 conflict.AdvCavArrivalTime = getGraphDistance(traj2, j)/vehicle2.v;
%                             end
%                             conflict.AdvCavDepartureTimeID = j+1;
%                             conflict.AdvCavDepartureDistance = getGraphDistance(traj2, j+1);
%                             if vehicle2.v < 0.1
%                                 conflict.AdvCavDepartureTime = 2000;
%                             else
%                                 conflict.AdvCavDepartureTime = getGraphDistance(traj2, j+1)/vehicle2.v;
%                             end
%                             conflicts = [conflicts conflict];
%                             break;
%                         end
%                     end
%                 end
%             end
%         end
%     end
%     if found == 1
%         break;
%     end
% end
%
%
