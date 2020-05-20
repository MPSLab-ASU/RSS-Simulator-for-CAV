function vehicle = RSSCheckandReplan(vehicle, vehicles, simulation, Now, World)
duration = 5;
vehicle.v_r = vehicle.v0;    % make sure it will resume after conflict resolution
tempWorldGraph = World;

for j = 1:length(vehicles)
    resultBoolean = 0;
    if vehicles(j).ID ~= vehicle.ID
        if sqrt((vehicles(j).x - vehicle.x)^2 + (vehicles(j).y - vehicle.y)^2) < 50    % within 50 meters
            %% path calc
            plan1 = vehicle.plan;
            plan2 = vehicles(j).plan;
            if ~isempty(plan1) && ~isempty(plan2)
                travelDistance1 = vehicle.v * duration;
                travelDistance2 = vehicles(j).v * duration;
                p1 = getPoints(travelDistance1, plan1, World);
                p2 = getPoints(travelDistance2, plan2, World);
                
                for k = 1:length(p1)
                    for l = 1:length(p2)
                        if eDistance(World.Nodes.X(p1(k)), World.Nodes.X(p2(l)), World.Nodes.Y(p1(k)), World.Nodes.Y(p2(l))) < 1
                            Conflict.x = World.Nodes.X(p1(k));
                            Conflict.y = World.Nodes.Y(p1(k));   % should be the most-critical conflict
                            d1 = 0;edges1 = [];
                            for m = 1:k-1
%                                 edges1 = [edges1 findedge(World.G, p1(m), p1(m+1))];
                                d1 = d1 + World.Edges.d(findedge(World.G, p1(m), p1(m+1)));
                            end
                            d2 = 0;edges2 = [];
%                             if Now >= 3.4
%                     disp('debug')
%                 end
                            for m = 1:l-1
%                                 edges2 = [edges2 findedge(World.G, p2(m), p2(m+1))];
                                d2 = d2 + World.Edges.d(findedge(World.G, p2(m), p2(m+1)));
                            end
                            reachTime1 = d1/vehicle.v;
                            reachTime2 = d2/vehicles(j).v;
                            Conflict.dt = reachTime1;
                            resultBoolean = 1;
                            break;
                        end
                    end
                    if resultBoolean == 1
                        break;
                    end
                end
            end
            %% simulate the traj
            %             t0 = Now;
            %             [C_EgoX, C_EgoY, C_EgoT] = getFutureTraj(vehicle, 5, simulation, t0, World);
            %             [C_AdvX, C_AdvY, C_AdvT] = getFutureTraj(vehicles(j), 5, simulation, t0, World);
            %             vehicle.CX = C_EgoX;
            %             vehicle.CY = C_EgoY;
            %             vehicle.CT = C_EgoT;
            %             for k = 1:length(C_EgoX)
            %                 for l = 1:length(C_AdvX)
            %                     if sqrt((C_EgoX(k)-C_AdvX(l))^2 + (C_EgoY(k)-C_AdvY(l))^2) < 1
            %                         if abs(C_EgoT(k) - C_AdvT(l)) < 2
            %                             resultBoolean = 1;
            %                             Conflict = struct;
            %                             Conflict.x = C_EgoX(k);
            %                             Conflict.y = C_EgoY(k);
            %                             Conflict.t = C_EgoT(k);
            %                             break;
            %                         end
            %                     end
            %                 end
            %                 if resultBoolean == 1
            %                     break;
            %                 end
            %             end
            %% calc intersection
            %             [x,y] = futureTrajIntersection(vehicle,vehicles(j));
            %             if ~isempty(x) && ~isempty(y)
            %                 Conflict.x = x;
            %                 Conflict.y = y;
            %             end
            if resultBoolean == 1
                %% DEFINE ADVANTAGE
                distanceEgo = sqrt((Conflict.x - vehicle.x)^2 + (Conflict.y - vehicle.y)^2);
                distanceAdv = sqrt((Conflict.x - vehicles(j).x)^2 + (Conflict.y - vehicles(j).y)^2);
                if distanceEgo > distanceAdv

                    v_r = distanceEgo/( distanceAdv/vehicles(j).v + 5.3/vehicles(j).v + 3);
                    if v_r < vehicle.v_r
                        vehicle.v_r = v_r;
                    end
%                     plot(Conflict.x, Conflict.y, 'O')
                %% replan
                    if length(vehicle.plan) > 1
                        if vehicles(j).v == 0
                            vehicles(j).v = 0.01;
                        end
                        edges2 = [];
                        for m = 1:length(p2)-1
                            edges2 = [edges2 findedge(World.G, p2(m), p2(m+1))];
                        end
                        connectedEdges2 = [];
                        for m = 1:length(p2)
                            connectedEdges2 = [connectedEdges2 inedges(World.G, p2(m))'];
                        end
                        if ~isempty(edges2) && vehicles(j).v ~= 0
                            tempWorldGraph.G.Edges.Weight(edges2) = tempWorldGraph.Edges.d(edges2) / vehicles(j).v;
                            tempWorldGraph.G.Edges.Weight(connectedEdges2) = tempWorldGraph.Edges.d(connectedEdges2) / vehicles(j).v;
                        end
                        P = shortestpath(tempWorldGraph.G, vehicle.plan(1), vehicle.Destination.ID);
%                         hold on
%                         plot(World.Nodes.X(vehicle.plan),World.Nodes.Y(vehicle.plan), 'o')
%                         plot(World.Nodes.X(P),World.Nodes.Y(P), '*')
%                         plot(tempWorldGraph.G, 'EdgeLabel',tempWorldGraph.G.Edges.Weight, 'XData', tempWorldGraph.Nodes.X, 'YData', tempWorldGraph.Nodes.Y)
                        vehicle.plan = P;
                    end
                end
            end
        else
            vehicle.CX = [];
            vehicle.CY = [];
            vehicle.CT = [];
        end
    end
end