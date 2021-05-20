clc;close all;
load World
% scenario = 3; % intersection
scenario = 4; % merge
if scenario == 3
    y0 = 173.75;
    x0 = 115.2;
    load intersection
end

if scenario == 4
    y0 = 221;
    x0 = 125;
    load merge
end
World.id = 1;
%% plot
N = length(ALLDATA.X);
N = 1;
% if rem(N,2) ~= 0
%     N = N-1;
% end
% M = N/2;
rho = 0.1;
amax = 5;
amin = -8;

for i = 1:2
    subplot(1, 2, i)
    hold on;
    x1 = ALLDATA.X{1}(3:end,1);
    y1 = ALLDATA.Y{1}(3:end,1);
    x2 = ALLDATA.X{1}(3:end,2);
    y2 = ALLDATA.Y{1}(3:end,2);
    phi1 = ALLDATA.PHI{1}(3:end,1);
    phi2 = ALLDATA.PHI{1}(3:end,2);
    v1 = ALLDATA.V{1}(3:end,1);
    v2 = ALLDATA.V{1}(3:end,2);
    DV(x1(end),y1(end),phi1(end), [1 0 0], '-')
    DV(x2(end),y2(end),phi2(end), [0 0 1],'-')

    theta = 0:0.1:2*pi;
    radius = 4;
    if scenario == 4 && i > 3
        x0 = x2(end);
        y0 = y2(end);
    end
    xCircle = x0 + radius * cos(theta);
    yCircle = y0 + radius * sin(theta);
    plot(xCircle,yCircle, 'Color', [0 0 0], 'LineStyle', '--', 'LineWidth', 1)
    DV(x1(1),y1(1),phi1(1), [1 0 0], ':')
    DV(x2(1),y2(1),phi2(1), [0 0 1],':')
    plot(x1,y1, 'r');
    
    plot(x2,y2, 'b');
    
    
    if scenario == 4
        STR = sprintf("Merge Scenario");
    else
        STR = sprintf("Intersection Scenario");
    end
    title(STR, 'FontSize', 11);
    xlabel('X(m)', 'FontSize',10, 'FontWeight','bold')
    ylabel('Y(m)', 'FontSize',10, 'FontWeight','bold')
    set(gca,'FontSize',10, 'FontWeight','bold')
    if scenario == 4
        axis([100 165 185 250])
    else
        axis([min(min(x1),min(x2))-5 max(max(x1),max(x2))+20 min(min(y1),min(y2))-5 max(max(y1),max(y2))+5])
    end
    grid on;
    

    theta = 0:0.1:2*pi;
    radius = 4;
    if scenario == 4 && i > 3
        x0 = x2(end);
        y0 = y2(end);
    end
    xCircle = x0 + radius * cos(theta);
    yCircle = y0 + radius * sin(theta);
    plot(xCircle,yCircle, 'Color', [0 0 0], 'LineStyle', '--')
    drawWorld(World)
%     for ii = 1:length(x1)
%         d1(ii) = eDistance(x0, x1(ii), y0, y1(ii));
%         d2(ii) = eDistance(x0, x2(ii), y0, y2(ii));
%         d_RSS(ii) = v1(ii) * rho + 0.5*rho^2*amax + ((v1(ii) + rho*amax)^2)/abs(2*amin) + 5;
%     end
%     index = length(x1);
%     for ii = 1:length(x1)-1
%         if d_RSS(ii) < d_RSS(ii+1) || d1(ii) < 0.3
%             index = ii;
%             break;
%         end
%     end
%     for ii = index:length(x1)
%         d_RSS(ii) = 0;
%     end
%     if i == N
        legend('CAV with Advantage','CAV with Disadvantage', 'Conflict Zone Boundary')
%     end
    
    
    
    y0 = 173.75;
    x0 = 115.2;
    load intersection
    scenario = 3;
%     subplot(2, N+1 , i+N+1)
%     plot(1:length(x1), d1(1:length(x1)), '-r');
%     hold on
%     plot(1:length(x1), d_RSS(1:length(x1)), 'Color', [0 0 0]);
%     xlabel('Time(m)', 'FontSize',10, 'FontWeight','bold')
%     ylabel('Distance(m)','FontSize',10, 'FontWeight','bold')
%     set(gca,'FontSize',10, 'FontWeight','bold')
%     grid on;
%     if i == N
%         legend(['Distance of Red CAV' newline 'from Conflict'],['Required Safe Distance' newline 'for Red CAV'])
%     end
%     axis([0 size(ALLDATA.X{i},1) 0 40])
    
    
%     r = rectangle('Position',[index-1 0 length(x1)-index+1 40]');
%     r.FaceColor = [0.9 0.9 0.9];
%     if index ~= length(x1)
%         text(100,15,'No Conflicts');
%         H = findobj(gca,'Type','text');
%         set(H,'Rotation',90);
%     end
    
    %     subplot(3, N , i+2*N)
    %     plot(1:size(ALLDATA.X{i},1), d2);
    %     xlabel('Time(m)', 'FontSize',10, 'FontWeight','bold')
    %     ylabel('Distance(m)','FontSize',10, 'FontWeight','bold')
    %     set(gca,'FontSize',10, 'FontWeight','bold')
    %     grid on;
    %     axis([0 size(ALLDATA.X{i},1) 0 40])
end
ax = gcf;
ax.Position = [50.6000 305.4000 1462 394.8000];
ax.PaperSize = [13.5000 4.5000];
% print('intersection.pdf', '-dpdf', ['-r', num2str(600)])
% print('merge.pdf', '-dpdf', ['-r', num2str(600)])

function DV(x,y,phi, color,str)
CarLength = 5;
CarWidth = 2;
PosX = x;
PosY = y;
color = color;
recX0=[-CarLength/2 CarLength/2 CarLength/2 -CarLength/2 -CarLength/2];
recY0=[-CarWidth/2 -CarWidth/2 CarWidth/2 CarWidth/2 -CarWidth/2];
RrecX0=recX0*cos(phi)-recY0*sin(phi);
RrecY0=recX0*sin(phi)+recY0*cos(phi);
recX=RrecX0 + PosX;
recY=RrecY0 + PosY;
line(recX,recY,'Color', color, 'LineWidth' , 1, 'LineStyle', str);
end