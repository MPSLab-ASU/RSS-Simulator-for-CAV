function p = getPoints(travelDistance,plan, World)
d = 0;i = 1;p =[];
while d < travelDistance && i < length(plan) 
    p = [p plan(i)];
    d = d + eDistance(World.Nodes.X(plan(i)), World.Nodes.X(plan(i+1)), World.Nodes.Y(plan(i)), World.Nodes.Y(plan(i+1)));
    i = i + 1;
end