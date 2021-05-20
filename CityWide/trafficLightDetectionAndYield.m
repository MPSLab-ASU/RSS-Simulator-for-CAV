function [phase, vehicle] = trafficLightDetectionAndYield(vehicle, simulation, Now, path, World)
intersectionX = simulation.intersectionX;
intersectionY = simulation.intersectionY;
Lane = -1;


% do traffic light
% phase 1, staraight and right turn NS
% phase 2, left turn NS
% phase 3, straight and right turn WE
% phase 4, left turn WE
%  60 second period, 5 s yellow 4*5 = 20
% phase 1 & 3 -> 15 s green each 15+5 = 20*2 = 40
% phase 2 & 4 -> 5 s green each 5+5 = 10*2 = 20
t0 = rem(Now, simulation.trafficLight.period);
if 0 <= t0 && t0 < 15
    % NS straight green
    phase = 1;
end
if 15 <= t0 && t0 < 20
    % NS straight yellow
    phase = 11;
end
if 20 <= t0 && t0 < 25
    % NS left turn green
    phase = 2;
end
if 25 <= t0 && t0 < 30
    % NS left turn yellow
    phase = 22;
end
if 30 <= t0 && t0 < 45
    % WE straight green
    phase = 3;
end
if 45 <= t0 && t0 < 50
    % WE straight yellow
    phase = 33;
end
if 50 <= t0 && t0 < 55
    % WE left turn green
    phase = 4;
end
if 55 <= t0 && t0 < 60
    % WE left turn yellow
    phase = 44;
end





if eDistance(vehicle.x,intersectionX, vehicle.y, intersectionY) < 50
    if vehicle.phi <= 45 && vehicle.phi >= -45
        % lane = West bound [-45, 45]
        laneStr = 'W';
        if sum(ismember(path.x, 107.5)) > 0 && (sum(ismember(path.y, 162.5)) > 0 || sum(ismember(path.y, 167.5)) > 0)
            Lane = 3;
        elseif sum(ismember(path.x, 107.5)) > 0 && sum(ismember(path.y, 172.5)) > 0 
            Lane = 4;
        end
    end
    if vehicle.phi < 135 && vehicle.phi > 45
        % lane = North bound [45, 135]
        laneStr = 'N';
        if sum(ismember(path.y, 160)) > 0 && (sum(ismember(path.x, 125)) > 0 || sum(ismember(path.x, 130)) > 0)
            Lane = 1;
        elseif sum(ismember(path.y, 160)) > 0 && sum(ismember(path.x, 120)) > 0
            Lane = 2;
        end
    end
    if vehicle.phi <= -135 || vehicle.phi >= 135
        % lane = East bound [135,180]/[-180,-135]
        laneStr = 'E';
        if sum(ismember(path.x, 132.5)) > 0 && (sum(ismember(path.y, 182.5)) > 0 || sum(ismember(path.y, 177.5)) > 0)
            Lane = 3;
        elseif sum(ismember(path.x, 132.5)) > 0 && sum(ismember(path.y, 172.5)) > 0
            Lane = 4;
        end
        
    end
    if vehicle.phi <= -45 && vehicle.phi >= -135
        % lane = South bound [-135, -45]
        laneStr = 'S';
        if sum(ismember(path.y, 185)) > 0 && (sum(ismember(path.x, 110)) > 0 || sum(ismember(path.x, 115)) > 0)
            Lane = 1;
        elseif sum(ismember(path.y, 185)) > 0 && sum(ismember(path.x, 120)) > 0
            Lane = 2;
        end
    end
    if strcmp(laneStr,'W')
        distanceToIntersection = 106.5 - vehicle.x;
    elseif strcmp(laneStr,'N')
        distanceToIntersection = 160 - vehicle.y;
    elseif strcmp(laneStr,'E')
        distanceToIntersection = vehicle.x - 132.5;
    elseif strcmp(laneStr,'S')
        distanceToIntersection = vehicle.y - 185;
    end
%     if vehicle.ID == 3
%         disp('3')
%     end
    if Lane == phase % green light
        vehicle.v_r = vehicle.v0; % go
    elseif Lane*11 == phase % yellow light
        if distanceToIntersection > 0
            d_stop = vehicle.v^2/abs(2*simulation.amin) + vehicle.CarLength + 1;
            if distanceToIntersection < d_stop - 1
                vehicle.v_r = vehicle.v0; % go
            elseif distanceToIntersection >= d_stop - 1 && distanceToIntersection < d_stop
                vehicle.v_r = 0; % no go
            end
        end
    else % red light
        if distanceToIntersection > 0
            d_stop = vehicle.v^2/abs(2*simulation.amin) + vehicle.CarLength + 1;
            if distanceToIntersection <= d_stop
                vehicle.v_r = 0; % no go
            end
        end

    end
    if Lane == -1
        vehicle.v_r = vehicle.v0; % go
    end
        
end
