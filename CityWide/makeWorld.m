% clc;clear all;close all;
% World =  digraph([1 1 2],[2 3 1]);
% World = addedge(World,2,3);
% World = addnode(World,1);
% World.Nodes.Name = {'A' 'B' 'C' 'D'}';
% plot(World,'Layout','force');
% 
% P = shortestpath(World,1,4)
function World = makeWorld()
LW = 5;
StepSize = 0.1;
World = struct;
World.Road =[];
World.G=[];
World.Intersection =[];

G = digraph;
%% Roads
start = 1;
World = addHorizontalTwo(World,1,99,0,20);
G = addnode(G,length(World.Road(end).Lane(1).x));
X = World.Road(end).Lane(1).x;
Y = World.Road(end).Lane(1).y;
for i = 1:length(World.Road.Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
offset = lastI;
X = [X World.Road(end).Lane(2).x];
Y = [Y World.Road(end).Lane(2).y];
G = addnode(G,length(World.Road(end).Lane(2).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(2).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
%
for i=start:start+length(World.Road.Lane(1).x)-2
    G = addedge(G,i,i+1+offset);
    G = addedge(G,i+offset,i+1);
end


start = size(G.Nodes,1);
Range = 3*pi/2:StepSize:2*pi+StepSize;
World = addCurveTwo(World,100,130,0,30,Range);
G = addnode(G,length(World.Road(end).Lane(1).x)); % inside cureve
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];

for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;

G = addnode(G,length(World.Road(end).Lane(2).x)); % inside cureve
X = [X World.Road(end).Lane(2).x];
Y = [Y World.Road(end).Lane(2).y];
for i = lastI+1:lastI+length(World.Road(end).Lane(2).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4
    G = addedge(G,i,i+4+offset);
    G = addedge(G,i+offset,i+4);
end


start = size(G.Nodes,1);
G = addnode(G,length(World.Road(end-1).Lane(1).x)); % outside cureve
X = [X World.Road(end-1).Lane(1).x];
Y = [Y World.Road(end-1).Lane(1).y];
for i = lastI+1:lastI+length(World.Road(end-1).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
G = addnode(G,length(World.Road(end-1).Lane(2).x)); % outside cureve
X = [X World.Road(end-1).Lane(2).x];
Y = [Y World.Road(end-1).Lane(2).y];
for i = lastI+1:lastI+length(World.Road(end-1).Lane(2).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;

final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4
    G = addedge(G,i+4,i+offset);
    G = addedge(G,i+offset+4,i);
end

%
G = addedge(G,99,199);G = addedge(G,198,216);
%

start = size(G.Nodes,1);
World = addHorizontalTwo(World,1,99,10,30);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
X = [X World.Road(end).Lane(2).x];
Y = [Y World.Road(end).Lane(2).y];
G = addnode(G,length(World.Road(end).Lane(2).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(2).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4
    G = addedge(G,i+4,i+offset);
    G = addedge(G,i+offset+4,i);
end

%
G = addedge(G,250,464);G = addedge(G,233,365);
%




start = size(G.Nodes,1);
World = addVerticalTwo(World,110,130,31,149);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
X = [X World.Road(end).Lane(2).x];
Y = [Y World.Road(end).Lane(2).y];
G = addnode(G,length(World.Road(end).Lane(2).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(2).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4
    G = addedge(G,i+4,i+offset);
    G = addedge(G,i+offset+4,i);
end
%
G = addedge(G,465,266);G = addedge(G,584,249);
%



start = size(G.Nodes,1);
World = addVerticalTwo(World,120,140,31,149);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
X = [X World.Road(end).Lane(2).x];
Y = [Y World.Road(end).Lane(2).y];
G = addnode(G,length(World.Road(end).Lane(2).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(2).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4 - 10 % 10 for lane change avoidnace before intersection
    G = addedge(G,i,i+offset+4);
    G = addedge(G,i+offset,i+4);
end
%
G = addedge(G,232,703);G = addedge(G,215,822);
%




start = size(G.Nodes,1);
Range = pi:StepSize:3*pi/2+StepSize;
World = addCurveTwo(World,0,30,0,30,Range);
G = addnode(G,length(World.Road(end).Lane(1).x)); % inside cureve
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
G = addnode(G,length(World.Road(end).Lane(2).x)); % inside cureve
X = [X World.Road(end).Lane(2).x];
Y = [Y World.Road(end).Lane(2).y];
for i = lastI+1:lastI+length(World.Road(end).Lane(2).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4
    G = addedge(G,i,i+offset+4);
    G = addedge(G,i+offset,i+4);
end

start = size(G.Nodes,1);
G = addnode(G,length(World.Road(end-1).Lane(1).x)); % outside cureve
X = [X World.Road(end-1).Lane(1).x];
Y = [Y World.Road(end-1).Lane(1).y];
for i = lastI+1:lastI+length(World.Road(end-1).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
G = addnode(G,length(World.Road(end-1).Lane(2).x)); % outside cureve
X = [X World.Road(end-1).Lane(2).x];
Y = [Y World.Road(end-1).Lane(2).y];
for i = lastI+1:lastI+length(World.Road(end-1).Lane(2).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4
    G = addedge(G,i+4,i+offset);
    G = addedge(G,i+offset+4,i);
end
%
G = addedge(G,366,1008);G = addedge(G,267,991);
%
%
G = addedge(G,957,1);G = addedge(G,974,100);
%

start = size(G.Nodes,1);
World = addVerticalTwo(World,-30,-10,31,149+LW/2);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
X = [X World.Road(end).Lane(2).x];
Y = [Y World.Road(end).Lane(2).y];
G = addnode(G,length(World.Road(end).Lane(2).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(2).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4
    G = addedge(G,i+4,i+offset);
    G = addedge(G,i+offset+4,i);
end
%
G = addedge(G,1009,941);G = addedge(G,1130,958);
%

start = size(G.Nodes,1);
World = addVerticalTwo(World,-20,0,31,149+LW/2);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
X = [X World.Road(end).Lane(2).x];
Y = [Y World.Road(end).Lane(2).y];
G = addnode(G,length(World.Road(end).Lane(2).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(2).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4
    G = addedge(G,i,i+offset+4);
    G = addedge(G,i+offset,i+4);
end
%
G = addedge(G,992,1372);G = addedge(G,975,1251);
%

start = size(G.Nodes,1);
Range = pi/2:StepSize:pi+StepSize;
World = addCurveTwo(World,0,30,120+LW/2,150+LW/2,Range);
G = addnode(G,length(World.Road(end).Lane(1).x)); % inside cureve
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
G = addnode(G,length(World.Road(end).Lane(2).x)); % inside cureve
X = [X World.Road(end).Lane(2).x];
Y = [Y World.Road(end).Lane(2).y];
for i = lastI+1:lastI+length(World.Road(end).Lane(2).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4
    G = addedge(G,i,i+offset+4);
    G = addedge(G,i+offset,i+4);
end

start = size(G.Nodes,1);
G = addnode(G,length(World.Road(end-1).Lane(1).x)); % outside cureve
X = [X World.Road(end-1).Lane(1).x];
Y = [Y World.Road(end-1).Lane(1).y];
for i = lastI+1:lastI+length(World.Road(end-1).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
G = addnode(G,length(World.Road(end-1).Lane(2).x)); % outside cureve
X = [X World.Road(end-1).Lane(2).x];
Y = [Y World.Road(end-1).Lane(2).y];
for i = lastI+1:lastI+length(World.Road(end-1).Lane(2).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4
    G = addedge(G,i+4,i+offset);
    G = addedge(G,i+offset+4,i);
end
%
G = addedge(G,1509,1129);G = addedge(G,1526,1250);
%
%
G = addedge(G,1371,1543);G = addedge(G,1492,1560);
%



start = size(G.Nodes,1);
World = addHorizontalTwo(World,1,96,160+LW/2,180+LW/2);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
X = [X World.Road(end).Lane(2).x];
Y = [Y World.Road(end).Lane(2).y];
G = addnode(G,length(World.Road(end).Lane(2).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(2).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4 - 10 % for lane change avoidance before intersection
    G = addedge(G,i,i+offset+4);
    G = addedge(G,i+offset,i+4);
end
%
G = addedge(G,1544,1561);G = addedge(G,1527,1657);
%


start = size(G.Nodes,1);
World = addHorizontalTwo(World,1,96,170+LW/2,190+LW/2);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
X = [X World.Road(end).Lane(2).x];
Y = [Y World.Road(end).Lane(2).y];
G = addnode(G,length(World.Road(end).Lane(2).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(2).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4
    G = addedge(G,i+4,i+offset);
    G = addedge(G,i+offset+4,i);
end
%
G = addedge(G,1753,1510);G = addedge(G,1849,1493);
%

start = size(G.Nodes,1);
World = addHorizontalTwo(World,144,170,160+LW/2,180+LW/2);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
X = [X World.Road(end).Lane(2).x];
Y = [Y World.Road(end).Lane(2).y];
G = addnode(G,length(World.Road(end).Lane(2).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(2).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4
    G = addedge(G,i,i+offset+4);
    G = addedge(G,i+offset,i+4);
end

start = size(G.Nodes,1);
World = addHorizontalTwo(World,144,170,170+LW/2,190+LW/2);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
X = [X World.Road(end).Lane(2).x];
Y = [Y World.Road(end).Lane(2).y];
G = addnode(G,length(World.Road(end).Lane(2).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(2).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4
    G = addedge(G,i+4,i+offset);
    G = addedge(G,i+offset+4,i);
end

World = addHorizontalOne(World,171,199,165,175);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;

World = addHorizontalOne(World,171,199,175,185);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;

%
G = addedge(G,1971,2053);G = addedge(G,1998,2053);
%
%
G = addedge(G,2082,2052);G = addedge(G,2082,2025);
%

start = size(G.Nodes,1);
World = addVerticalTwo(World,110,130,196,220);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
X = [X World.Road(end).Lane(2).x];
Y = [Y World.Road(end).Lane(2).y];
G = addnode(G,length(World.Road(end).Lane(2).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(2).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4
    G = addedge(G,i+4,i+offset);
    G = addedge(G,i+offset+4,i);
end

start = size(G.Nodes,1);
World = addVerticalTwo(World,120,140,196,220);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
X = [X World.Road(end).Lane(2).x];
Y = [Y World.Road(end).Lane(2).y];
G = addnode(G,length(World.Road(end).Lane(2).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(2).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
%
final = size(G.Nodes,1);
offset = (final - start)/2;
for i=start+1:start+length(World.Road(end).Lane(1).x)-4
    G = addedge(G,i,i+offset+4);
    G = addedge(G,i+offset,i+4);
end

World = addVerticalOne(World,122.5,132.5,221,249);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;

World = addVerticalOne(World,112.5,122.5,221,249);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;

%
G = addedge(G,2185,2211);G = addedge(G,2210,2211);
%
%
G = addedge(G,2240,2135);G = addedge(G,2240,2160);
%

Range = 3*pi/2:StepSize:2*pi+StepSize;
World = addCurveOne(World,200,230,165,195,Range);
G = addnode(G,length(World.Road(end).Lane(1).x)); % inside cureve
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
G = addnode(G,length(World.Road(end-1).Lane(1).x)); % outside cureve
X = [X World.Road(end-1).Lane(1).x];
Y = [Y World.Road(end-1).Lane(1).y];
for i = lastI+1:lastI+length(World.Road(end-1).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;

%
G = addedge(G,2081,2269);G = addedge(G,2286,2110);
%

World = addVerticalOne(World,215,225,196,249);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;

World = addVerticalOne(World,225,235,196,249);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;

%
G = addedge(G,2285,2357);G = addedge(G,2303,2302);
%

Range = 0:StepSize:pi/2+StepSize;
World = addCurveOne(World,200,230,220,250,Range);
G = addnode(G,length(World.Road(end).Lane(1).x)); % inside cureve
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
G = addnode(G,length(World.Road(end-1).Lane(1).x)); % outside cureve
X = [X World.Road(end-1).Lane(1).x];
Y = [Y World.Road(end-1).Lane(1).y];
for i = lastI+1:lastI+length(World.Road(end-1).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;

%
G = addedge(G,2428,2356);G = addedge(G,2410,2411);
%

Range = pi/2:StepSize:pi+StepSize;
World = addCurveOne(World,142.5,172.5,220,250,Range);
G = addnode(G,length(World.Road(end).Lane(1).x)); % inside cureve
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
G = addnode(G,length(World.Road(end-1).Lane(1).x)); % outside cureve
X = [X World.Road(end-1).Lane(1).x];
Y = [Y World.Road(end-1).Lane(1).y];
for i = lastI+1:lastI+length(World.Road(end-1).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;

%
G = addedge(G,2461,2268);G = addedge(G,2239,2478);
%

World = addHorizontalOne(World,143,199,265,275);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;

World = addHorizontalOne(World,143,199,275,285);
X = [X World.Road(end).Lane(1).x];
Y = [Y World.Road(end).Lane(1).y];
G = addnode(G,length(World.Road(end).Lane(1).x));
for i = lastI+1:lastI+length(World.Road(end).Lane(1).x)-1
    G = addedge(G,i+1,i);
end
lastI = i+1;

%
G = addedge(G,2462,2479);G = addedge(G,2536,2445);
%
%
G = addedge(G,2427,2592);G = addedge(G,2535,2444);
%

%% Intersection

Range = 0:StepSize:pi/2 + StepSize;
World.Intersection(1).SN.Lane(1).x = 130 - LW/2 + LW/2 + zeros(1,45);
World.Intersection(1).SN.Lane(1).y = 151:1:195;
World.Intersection(1).SN.Lane(2).x = 130 - 3*LW/2 + LW/2 + zeros(1,45);
World.Intersection(1).SN.Lane(2).y = 151:1:195;
World.Intersection(1).SW.Lane(1).x = [130 - 5*LW/2 + LW/2 + zeros(1,9) 120 - 5*LW/2 + 5*LW/2 * cos(Range) 120-5*LW/2-1+0.5:-1:97.5+0.5];
World.Intersection(1).SW.Lane(1).y = [151:1:159 160 + 7*LW/2 * sin(Range) 177.5000+zeros(1,10)];
World.Intersection(1).SN.Barrier(1).x = [130 + LW/2 + zeros(1,9)];
World.Intersection(1).SN.Barrier(1).y = [152:160];
World.Intersection(1).SN.Barrier(2).x = [130 - LW/2 + zeros(1,9)];
World.Intersection(1).SN.Barrier(2).y = [152:160];
World.Intersection(1).SN.Barrier(3).x = [130 - 3*LW/2 + zeros(1,9)];
World.Intersection(1).SN.Barrier(3).y = [152:160];
World.Intersection(1).SN.Barrier(4).x = [130 - 5*LW/2 + zeros(1,9)];
World.Intersection(1).SN.Barrier(4).y = [152:160];
World.Intersection(1).SN.Barrier(5).x = [130 - 7*LW/2 + zeros(1,9)];
World.Intersection(1).SN.Barrier(5).y = [152:160];
World.Intersection(1).SN.Barrier(6).x = [130 - 9*LW/2 + zeros(1,9)];
World.Intersection(1).SN.Barrier(6).y = [152:160];

X = [X World.Intersection(1).SN.Lane(1).x];
Y = [Y World.Intersection(1).SN.Lane(1).y];
G = addnode(G,length(World.Intersection(1).SN.Lane(1).x));
for i = lastI+1:lastI+length(World.Intersection(1).SN.Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
X = [X World.Intersection(1).SN.Lane(2).x];
Y = [Y World.Intersection(1).SN.Lane(2).y];
G = addnode(G,length(World.Intersection(1).SN.Lane(2).x));
for i = lastI+1:lastI+length(World.Intersection(1).SN.Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
X = [X World.Intersection(1).SW.Lane(1).x];
Y = [Y World.Intersection(1).SW.Lane(1).y];
G = addnode(G,length(World.Intersection(1).SW.Lane(1).x));
for i = lastI+1:lastI+length(World.Intersection(1).SW.Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;

%
G = addedge(G,821,2683);G = addedge(G,821,2638);
%
%
G = addedge(G,940,2638);G = addedge(G,940,2593);
%
%
G = addedge(G,2718,1848);G = addedge(G,2718,1944);
%
%
G = addedge(G,2682,2161);G = addedge(G,2682,2186);
%
%
G = addedge(G,2637,2186);
%


Range = pi:StepSize:3*pi/2 + StepSize;
World.Intersection(1).NS.Lane(1).x = 130 - 7*LW/2 + LW/2 + zeros(1,45);
World.Intersection(1).NS.Lane(1).y = 195:-1:151;
World.Intersection(1).NS.Lane(2).x = 130 - 9*LW/2 + LW/2 + zeros(1,45);
World.Intersection(1).NS.Lane(2).y = 195:-1:151;
World.Intersection(1).NE.Lane(1).x = [130 - 5*LW/2 + LW/2 + zeros(1,10) 120 + 5*LW/2 + 5*LW/2 * cos(Range) 133.5-0.5:1:143-0.5];
World.Intersection(1).NE.Lane(1).y = [195:-1:186 185 + 7*LW/2 * sin(Range) 167.5000+zeros(1,10)];
World.Intersection(1).NS.Barrier(1).x = [130 - 9*LW/2 + zeros(1,10)];
World.Intersection(1).NS.Barrier(1).y = [194:-1:185];
World.Intersection(1).NS.Barrier(2).x = [130 - 7*LW/2 + zeros(1,10)];
World.Intersection(1).NS.Barrier(2).y = [194:-1:185];
World.Intersection(1).NS.Barrier(3).x = [130 - 5*LW/2 + zeros(1,10)];
World.Intersection(1).NS.Barrier(3).y = [194:-1:185];
World.Intersection(1).NS.Barrier(4).x = [130 - 3*LW/2 + zeros(1,10)];
World.Intersection(1).NS.Barrier(4).y = [194:-1:185];
World.Intersection(1).NS.Barrier(5).x = [130 - LW/2 + zeros(1,10)];
World.Intersection(1).NS.Barrier(5).y = [194:-1:185];
World.Intersection(1).NS.Barrier(6).x = [130 + LW/2 + zeros(1,10)];
World.Intersection(1).NS.Barrier(6).y = [194:-1:185];

X = [X World.Intersection(1).NS.Lane(1).x];
Y = [Y World.Intersection(1).NS.Lane(1).y];
G = addnode(G,length(World.Intersection(1).NS.Lane(1).x));
for i = lastI+1:lastI+length(World.Intersection(1).NS.Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
X = [X World.Intersection(1).NS.Lane(2).x];
Y = [Y World.Intersection(1).NS.Lane(2).y];
G = addnode(G,length(World.Intersection(1).NS.Lane(2).x));
for i = lastI+1:lastI+length(World.Intersection(1).NS.Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
X = [X World.Intersection(1).NE.Lane(1).x];
Y = [Y World.Intersection(1).NE.Lane(1).y];
G = addnode(G,length(World.Intersection(1).NE.Lane(1).x));
for i = lastI+1:lastI+length(World.Intersection(1).NE.Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;

%
G = addedge(G,2136,2809);G = addedge(G,2136,2719);
%
%
G = addedge(G,2111,2764);G = addedge(G,2111,2719);
%
%
G = addedge(G,2845,1972);G = addedge(G,2845,1945);
%
%
G = addedge(G,2808,583);
% G = addedge(G,2808,702);
%
%
G = addedge(G,2763,583);G = addedge(G,2763,702);
%

Range = 3*pi/2:StepSize:2*pi;
World.Intersection(1).WE.Lane(1).x = 97.5:1:142.5;
World.Intersection(1).WE.Lane(1).y = 160 + LW/2 + zeros(1,46);
World.Intersection(1).WE.Lane(2).x = 97.5:1:142.5;
World.Intersection(1).WE.Lane(2).y = 160 + 3*LW/2 + zeros(1,46);
World.Intersection(1).WN.Lane(1).x = [97.5:1:107.5 107.5+7*LW/2*cos(Range) 125 + zeros(1,11)];
World.Intersection(1).WN.Lane(1).y = [160 + 5*LW/2 + zeros(1,11) 160+10*LW/2+5*LW/2*sin(Range) 185-0.5:1:195-0.5];
World.Intersection(1).WE.Barrier(1).x = [98.5:1:107.5];
World.Intersection(1).WE.Barrier(1).y = [160 + zeros(1,10)];
World.Intersection(1).WE.Barrier(2).x = [98.5:1:107.5];
World.Intersection(1).WE.Barrier(2).y = [160 + LW + zeros(1,10)];
World.Intersection(1).WE.Barrier(3).x = [98.5:1:107.5];
World.Intersection(1).WE.Barrier(3).y = [160 + 2*LW + zeros(1,10)];
World.Intersection(1).WE.Barrier(4).x = [98.5:1:107.5];
World.Intersection(1).WE.Barrier(4).y = [160 + 3*LW + zeros(1,10)];
World.Intersection(1).WE.Barrier(5).x = [98.5:1:107.5];
World.Intersection(1).WE.Barrier(5).y = [160 + 4*LW + zeros(1,10)];
World.Intersection(1).WE.Barrier(6).x = [98.5:1:107.5];
World.Intersection(1).WE.Barrier(6).y = [160 + 5*LW + zeros(1,10)];

X = [X World.Intersection(1).WE.Lane(1).x];
Y = [Y World.Intersection(1).WE.Lane(1).y];
G = addnode(G,length(World.Intersection(1).WE.Lane(1).x));
for i = lastI+1:lastI+length(World.Intersection(1).WE.Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
X = [X World.Intersection(1).WE.Lane(2).x];
Y = [Y World.Intersection(1).WE.Lane(2).y];
G = addnode(G,length(World.Intersection(1).WE.Lane(2).x));
for i = lastI+1:lastI+length(World.Intersection(1).WE.Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
X = [X World.Intersection(1).WN.Lane(1).x];
Y = [Y World.Intersection(1).WN.Lane(1).y];
G = addnode(G,length(World.Intersection(1).WN.Lane(1).x));
for i = lastI+1:lastI+length(World.Intersection(1).WN.Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;

%
G = addedge(G,1752,2938);G = addedge(G,1752,2892);
%
%
G = addedge(G,1656,2846);G = addedge(G,1656,2892);
%
%
G = addedge(G,2937,1972);G = addedge(G,2937,1945);
%
%
G = addedge(G,2975,2161);G = addedge(G,2975,2186);
%

Range = pi/2:StepSize:pi;
World.Intersection(1).EW.Lane(1).x = 142.5:-1:97.5;
World.Intersection(1).EW.Lane(1).y = 160 + 9*LW/2 + zeros(1,46);
World.Intersection(1).EW.Lane(2).x = 142.5:-1:97.5;
World.Intersection(1).EW.Lane(2).y = 160 + 7*LW/2 + zeros(1,46);
World.Intersection(1).ES.Lane(1).x = [142.5:-1:132.5 132.5+7*LW/2*cos(Range) 115 + zeros(1,10)];
World.Intersection(1).ES.Lane(1).y = [160 + 5*LW/2 + zeros(1,11) 160+5*LW/2*sin(Range) 160+0.5:-1:151+0.5];
World.Intersection(1).EW.Barrier(1).x = [141.5:-1:132.5];
World.Intersection(1).EW.Barrier(1).y = [160 + zeros(1,10)];
World.Intersection(1).EW.Barrier(2).x = [141.5:-1:132.5];
World.Intersection(1).EW.Barrier(2).y = [160 + LW + zeros(1,10)];
World.Intersection(1).EW.Barrier(3).x = [141.5:-1:132.5];
World.Intersection(1).EW.Barrier(3).y = [160 + 2*LW + zeros(1,10)];
World.Intersection(1).EW.Barrier(4).x = [141.5:-1:132.5];
World.Intersection(1).EW.Barrier(4).y = [160 + 3*LW + zeros(1,10)];
World.Intersection(1).EW.Barrier(5).x = [141.5:-1:132.5];
World.Intersection(1).EW.Barrier(5).y = [160 + 4*LW + zeros(1,10)];
World.Intersection(1).EW.Barrier(6).x = [141.5:-1:132.5];
World.Intersection(1).EW.Barrier(6).y = [160 + 5*LW + zeros(1,10)];

X = [X World.Intersection(1).EW.Lane(1).x];
Y = [Y World.Intersection(1).EW.Lane(1).y];
G = addnode(G,length(World.Intersection(1).EW.Lane(1).x));
for i = lastI+1:lastI+length(World.Intersection(1).EW.Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
X = [X World.Intersection(1).EW.Lane(2).x];
Y = [Y World.Intersection(1).EW.Lane(2).y];
G = addnode(G,length(World.Intersection(1).EW.Lane(2).x));
for i = lastI+1:lastI+length(World.Intersection(1).EW.Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
X = [X World.Intersection(1).ES.Lane(1).x];
Y = [Y World.Intersection(1).ES.Lane(1).y];
G = addnode(G,length(World.Intersection(1).ES.Lane(1).x));
for i = lastI+1:lastI+length(World.Intersection(1).ES.Lane(1).x)-1
    G = addedge(G,i,i+1);
end
lastI = i+1;
%
G = addedge(G,1999,3068);G = addedge(G,1999,3022);
%
%
G = addedge(G,2026,2976);G = addedge(G,2026,3022);
%
%
G = addedge(G,3021,1944);
% G = addedge(G,3021,1848);
%
%
G = addedge(G,3067,1944);G = addedge(G,3067,1848);
%
%
G = addedge(G,2891,1945);
% G = addedge(G,2891,1972);
%
%
G = addedge(G,3104,702);G = addedge(G,3104,583);
%



%% right turns
World.Intersection(1).NE.Lane(1).x = 131.25;
World.Intersection(1).NE.Lane(1).y = 161.25;
G = addnode(G,length(World.Intersection(1).NE.Lane(1).x));


World.Intersection(1).WS.Lane(1).x = 108.75;
World.Intersection(1).WS.Lane(1).y = 161.25;
G = addnode(G,length(World.Intersection(1).WS.Lane(1).x));

World.Intersection(1).EN.Lane(1).x = 131.25;
World.Intersection(1).EN.Lane(1).y = 183.75;
G = addnode(G,length(World.Intersection(1).EN.Lane(1).x));

World.Intersection(1).SW.Lane(1).x = 108.75;
World.Intersection(1).SW.Lane(1).y = 183.75;
G = addnode(G,length(World.Intersection(1).EN.Lane(1).x));
G = addedge(G,2602,3105); G = addedge(G,3105,2881);
G = addedge(G,2986,3107); G = addedge(G,3107,2627);
G = addedge(G,2774,3108); G = addedge(G,3108,3011);
G = addedge(G,2856,3106); G = addedge(G,3106,2799);

X = [X World.Intersection(1).NE.Lane(1).x World.Intersection(1).WS.Lane(1).x World.Intersection(1).EN.Lane(1).x World.Intersection(1).SW.Lane(1).x];
Y = [Y World.Intersection(1).NE.Lane(1).y World.Intersection(1).WS.Lane(1).y World.Intersection(1).EN.Lane(1).y World.Intersection(1).SW.Lane(1).y];

drawWorld(World)

% for i = 1:size(G.Nodes,1)
% G.Nodes.Name = cellstr(num2str([1:size(G.Nodes,1)]'));
% end
% figure;plot(G, 'XData',X,'YData',Y)
% G.Nodes.Name = cellstr(num2str([1:size(G.Nodes,1)]'));
% figure;plot(G, 'XData',X,'YData',Y, 'NodeLabel',G.Nodes.Name)
figure;plot(G, 'XData',X,'YData',Y)
% G.Nodes.X = [];
% G.Nodes.Y = [];
% G.Nodes.X = X;
% G.Nodes.Y = Y;
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












function World = addCurveTwo(World,x0,xf,y0,yf,Range)
LW = 5;
if (xf-x0~=yf-y0)
    error('not supported yet.')
end

R = xf-x0;
StepSize = 0.1;

R_waypoint = R-5*LW/2;
R_Barrier1 = R-2*LW;
R_Barrier2 = R-3*LW;
N = length(World.Road)+1;
World.Road(N).Lane(1).x = x0 + R_waypoint * cos(Range);
World.Road(N).Lane(1).y = y0 + 5*LW/2 + R_waypoint + R_waypoint * sin(Range);
World.Road(N).Lane(1).Barrier(1).x = x0 + R_Barrier1 * cos(Range);
World.Road(N).Lane(1).Barrier(1).y = y0 + 2*LW + R_Barrier1 + R_Barrier1 * sin(Range);
World.Road(N).Lane(1).Barrier(2).x = x0 + R_Barrier2 * cos(Range);
World.Road(N).Lane(1).Barrier(2).y = y0 + 3*LW + R_Barrier2 + R_Barrier2 * sin(Range);

R_waypoint = R-7*LW/2;
R_Barrier1 = R-3*LW;
R_Barrier2 = R-4*LW;
World.Road(N).Lane(2).x = x0 + R_waypoint * cos(Range);
World.Road(N).Lane(2).y = y0 + 7*LW/2 + R_waypoint + R_waypoint * sin(Range);
World.Road(N).Lane(2).Barrier(1).x = x0 + R_Barrier1 * cos(Range);
World.Road(N).Lane(2).Barrier(1).y = y0 + 3*LW + R_Barrier1 + R_Barrier1 * sin(Range);
World.Road(N).Lane(2).Barrier(2).x = x0 + R_Barrier2 * cos(Range);
World.Road(N).Lane(2).Barrier(2).y = y0 + 4*LW + R_Barrier2 + R_Barrier2 * sin(Range);

N = N + 1;
R_waypoint = R-LW/2;
R_Barrier1 = R-0;
R_Barrier2 = R-LW;
World.Road(N).Lane(1).x = x0 + R_waypoint * cos(Range);
World.Road(N).Lane(1).y = y0 + LW/2 + R_waypoint + R_waypoint * sin(Range);
World.Road(N).Lane(1).Barrier(1).x = x0 + R_Barrier1 * cos(Range);
World.Road(N).Lane(1).Barrier(1).y = y0 + R_Barrier1 + R_Barrier1 * sin(Range);
World.Road(N).Lane(1).Barrier(2).x = x0 + R_Barrier2 * cos(Range);
World.Road(N).Lane(1).Barrier(2).y = y0 + LW + R_Barrier2 + R_Barrier2 * sin(Range);

R_waypoint = R-3*LW/2;
R_Barrier1 = R-LW;
R_Barrier2 = R-2*LW;
World.Road(N).Lane(2).x = x0 + R_waypoint * cos(Range);
World.Road(N).Lane(2).y = y0 + 3*LW/2 + R_waypoint + R_waypoint * sin(Range);
World.Road(N).Lane(2).Barrier(1).x = x0 + R_Barrier1 * cos(Range);
World.Road(N).Lane(2).Barrier(1).y = y0 + LW + R_Barrier1 + R_Barrier1 * sin(Range);
World.Road(N).Lane(2).Barrier(2).x = x0 + R_Barrier2 * cos(Range);
World.Road(N).Lane(2).Barrier(2).y = y0 + 2*LW + R_Barrier2 + R_Barrier2 * sin(Range);
end


function World = addHorizontalTwo(World,x0,xf,y0,yf)
LW = 5;
if yf-y0 ~= 4*LW
    error('two lanes')
end
N = length(World.Road)+1;
LS = length(x0:1:xf);
World.Road(N).Lane(1).x = x0:1:xf;
World.Road(N).Lane(1).y = y0 + LW/2 + zeros(1,LS);
World.Road(N).Lane(1).Barrier(1).x = x0:1:xf;
World.Road(N).Lane(1).Barrier(1).y = y0 + 0 + zeros(1,LS);
World.Road(N).Lane(1).Barrier(2).x = x0:1:xf;
World.Road(N).Lane(1).Barrier(2).y = y0 + LW + zeros(1,LS);

World.Road(N).Lane(2).x = x0:1:xf;
World.Road(N).Lane(2).y = y0 + 3*LW/2 + zeros(1,LS);
World.Road(N).Lane(2).Barrier(1).x = x0:1:xf;
World.Road(N).Lane(2).Barrier(1).y = y0 + LW + zeros(1,LS);
World.Road(N).Lane(2).Barrier(2).x = x0:1:xf;
World.Road(N).Lane(2).Barrier(2).y = y0 + 2*LW + zeros(1,LS);
end

function World = addVerticalTwo(World,x0,xf,y0,yf)
LW = 5;
if xf-x0 ~= 4*LW
    error('two lanes')
end
N = length(World.Road)+1;
LS = length(y0:1:yf);
World.Road(N).Lane(1).x = x0+LW/2 + zeros(1,LS);
World.Road(N).Lane(1).y = y0:1:yf;
World.Road(N).Lane(1).Barrier(1).x = x0 + zeros(1,LS);
World.Road(N).Lane(1).Barrier(1).y = y0:1:yf;
World.Road(N).Lane(1).Barrier(2).x = x0 + LW + zeros(1,LS);
World.Road(N).Lane(1).Barrier(2).y = y0:1:yf;

World.Road(N).Lane(2).x = x0 + 3*LW/2 + zeros(1,LS);
World.Road(N).Lane(2).y = y0:1:yf;
World.Road(N).Lane(2).Barrier(1).x = x0 + LW + zeros(1,LS);
World.Road(N).Lane(2).Barrier(1).y = y0:1:yf;
World.Road(N).Lane(2).Barrier(2).x = x0 + 2*LW + zeros(1,LS);
World.Road(N).Lane(2).Barrier(2).y = y0:1:yf;

end


function World = addHorizontalOne(World,x0,xf,y0,yf)
LW = 5;
if yf-y0 ~= 2*LW
    error('one lane')
end
N = length(World.Road)+1;
LS = length(x0:1:xf);
World.Road(N).Lane(1).x = x0:1:xf;
World.Road(N).Lane(1).y = y0 + LW/2 + zeros(1,LS);
World.Road(N).Lane(1).Barrier(1).x = x0:1:xf;
World.Road(N).Lane(1).Barrier(1).y = y0 + + zeros(1,LS);
World.Road(N).Lane(1).Barrier(2).x = x0:1:xf;
World.Road(N).Lane(1).Barrier(2).y = y0 + LW + zeros(1,LS);
end

function World = addVerticalOne(World,x0,xf,y0,yf)
LW = 5;
if xf-x0 ~= 2*LW
    error('one lane')
end
N = length(World.Road)+1;
LS = length(y0:1:yf);
World.Road(N).Lane(1).x = x0+LW/2 + zeros(1,LS);
World.Road(N).Lane(1).y = y0:1:yf;
World.Road(N).Lane(1).Barrier(1).x = x0 + zeros(1,LS);
World.Road(N).Lane(1).Barrier(1).y = y0:1:yf;
World.Road(N).Lane(1).Barrier(2).x = x0 + LW + zeros(1,LS);
World.Road(N).Lane(1).Barrier(2).y = y0:1:yf;
end


function World = addCurveOne(World,x0,xf,y0,yf,Range)
LW = 5;
if (xf-x0~=yf-y0)
    error('not supported yet.')
end

R = xf-x0;
StepSize = 0.1;

R_waypoint = R-5*LW/2;
R_Barrier1 = R-2*LW;
R_Barrier2 = R-3*LW;
N = length(World.Road)+1;
World.Road(N).Lane(1).x = x0 + R_waypoint * cos(Range);
World.Road(N).Lane(1).y = y0 + 5*LW/2 + R_waypoint + R_waypoint * sin(Range);
World.Road(N).Lane(1).Barrier(1).x = x0 + R_Barrier1 * cos(Range);
World.Road(N).Lane(1).Barrier(1).y = y0 + 2*LW + R_Barrier1 + R_Barrier1 * sin(Range);
World.Road(N).Lane(1).Barrier(2).x = x0 + R_Barrier2 * cos(Range);
World.Road(N).Lane(1).Barrier(2).y = y0 + 3*LW + R_Barrier2 + R_Barrier2 * sin(Range);


N = N + 1;
R_waypoint = R-LW/2;
R_Barrier1 = R-0;
R_Barrier2 = R-LW;
World.Road(N).Lane(1).x = x0 + R_waypoint * cos(Range);
World.Road(N).Lane(1).y = y0 + LW/2 + R_waypoint + R_waypoint * sin(Range);
World.Road(N).Lane(1).Barrier(1).x = x0 + R_Barrier1 * cos(Range);
World.Road(N).Lane(1).Barrier(1).y = y0 + R_Barrier1 + R_Barrier1 * sin(Range);
World.Road(N).Lane(1).Barrier(2).x = x0 + R_Barrier2 * cos(Range);
World.Road(N).Lane(1).Barrier(2).y = y0 + LW + R_Barrier2 + R_Barrier2 * sin(Range);

end
end