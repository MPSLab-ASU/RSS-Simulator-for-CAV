clc;clear; close all;
%%
recordData = 0;
scenario = 1;
naIve = 0;
videoRecording = 0;
SimulationWorld = 3;
REM = 2; % printing step time
%%
if recordData == 1
    ALLDATA = struct;
    counter = 1;
    if scenario == 1 || scenario == 11 || scenario == 2 || scenario == 33
        JJrange = 1;
    end
    if scenario == 3
        JJrange = 1:10:51;
    end
    if scenario == 4
        JJrange = 31:10:81;
    end
else
    JJrange = 1;
end

if videoRecording == 1
    JJrange = 1;
    REM = 1;
    if naIve == 0
        STR = 'Naive.avi';
    else
        STR = 'CWTM.avi';
    end
    v = VideoWriter(STR);
    open(v);
end

for jj = JJrange % for fault injection
    X = [];
    Y = [];
    PHI = [];
    V = [];
    VR = [];
    C = [];
    A = [];
    %% main control
    rng(4445)
    %% simulation variables
    simulation = struct;
    simulation.stepTime = 0.1;
    simulation.rho = 0.1;
    simulation.saimax = pi/3;
    simulation.saimin = -pi/3;
    simulation.vmax = 23;
    simulation.vmin = 0;
    simulation.amax = 5;
    simulation.amin = -8;
    simulation.trafficLight.period = 60;
    simulation.intersectionX = 120;
    simulation.intersectionY = 172.5;
    
    %% World
    %     World = makeWorld();
    
    if SimulationWorld == 1
        load WorldNEW
    elseif SimulationWorld == 2
        load Highway
    elseif SimulationWorld == 3
        load World3
    end
    
    % to create a vehicle at x,y with heading phi (degree) and velocity v, ID
    % newVehicle(x,y,phi,v,ID)
    %% Scenarios
    if SimulationWorld == 2
        scenario = 5;
    end
    if SimulationWorld == 3
        scenario = 33;
    end
    % scenario 1
    if scenario == 1
        timeRange = 1:7200;
        vehicle1 = newVehicle(10,2.5,0,11,1);
        vehicle2 = newVehicle(122.5,130,90,12,2);
        vehicle3 = newVehicle(80,7.5,0,8,3);
        vehicle4 = newVehicle(75,170,0,9,4);
        vehicle5 = newVehicle(115,245,-90,6,5);
        vehicle6 = newVehicle(127.5,110,90,7,6);
        vehicles = [vehicle1 vehicle2 vehicle3 vehicle4 vehicle5 vehicle6];
    end
    
    if scenario == 11
        timeRange = 1:3600;
        vehicle1 = newVehicle(3,7.5,0,11,1);
        vehicle2 = newVehicle(122.5,130,90,12,2);
        vehicle3 = newVehicle(40,7.5,0,8,3);
        vehicle4 = newVehicle(75,170,0,9,4);
        vehicle5 = newVehicle(115,245,-90,6,5);
        vehicle6 = newVehicle(127.5,110,90,7,6);
        vehicle11 = newVehicle(30,2.5,0,11,7);
        vehicle22 = newVehicle(122.5,100,90,12,8);
        vehicle33 = newVehicle(10,2.5,0,8,9);
        vehicle44 = newVehicle(35,170,0,9,10);
        vehicle55 = newVehicle(115,215,-90,6,11);
        vehicle66 = newVehicle(127.5,50,90,7,12);
        vehicles = [vehicle1 vehicle2 vehicle3 vehicle4 vehicle5 vehicle6 vehicle11 vehicle22 vehicle33 vehicle44 vehicle55 vehicle66];
    end
    
    % deadlock scenario
    if scenario == 2
        timeRange = 1:90;
        vehicle1 = newVehicle(142,172.5,180,10,1);
        vehicle2 = newVehicle(98,172.5,0,10,2);
        vehicle3 = newVehicle(120,151,90,10,3);
        vehicle4 = newVehicle(120,194,-90,10,4);
        vehicles = [vehicle1 vehicle2 vehicle3 vehicle4];
    end
    % two cars unsafe stop intersection scenario
    if scenario == 3
        timeRange = 1:150;
        vehicle1 = newVehicle(122.5,130,90,12,1);
        vehicle2 = newVehicle(95,170,0,9,2);
        vehicles = [vehicle1 vehicle2];
    end
    % two cars unsafe stop intersection scenario
    if scenario == 4
        timeRange = 1:150;
        vehicle1 = newVehicle(125,185,90,10,1);
        vehicle2 = newVehicle(130,185,90,11,2);
        vehicles = [vehicle1 vehicle2];
    end
    if scenario == 5 % experimental
        timeRange = 1:3600;
        rng(3)
        vehicle1 = newVehicle(2,2.5,0,10,1);
        vehicle2 = newVehicle(1,7.5,0,10.5,2);
        vehicle3 = newVehicle(10,12.5,0,11,3);
        vehicle4 = newVehicle(1,17.5,0,11,4);
        
        vehicles = [vehicle1 vehicle2 vehicle3 vehicle4];
    end
    % from OSM
    if scenario == 33
        timeRange = 1:1000;
        vehicles = [];
        NumVehicles = 3;
        assert(NumVehicles < length(World.Source))
    
