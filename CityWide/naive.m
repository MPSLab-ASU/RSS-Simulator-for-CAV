clc;clear all;close all;
rng(4443)
simulation = struct;
simulation.stepTime = 0.05;

simulation.saimax = pi/3;
simulation.saimin = -pi/3;
simulation.vmax = 25;
simulation.vmin = 0;
simulation.amax = 7;
simulation.amin = -9;

% newVehicle(x,y,phi,v,ID)
vehicle1 = newVehicle(3,2.5,0,10,1);
vehicle2 = newVehicle(122.5,130,90,10,2);
vehicle3 = newVehicle(40,2.5,0,5,3);
vehicle4 = newVehicle(95,170,0,5,4);
vehicle5 = newVehicle(115,245,-90,6,5);

vehicles = [vehicle1 vehicle2 vehicle3 vehicle4 vehicle5];
% vehicles = [vehicle1];


% World = makeWorld();
load World
% plot(World.G, 'XData', World.Nodes.X, 'YData', World.Nodes.Y)

Now = 0;
for j = 1:length(vehicles)
    vehicles(j) = M_planning(vehicles(j), World, vehicles, simulation, Now);
end

% figure;hold on;

for i = 1:10000
    Now = i * simulation.stepTime;
    %% Planning
    for j = 1:length(vehicles)
%         vehicles(j) = M_planning(vehicles(j), World, vehicles, simulation, Now);
        vehicles(j) = N_planning(vehicles(j), World, vehicles, simulation, Now);
    end
    %% Forward Sim
    for j = 1:length(vehicles)
        vehicles(j) = vehicleStepForward(vehicles(j),simulation);
    end
    %% Plotting
    if rem(i,20)== 0 
        for j = 1:length(vehicles)
            drawVehicle(vehicles(j),World)
        end
        ax = gcf;
        ax.Position = [680 110 1047 868];
        drawWorld(World);
%         axis([50 200 100 250])
        axis([-50 250 -10 300])
        pause(0.01);
        cla;
    end
    
    
end