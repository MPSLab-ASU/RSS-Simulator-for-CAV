function vehicle = GlobalPlanner(vehicle, World, SimulationWorld)
if SimulationWorld == 1
nodeIDs = [2588 2531 942 959 976 993];
elseif SimulationWorld == 2
   
        nodeIDs = 1:8008;
    
        
end
    
while vehicle.hasPlan == 0
    Destination.ID = datasample(nodeIDs,1);
    Destination.x = World.Nodes.X(Destination.ID);
    Destination.y = World.Nodes.Y(Destination.ID);
    
    minDistance = 100000;
    for i = 1:length(World.Nodes.X)
        distance = sqrt((World.Nodes.X(i) - vehicle.x)^2 + (World.Nodes.Y(i) - vehicle.y )^2);
        if distance < minDistance
            minDistance = distance;
            Source.x = World.Nodes.X(i);
            Source.y = World.Nodes.Y(i);
            Source.ID = i;
        end
    end
    
    [P, W] = shortestpath(World.G,Source.ID,Destination.ID);
    vehicle.plan = P;
    
    vehicle.W = W;
%     vehicle.planID = 1;
    
    vehicle.Destination.x = Destination.x;
    vehicle.Destination.y = Destination.y;
    vehicle.Destination.ID = Destination.ID;
    if length(P) < 200
        vehicle.hasPlan = 0;
    else
        vehicle.hasPlan = 1;
    end
end