clc;clear all;close all;
load World3;
G = World.G
X = World.Nodes.X;
Y = World.Nodes.Y;
figure;plot(G, 'XData',X,'YData',Y)
hold on
% for i = 1:size(G.Edges,1)
%     edge = G.Edges.EndNodes(i,:);
%     x1 = World.Nodes.X(edge(1));
%     y1 = World.Nodes.Y(edge(1));
%     x2 = World.Nodes.X(edge(2));
%     y2 = World.Nodes.Y(edge(2));
%     p1 = [x1;y1];
%     p2 = [x2;y2];
%     v = p2 - p1;
%     vp = 2.5*[v(2);-v(1)];
%     tp1 = p1+vp;
%     tp2 = p2+vp;
%     line([tp1(1) tp2(1)], [tp1(2) tp2(2)])
%     i
% end
node = World.Sink(1);
newNode = getConnectedNodes(node);
arrayX = [];arrayY = [];
while ~ismember(World.Source, newNode)
    arrayX = [arrayX X(newNode);
    arrayY = [arrayY Y(newNode);
end