clc;clear all;close all;
k = 1;L = 3;h = 0.1;B = 2; % B is the safety barrier in terms of seconds
CarLength = 5; CarWidth = 2;
N = 120;ll = 5;l = 100;
line([0 l/2],[0 sqrt(3) * l/2])
line([l l/2],[0 sqrt(3) * l/2])
line([0 l],[0 0])
vehicle1 = struct;
vehicle1.x(1) = 0 - ll/2;
vehicle1.y(1) = 0 - ll*sqrt(3)/2;
vehicle1.phi(1) = pi/3;
vehicle1.v(1) = 10;
vehicle1.ID = 1;

vehicle2 = struct;
vehicle2.x(1) = l + ll/2;
vehicle2.y(1) = 0 ;
vehicle2.phi(1) = pi;
vehicle2.v(1) = 10;
vehicle2.ID = 2;

vehicle3 = struct;
vehicle3.x(1) = (l-ll)/2;
vehicle3.y(1) = (l+ll)*sqrt(3)/2;
vehicle3.phi(1) = -pi/3;
vehicle3.v(1) = 10;
vehicle3.ID = 3;

vehicles = [vehicle1 vehicle2 vehicle3];

for i = 1:N
    time = i*h;
    %     eta1c1 = abs(x1(i)-c1)/abs(v1(i)) + time;
    %     eta2c1 = abs(x2(i)-c1)/abs(v2(i)) + time;
    %     eta1c2 = abs(x1(i)-c2)/abs(v1(i)) + time;
    %     eta2c2 = abs(x2(i)-c2)/abs(v2(i)) + time;
    %% Vehicle 1
    a(i) = 0;
    sai(i) = 0;
    %     if eta1c2 < eta2c2 + B
    %         vd1 = abs(x1(i)-c2)/abs(eta2c2+B);
    %         a1(i) = k * (vd1 - v1(i));
    %     end
    for j = 1:length(vehicles)
        
        vehicles(j).x(i+1) = vehicles(j).x(i) + h * vehicles(j).v(i) * cos(vehicles(j).phi(i));
        vehicles(j).y(i+1) = vehicles(j).y(i) + h * vehicles(j).v(i) * sin(vehicles(j).phi(i));
        vehicles(j).phi(i+1) = vehicles(j).phi(i) + h * (vehicles(j).v(i)/L) * tan(sai(i));
        vehicles(j).v(i+1) = vehicles(j).v(i) + h * a(i);
        if vehicles(j).v(i+1) < 0
            vehicles(j).v(i+1) = 0;
        end
    end
    %% Vehicle 2
    for j = 1:length(vehicles)
        phi = vehicles(j).phi(i);
        recX0=[-CarLength/2 CarLength/2 CarLength/2 -CarLength/2 -CarLength/2];
        recY0=[-CarWidth/2 -CarWidth/2 CarWidth/2 CarWidth/2 -CarWidth/2];
        RrecX0=recX0*cos(phi)-recY0*sin(phi);
        RrecY0=recX0*sin(phi)+recY0*cos(phi);
        recX=RrecX0 + vehicles(j).x(i);
        recY=RrecY0 + vehicles(j).y(i);
        line(recX,recY, 'LineWidth' , 1);
        text (vehicles(j).x(i),vehicles(j).y(i), num2str(vehicles(j).v(i)))
        hold on
    end
    axis([-10 110 -10 110])
    line([0 l/2],[0 sqrt(3) * l/2])
    line([l l/2],[0 sqrt(3) * l/2])
    line([0 l],[0 0])
    pause(0.1);
    cla;
end