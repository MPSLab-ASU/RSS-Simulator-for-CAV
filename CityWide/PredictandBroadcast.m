function trajs = PredictandBroadcast(vehicle, World, simulation, Now)
Horizon = 5;
tempVehicle = vehicle;
N = Horizon/simulation.stepTime;
trajs = struct;

for i = 1:N
    tempVehicle = localPlanner(tempVehicle, World);
    tempVehicle = GlobalPlanner(tempVehicle, World);
    tempVehicle = vehicleStepForward(tempVehicle,simulation);
    trajs.x(i) = tempVehicle.x;
    trajs.y(i) = tempVehicle.y;
    trajs.v(i) = tempVehicle.v;
    trajs.ts(i) = Now + i*simulation.stepTime;
end
