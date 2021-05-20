function [World] = findSourceAndSinkNodes(World)
G = World.G;
NodesArray = zeros(size(G.Nodes,1),2);
for i = 1:size(G.Edges.EndNodes,1)
    a = G.Edges.EndNodes(i,1);
    b = G.Edges.EndNodes(i,2);
    NodesArray(a,1)=1;
    NodesArray(b,2)=1;
end
Sink = find(NodesArray(:,1) == 0);
Source = find(NodesArray(:,2) == 0);
World.Sink = Sink;
World.Source = Source;