%         nodeID = World.Source(1);
%         id = 1; xsrc = World.Nodes.X(nodeID); ysrc = World.Nodes.Y(nodeID);
%         destNodeID = World.G.Edges.EndNodes(find(World.G.Edges.EndNodes(:,1) == nodeID),2); % find the connected node to the source node
%         xdest = World.Nodes.X(destNodeID); ydest = World.Nodes.Y(destNodeID);
%         direction = rad2deg(atan2(ydest-ysrc,xdest-xsrc));
%         vrand = randi(6)+9;         % between 10 and 15
%         vehicle1 = newVehicle(xsrc,ysrc,direction,vrand,id);
        
        
 
        
%         nodeID = World.Source(2);
%         id = 2; xsrc = World.Nodes.X(nodeID); ysrc = World.Nodes.Y(nodeID);
%         destNodeID = World.G.Edges.EndNodes(find(World.G.Edges.EndNodes(:,1) == nodeID),2); % find a connected node
%         xdest = World.Nodes.X(destNodeID); ydest = World.Nodes.Y(destNodeID);
%         direction = rad2deg(atan2(ydest-ysrc,xdest-xsrc));
%         vrand = randi(6)+9;         % between 10 and 15
%         vehicle2 = newVehicle(xsrc,ysrc,direction,vrand,id);
%         vehicles = [vehicle1;vehicle2];
    end
    
    
    
    
    
    % to see world map
    % plot(World.G, 'XData', World.Nodes.X, 'YData', World.Nodes.Y)
    
    Now = 0;
    for j = 1:length(vehicles)
        vehicles(j) = GlobalPlanner(vehicles(j), World, SimulationWorld);
        vehicles(j) = localPlanner(vehicles(j), World, simulation);
    end
    id = 0;
    % figure;hold on;
    resolutions = [];
    tDeadlock = -1;
    t1 = 0;t2 = 0;t3 = 0;t4 = 0;
    IsConflictRecorded = 0;
    pathsB = [];
    pathsBB = [];
    found = 0;
    Resolution = [];
    deadlockSearchTimestamp = -1;
    
    for i = timeRange
        tic;
        Now = (i-1) * simulation.stepTime;
        %% fault injection
        if scenario == 3 || scenario == 4
            if i > jj
                vehicles(2).v_r = 0;
            end
        end
        %% Vehicle generation and removal
        if SimulationWorld == 3
        for j = 1:length(vehicles)
            if length(vehicles(j).plan) < 10
                vehicles(j)=[]; % removes one by one
                index = j;
                break;
            end
        end
        
        if length(vehicles) < NumVehicles
            nodeID = World.Source(rem(id+1,NumVehicles)+1);
            IDLIST = [];
            for j = 1:length(vehicles)
                IDLIST = [IDLIST vehicles(j).ID];
            end
            ALLIDs = 1:NumVehicles;
            commonIDs = intersect(ALLIDs,IDLIST);
            IDLIST = setxor(ALLIDs,commonIDs);
            id = IDLIST(1); xsrc = World.Nodes.X(nodeID); ysrc = World.Nodes.Y(nodeID);
            destNodeID = World.G.Edges.EndNodes(find(World.G.Edges.EndNodes(:,1) == nodeID),2); % find the connected node to the source node
            xdest = World.Nodes.X(destNodeID); ydest = World.Nodes.Y(destNodeID);
            direction = rad2deg(atan2(ydest-ysrc,xdest-xsrc));
            vrand = randi(6)+9;         % between 10 and 15
            vehicle = newVehicle(xsrc,ysrc,direction,vrand,id);
            vehicle = GlobalPlanner(vehicle, World, SimulationWorld);
            vehicle = localPlanner(vehicle, World, simulation);
%             if length(vehicles) < 6
            if vehicle.ID == 1
                vehicles = [vehicle vehicles];
            elseif vehicle.ID == NumVehicles
                vehicles = [vehicles vehicle];
            else
                vehicles = [vehicles(1:vehicle.ID-1) vehicle vehicles(vehicle.ID:end)];
            end
%             elseif length(vehicles) == 6
%                 vehicles(index) = vehicle;
%             end
            
        end
        end
        %% predict and broadcast
        for j = 1:length(vehicles)
            %         trajs(j) = PredictandBroadcast(vehicles(j), World, simulation, Now);
            [vehicles(j), paths(j)] = broadcastFuturePath(vehicles(j), World, simulation, jj);
%             pathsBBB = pathsBB;
%             pathsBB = pathsB;
%             pathsB = paths;
        end
        %% traffic light
        if naIve == 1
            for j = 1:length(vehicles)
                
                
                
