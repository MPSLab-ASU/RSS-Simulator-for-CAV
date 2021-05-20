function drawWorld(World)
%% Plotting
hold on;
for i = 1:length(World.Road)
    for j = 1:length(World.Road(i).Lane)
        %         plot(World.Road(i).Lane(j).x,World.Road(i).Lane(j).y,'-*')
    end
end

if 1
    for i = 1:length(World.Intersection)
        %% SN
        for j = 1:length(World.Intersection.SN.Lane)
            %         plot(World.Intersection.SN.Lane(j).x, World.Intersection.SN.Lane(j).y,'-*')
        end
        for j = 1:length(World.Intersection.SW.Lane)
            %         plot(World.Intersection.SW.Lane(j).x, World.Intersection.SW.Lane(j).y,'-*')
        end
        for j = 1:length(World.Intersection.SN.Barrier)
            if j == 1 || j == 6
                color = [0 0 0];
                LS = '-';
            end
            if j == 2 || j == 3 || j == 5
                color = [0.9290 0.6940 0.1250];
                LS = '-';
            end
            if j == 4
                color = [0 0 0];
                LS = '-';
            end
            plot(World.Intersection.SN.Barrier(j).x, World.Intersection.SN.Barrier(j).y, 'Color', color, 'LineStyle', LS)
        end
        %% NS
        for j = 1:length(World.Intersection.NS.Lane)
            %         plot(World.Intersection.NS.Lane(j).x, World.Intersection.NS.Lane(j).y,'-*')
        end
        for j = 1:length(World.Intersection.NE.Lane)
            %         plot(World.Intersection.NE.Lane(j).x, World.Intersection.NE.Lane(j).y,'-*')
        end
        for j = 1:length(World.Intersection.NS.Barrier)
            if j == 1 || j == 6
                color = [0 0 0];
                LS = '-';
            end
            if j == 2 || j == 3 || j == 5
                color = [0.9290 0.6940 0.1250];
                LS = '-';
            end
            if j == 4
                color = [0 0 0];
                LS = '-';
            end
            plot(World.Intersection.NS.Barrier(j).x, World.Intersection.NS.Barrier(j).y, 'Color', color, 'LineStyle', LS)
        end
        %% WE
        for j = 1:length(World.Intersection.WE.Lane)
            %         plot(World.Intersection.WE.Lane(j).x, World.Intersection.WE.Lane(j).y,'-*')
        end
        for j = 1:length(World.Intersection.WN.Lane)
            %         plot(World.Intersection.WN.Lane(j).x, World.Intersection.WN.Lane(j).y,'-*')
        end
        for j = 1:length(World.Intersection.WE.Barrier)
            if j == 1 || j == 6
                color = [0 0 0];
                LS = '-';
            end
            if j == 2 || j == 3 || j == 5
                color = [0.9290 0.6940 0.1250];
                LS = '-';
            end
            if j == 4
                color = [0 0 0];
                LS = '-';
            end
            plot(World.Intersection.WE.Barrier(j).x, World.Intersection.WE.Barrier(j).y, 'Color', color, 'LineStyle', LS)
        end
        %% EW
        for j = 1:length(World.Intersection.EW.Lane)
            %         plot(World.Intersection.EW.Lane(j).x, World.Intersection.EW.Lane(j).y,'-*')
        end
        for j = 1:length(World.Intersection.ES.Lane)
            %         plot(World.Intersection.ES.Lane(j).x, World.Intersection.ES.Lane(j).y,'-*')
        end
        for j = 1:length(World.Intersection.EW.Barrier)
            if j == 1 || j == 6
                color = [0 0 0];
                LS = '-';
            end
            if j == 2 || j == 4 || j == 5
                color = [0.9290 0.6940 0.1250];
                LS = '-';
            end
            if j == 3
                color = [0 0 0];
                LS = '-';
            end
            plot(World.Intersection.EW.Barrier(j).x, World.Intersection.EW.Barrier(j).y, 'Color', color, 'LineStyle', LS)
        end
    end
end

for i = 1:length(World.Road)
    for j = 1:length(World.Road(i).Lane)
        for k = 1:length(World.Road(i).Lane(j).Barrier)
            if i < 17 || i == 20 || i == 19
                if (j == 1 && k == 2) || (j == 2 && k == 1)
                    color = [0.9290 0.6940 0.1250];
                    LS = '--';
                else
                    color = [0 0 0];
                    LS = '-';
                end
            else
                color = [0 0 0];
                LS = '-';
            end
            plot(World.Road(i).Lane(j).Barrier(k).x,World.Road(i).Lane(j).Barrier(k).y, 'Color', color, 'LineStyle', LS)
        end
    end
end
%% small fixes
if World.id == 1
plot([144 141.5], [182.5 185], 'Color', [0 0 0])
plot([141.5 144], [160 162.5], 'Color', [0 0 0])
plot([96 98.5], [162.5 160], 'Color', [0 0 0])
plot([96 98.5], [182.5 185], 'Color', [0 0 0])
plot([171 170], [180 182.5], 'Color', [0 0 0])
plot([170 171], [172.5 175], 'Color', [0 0 0])
plot([170 171], [162.5 165], 'Color', [0 0 0])
plot([170 171], [172.5 170], 'Color', [0 0 0])
plot([144 141.5], [172.5 170], 'Color', [0 0 0])

plot([110 112.5], [220 221], 'Color', [0 0 0])
plot([117.5 120], [221 220], 'Color', [0 0 0])
plot([120 122.5], [220 221], 'Color', [0 0 0])
plot([127.5 130], [221 220], 'Color', [0 0 0])
plot([107.5 110], [194 196], 'Color', [0 0 0])
plot([122.5 120], [194 196], 'Color', [0 0 0])
plot([132.5 130], [194 196], 'Color', [0 0 0])

plot([107.5 110], [152 149], 'Color', [0 0 0])
plot([117.5 120], [152 149], 'Color', [0 0 0])
plot([132.5 130], [152 149], 'Color', [0 0 0])
plot([96 98.5], [172.5 175], 'Color', [0 0 0])
end
ax = gcf;
% ax.Position = [2357 106 987 797];
% text(200, 0, num2str(Now))