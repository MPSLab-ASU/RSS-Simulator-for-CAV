clc;
% commandStr = 'python src/extract.py map2.osm map3.json';
% [status, commandOut] = system(commandStr)
% commandStr = 'python src/Convert.py --input map3.json --log log.png --output map_out3.json';
% [status, commandOut] = system(commandStr)
clear;close all;
fileName = 'mmap_out.json';
str = fileread(fileName);
data = jsondecode(str);
G = digraph;
X = zeros(length(data.nodes),1);
Y = zeros(length(data.nodes),1);
G = addnode(G,length(data.nodes));
for i = 1:length(data.nodes)
    X(i) = data.nodes(i,1);
    Y(i) = data.nodes(i,2);
end
for i = 1:length(data.edges)
    G = addedge(G, data.edges(i,1) + 1, data.edges(i,2) + 1);
end
figure;plot(G, 'XData',X,'YData',Y)

%% added by Mohammad
World = struct;
World.G = G;
World.Nodes.X = X';
World.Nodes.Y = Y';
D = zeros(size(G.Edges,1),1);
for i = 1:size(G.Edges,1)
    s = G.Edges.EndNodes(i,1);
    t = G.Edges.EndNodes(i,2);
    D(i) = sqrt((World.Nodes.X(s) - World.Nodes.X(t))^2+(World.Nodes.Y(s) - World.Nodes.Y(t))^2);
end
V = 20 * ones(size(G.Edges,1),1);
World.Edges.d = D;
World.Edges.v = V;
World.G.Edges.Weight = World.Edges.d ./ World.Edges.v;
World.Road = [];                    % in the future we can add this for plot
World.Intersection = [];
World.id = 3;                       % for osm, id = 3
[World] = findSourceAndSinkNodes(World);
list =[];
for i = 1:size(World.G.Nodes,1)
    eid = outedges(World.G,i);
    if length(eid) > 1
        list = [list; i];
    end
end
World.Intersection = list;
for i = 1:length(list)
    B(i,1) = World.Nodes.X(list(i));
    B(i,2) = World.Nodes.Y(list(i));
end
e = evalclusters(B,'linkage', 'CalinskiHarabasz', 'Klist', [1:length(list)]);
N = e.OptimalK;
World.IntersectionSets = clusterdata(B,N);
save World3