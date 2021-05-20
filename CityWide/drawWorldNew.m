function drawWorldNew(World)
% hold on
% plot(World.G, 'XData',World.Nodes.X,'YData',World.Nodes.Y)

% for i = 1:size(World.G.Edges.EndNodes,1)
%     x1 = World.Nodes.X(World.G.Edges.EndNodes(i,1));
%     y1 = World.Nodes.Y(World.G.Edges.EndNodes(i,1));
%     x2 = World.Nodes.X(World.G.Edges.EndNodes(i,2));
%     y2 = World.Nodes.Y(World.G.Edges.EndNodes(i,2));
%     line([x1 x2],[y1 y2])
% end