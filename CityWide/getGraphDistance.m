function d = getGraphDistance(traj, index)
d = 0;
for i = 1:index-1
    X = traj.x(i);
    Y = traj.y(i);
    XX = traj.x(i+1);
    YY = traj.y(i+1);
    d = d + eDistance(X, XX, Y, YY);
end
if index == 1
    X = traj.x(1);
    Y = traj.y(1);
    d = 0.1;
%     error('the conflict cannot be too close!')
else
    d = d + 0.1;
end