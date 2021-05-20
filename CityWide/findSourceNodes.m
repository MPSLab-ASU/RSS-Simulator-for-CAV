function Nodes = findSourceAndSinkNodes(G)
NodesArray = zeros(size(G.Nodes,1),2);
for i = 1:size(G.Edges.EndNodes,1)
    a = G.Edges.EndNodes(i,1);
    b = G.Edges.EndNodes(i,2);
    NodesArray(a,1)=1;
    NodesArray(b,2)=1;
end
Nodes = NodesArray;
