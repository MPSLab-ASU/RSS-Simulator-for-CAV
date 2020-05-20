function [vehicleD, tempWorld] = WorldUpdate(vehicleD, tempWorld, vehicleA, v_SAFE, conflict, paths)
p2 = vehicleA.planHorizon;
edges2 = [];
for m = 4:length(p2)-1 % 4 beacuse 3 points are added for the CAV itself
    edges2 = [edges2 findedge(tempWorld.G, p2(m), p2(m+1))];
end
connectedEdges2 = [];
for m = 1:length(p2) 
    connectedEdges2 = [connectedEdges2 inedges(tempWorld.G, p2(m))'];
end
if conflict.egoCavDepartureTimeID > length(vehicleD.planHorizon)
    conflict.egoCavDepartureTimeID = length(vehicleD.planHorizon);
end
p1 = vehicleD.planHorizon(conflict.egoCavArrivalTimeID:conflict.egoCavDepartureTimeID);
edges1 = [];
for m = 4:length(p1)-1 % 4 beacuse 3 points are added for the CAV itself
    edges1 = [edges1 findedge(tempWorld.G, p1(m), p1(m+1))];
end
connectedEdges1 = [];
for m = 1:length(p1)
    connectedEdges1 = [connectedEdges1 inedges(tempWorld.G, p1(m))'];
end

if ~isempty(edges2)
    if v_SAFE == 0
        v_SAFE = 0.00001;
    end
    tempWorld.G.Edges.Weight(edges2) = max(tempWorld.Edges.d(edges2) / v_SAFE, tempWorld.G.Edges.Weight(edges2));
    tempWorld.G.Edges.Weight(connectedEdges2) = max(tempWorld.Edges.d(connectedEdges2) / v_SAFE, tempWorld.G.Edges.Weight(connectedEdges2));
end
if ~isempty(edges1)
    if v_SAFE == 0
        v_SAFE = 0.00001;
    end
    tempWorld.G.Edges.Weight(edges1) = max(tempWorld.Edges.d(edges1) / v_SAFE, tempWorld.G.Edges.Weight(edges1));
    tempWorld.G.Edges.Weight(connectedEdges1) = max(tempWorld.Edges.d(connectedEdges1) / v_SAFE, tempWorld.G.Edges.Weight(connectedEdges1));
end
