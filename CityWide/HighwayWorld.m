clc;clear all;close all;
LW = 5;
StepSize = 0.1;
World = struct;
World.Road =[];
World.G=[];
World.Intersection =[];

G = digraph;

LW = 5;
N = length(World.Road)+1;
NL = 8;             % number of lanes
HL = 1000;          % Highway Length
x0 = 0;
xf = x0 + HL;
LS = length(x0:1:xf);
y0 = 0;
X = []; Y = [];lastI = 0;offset = 0;
for i = 1:NL

    World.Road(N).Lane(i).x = x0:1:xf;
    World.Road(N).Lane(i).y = y0 + (i-1)*LW + LW/2 + zeros(1,LS);
    World.Road(N).Lane(i).Barrier(1).x = x0:1:xf;
    World.Road(N).Lane(i).Barrier(1).y = y0 + (i-1)*LW + zeros(1,LS);
    World.Road(N).Lane(i).Barrier(2).x = x0:1:xf;
    World.Road(N).Lane(i).Barrier(2).y = y0 + i*LW + zeros(1,LS);
    G = addnode(G,length(World.Road(N).Lane(i).x));
    x = World.Road(N).Lane(i).x;
    y = World.Road(N).Lane(i).y;
    X = [X x];
    Y = [Y y];
    for j = lastI+1:lastI+length(World.Road(N).Lane(i).x)-1
        G = addedge(G,j,j+1);
    end
    lastI = j+1;

    if i > 1
        for j = 1+offset:offset+length(World.Road(N).Lane(i).x)-4
            G = addedge(G,j,j+4+1001);
            G = addedge(G,j+1001,j+4);
        end
        offset = offset + 1001;
    end

end
World.G = G;
World.Nodes.X = X;
World.Nodes.Y = Y;
distances = zeros(size(G.Edges,1),1);
for i = 1:size(G.Edges,1)
    s = G.Edges.EndNodes(i,1);
    t = G.Edges.EndNodes(i,2);
    distances(i) = sqrt((World.Nodes.X(s) - World.Nodes.X(t))^2+(World.Nodes.Y(s) - World.Nodes.Y(t))^2);
end
World.Edges.d = distances;
World.Edges.v = 20 * ones(size(G.Edges,1),1);
G.Edges.Weight = World.Edges.d ./ World.Edges.v;
World.G = G;







%% plot
% plot(World.G, 'XData', World.Nodes.X, 'YData', World.Nodes.Y)
drawHighway(World)
save Highway



