function vehicle = N_planning(vehicle, World, vehicles, simulation, Now)
%% high-level planner
% find all way points from source to destination.
vehicle = GlobalPlanner(vehicle, World);

vehicle = NaiveCheckandReplan(vehicle, vehicles, simulation, Now, World);



%% local Planner
% find the next way point based on CAV position and World waypoints
vehicle = localPlanner(vehicle, World);