%                 [phase, vehicles(j)] = trafficLightDetectionAndYield(vehicles(j), simulation, Now, paths(j),World);
            end
        end
        %% Planning
        if naIve == 1
            for j = 1:length(vehicles)
                vehicles(j).v_r = vehicles(j).v0;
                % simple planning (obstacle avoidance)
                vehicles(j) = GlobalPlanner(vehicles(j), World, SimulationWorld);
                %% local Planner (find the next way point based on CAV position and World waypoints)
                vehicles(j) = localPlanner(vehicles(j), World, simulation);
                %% ACC
                vehicle1 = vehicles(j);
                path1 = paths(j);
                for k  = 1:length(vehicles)
                    vehicle2 = vehicles(k);
                    path2 = paths(k);
                    %                     if j == 1 && k == 3
                    %                         disp('13')
                    %                     end
                    if vehicle1.ID ~= vehicle2.ID
                        if sum(ismember(path1.x, path2.x(4))) > 0 && sum(ismember(path1.y, path2.y(4))) > 0
                            remainingDistance = eDistance(path1.x(1),path2.x(1), path1.y(1), path2.y(1));
                            d_stop = vehicle1.v^2/abs(2*simulation.amin) + 2*vehicle1.CarLength ;
                            %                             d_stop = 30;
                            if remainingDistance <= d_stop
                                vehicles(j).v_r = 0;
                                break;
                            end
                            if remainingDistance <= d_stop + 5
                                vehicles(j).v_r = vehicle2.v;
                                break;
                            end
                        end
                    end
                end
                if vehicles(j).v_r > vehicles(j).v0
                    vehicles(j).v_r = vehicles(j).v0;
                end
                vehicles(j) = stopSign(vehicles(j), World, simulation, paths, vehicles, Now);
            end
        end
        if naIve == 0
            if Now >= 0.1
                for j = 1:length(vehicles)
                    [vehicles(j), allConflicts{j}] = M_planning(vehicles(j), World, vehicles, simulation, Now, paths, SimulationWorld, found, Resolution);
                end
                %                 vv1 = allConflicts{1}.hasDisadvantage
                %                 vv4 = allConflicts{4}.hasDisadvantage
            end
        end
        
        %% Deadlock detection
        %     for j = 1:length(vehicles)
        if Now >= 0.1
            if naIve == 0
                if deadlockSearchTimestamp == -1
                    [found, Resolution] = deadlockRemoval(allConflicts);
                    if found == 1
                        deadlockSearchTimestamp = Now;
                    end
                else
                    if Now > deadlockSearchTimestamp + 3
                        found = 0;
                        Resolution = [];
                    end
                end
            end
        end
        
        %     end
        %% data logging
        if Now >= 0.1
            for j = 1:length(vehicles)
                X(i,j) = vehicles(j).x;
                Y(i,j) = vehicles(j).y;
                PHI(i,j) = deg2rad(vehicles(j).phi);
                V(i,j) = vehicles(j).v;
                A(i,j) = vehicles(j).a;
                VR(i,j) = vehicles(j).v_r;
                if naIve == 0
                    if ~isempty(allConflicts) && IsConflictRecorded == 0
                        C = allConflicts;
                        IsConflictRecorded = 1;
                    end
                end
            end
        end
        %% Simualte vehicle dynamics for the next step
        for j = 1:length(vehicles)
            vehicles(j) = vehicleStepForward(vehicles(j),simulation);
        end
        %% Plotting
        %     tic
        if rem(i,REM)== 0
            for j = 1:length(vehicles)
                if naIve == 1
                    allConflicts{j} = [];
                end
                if Now >= 0.1
                    drawVehicle(vehicles(j),World, allConflicts{j}, paths)
                    if naIve == 1
%                         drawLight(phase);
                    end
                end
            end
            %         if deadlock == 1
            %             text(200,50, 'Deadlock occurred!')
            %         else
            %             text(200,50, 'No deadlock')
            %         end
            ax = gcf;
            %             ax.Position = [680 110 1047 868];
            ax.Position = [202.6000 66.6000 734.4000 613.2000];
            if SimulationWorld == 1
                drawWorld(World);
                axis([-50 250 -10 300])
            elseif SimulationWorld == 2
                drawHighway(World, vehicles)
            elseif SimulationWorld == 3
                drawWorldNew(World);
%                 axis([-200 1800 -200 1800])
%                 axis([620 720 1140 1210])
%                 axis([1190 1280 30 100])
            end
            str = sprintf("time = %3.1f",Now);
%             text(630,1150, str)
%             text(1200,40, str)
            pause(0.00001);
            if videoRecording == 1
                frame = getframe(gcf);
                writeVideo(v,frame);
            end
            cla;
        end
        ExecutionTime(i) = toc;
        %     t4 = t4 + toc;
    end
    avgV(JJrange) = mean(mean(V));
    if recordData == 1
        ALLDATA.X{counter} = X;
        ALLDATA.Y{counter} = Y;
        ALLDATA.PHI{counter} = PHI;
        ALLDATA.V{counter} = V;
        ALLDATA.A{counter} = A;
        ALLDATA.VR{counter} = VR;
        ALLDATA.C{counter} = C;
        counter = counter + 1;
    end
    
end

if videoRecording == 1
    close(v);
end