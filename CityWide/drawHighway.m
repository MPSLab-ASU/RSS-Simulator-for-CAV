function drawHighway(World, vehicles)
NN = length(vehicles);
XX = vehicles.x;
xmin = min(XX) - 5;
xmax = max(XX) + 5;
avg = (xmin + xmax) /2;
hold on;
for i = 1:length(World.Road)
    for j = 1:length(World.Road(i).Lane)
        %         plot(World.Road(i).Lane(j).x,World.Road(i).Lane(j).y,'-*')
    end
end


for i = 1:length(World.Road)
    for j = 1:length(World.Road(i).Lane)
        for k = 1:length(World.Road(i).Lane(j).Barrier)
            %             if i < 17 || i == 20 || i == 19
            if (j == 1 && k == 1) || (j == 8 && k == 2)
                color = [0 0 0];
                LS = '-';
            else
                color = [0.9290 0.6940 0.1250];
                LS = '--';
            end
            %             else
            %                 color = [0 0 0];
            %                 LS = '-';
            %             end
            plot(World.Road(i).Lane(j).Barrier(k).x,World.Road(i).Lane(j).Barrier(k).y, 'Color', color, 'LineStyle', LS)
        end
    end
end
ax = gcf;
ax.Position= [92 558 1509 420];
axis([avg - 150 avg + 150 -5 45])
