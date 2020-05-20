function vehicle = NaiveCheckandReplan(vehicle, vehicles, simulation, Now, World)
duration = 3;
vehicle.v_r = vehicle.v0;    % make sure it will resume after conflict resolution
tempWorldGraph = World;

for j = 1:length(vehicles)
    resultBoolean = 0;
    if vehicles(j).ID ~= vehicle.ID
        if eDistance(vehicle.x, vehicles(j).x, vehicle.y, vehicle(j).y < 50 