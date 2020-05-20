function [deadlock, resolutions,tDeadlock, allConflicts] = DeadlockDetectionAndResolve(allConflicts, Now, tDeadlock)
resolutions = [];

%% First check
info = [];
size(allConflicts)
timeoutForDeadloackCheck = 1;
for i = 1:length(allConflicts)
    for j = 1:length(allConflicts{i})
        CAV1ID = allConflicts{i}(j).CAV.ID;
        CAV2ID = allConflicts{i}(j).AdvCAV.ID;
        if allConflicts{i}(j).hasDisadvantage == 1
            hasDisAdv = allConflicts{i}(j).AdvCAV.ID;
        else
            hasDisAdv = allConflicts{i}(j).CAV.ID;
        end
        arrivalTime2 = allConflicts{i}(j).AdvCAV.arrival;
        arrivalTime1 = allConflicts{i}(j).CAV.arrival;
        zone = allConflicts{i}(j).zone;
        info = [info; CAV1ID CAV2ID hasDisAdv arrivalTime1 arrivalTime2];
    end
end

nodes = [];
names = [];
for i = 1:size(info,1)
    if min(info(i,1),info(i,2)) == info(i,1)
        arrivalofminCAV = info(i,4);
        arrivalofmaxCAV = info(i,5);
    else
        arrivalofminCAV = info(i,5);
        arrivalofmaxCAV = info(i,4);
    end
    zone = [min(info(i,1),info(i,2)) max(info(i,1),info(i,2)) arrivalofminCAV arrivalofmaxCAV];
    CAVID = info(i,1);
    AdvCAVID = info(i,2);
    if isempty(nodes)
        nodes = [nodes; zone CAVID; zone AdvCAVID];
        names = [names; sprintf('<%d%d-%3.2f-%3.2f,%d>', zone, CAVID); sprintf('<%d%d-%3.2f-%3.2f,%d>', zone, AdvCAVID)];
        % [Zone(minID maxID minArrival maxArrival) CAV]
    else
        found = 0;
        for j = 1:size(nodes,1)
            newNode = [zone];
            if nodes(j,1) == newNode(1) && nodes(j,2) == newNode(2) && nodes(j,3) == newNode(3) && nodes(j,4) == newNode(4)
                found = 1;
                break
            end
        end
        if found == 0
            nodes = [nodes; zone CAVID; zone AdvCAVID];

            if Now == 7.45
                disp('a')
            end
%             names = [names; sprintf('<%d%d-%3.2f-%3.2f,%d>', zone, CAVID); sprintf('<%d%d-%3.2f-%3.2f,%d>', zone, AdvCAVID)];
            % [Zone(minID maxID minArrival maxArrival) CAV]
        end
    end
    
end
G = digraph;


numVehicleInvolved = length(allConflicts);

for i = 1:numVehicleInvolved
    set = [];
    for j = 1:size(nodes,1)
        if nodes(j,5) == i
            set = [set; j nodes(j,:)];
        end
    end
    newSet = [];
    while ~isempty(set)
        if i == set(1,2)
            [~, index] = min(set(:,4));
        elseif i == set(1,3)
            [~, index] = min(set(:,5));
        else
            error('not possible')
        end
        newSet = [newSet; set(index,:)];
        set(index,:) = [];
    end
    for j = 1:size(newSet,1)-1
        G = addedge(G, newSet(j+1,1), newSet(j,1));
    end
end


zones = [];
for i = 1:size(nodes,1)
    if rem(i,2) == 0
        zones = [zones; nodes(i,1:4)];
    end
end
numZones = size(zones,1);
%     if ~isempty(names)
%         G.Nodes.Name = cellstr(names);
%     end
% plot(G)
% disp('a')

for i = 1:numZones
    for j = 1:size(info,1)
        if zones(i,1) == info(j,1) && zones(i,2) == info(j,2) && zones(i,3) == info(j,4) && zones(i,4) == info(j,5)
            node1 = [zones(i,:) zones(i,1)];
            node2 = [zones(i,:) zones(i,2)];
            for k = 1:size(nodes,1)
                if isequal(nodes(k,:), node1)
                    node1index = k;
                end
                if isequal(nodes(k,:), node2)
                    node2index = k;
                end
                
            end
            if info(j,3) == zones(i,1)
                G = addedge(G, node1index, node2index);
            elseif info(j,3) == zones(i,2)
                G = addedge(G, node2index, node1index);
            else
                error('not possible')
            end
        end
    end
end
if ~isempty(names)
%     G.Nodes.Name = cellstr(names);
end
% plot(G)
% disp('a')


%% Detect and resolve Deadlock
if isdag(G) && ~isempty(G.Nodes)
    deadlock = 0;
else
    deadlock = 1;
end

if deadlock == 1 && ~isempty(names)
    for i = 1:length(allConflicts)
        sumOfTime(i) = 0;
        for j = 1:length(allConflicts{i})
            
            sumOfTime(i) = sumOfTime(i) + allConflicts{i}(j).CAV.arrival;
            
        end
    end
    [~, minIndex] = min(sumOfTime);
    for j = 1:length(allConflicts{minIndex})
        if allConflicts{minIndex}(j).hasDisadvantage == 1
            AdvID = allConflicts{minIndex}(j).AdvCAV.ID;
            ID = allConflicts{minIndex}(j).CAV.ID;
            allConflicts{minIndex}(j).hasDisadvantage = 0;
            %                 allConflicts{minIndex}(j).Forced = -2;
            for i = 1:length(allConflicts)
                for k = 1:length(allConflicts{i})
                    if allConflicts{i}(k).CAV.ID == AdvID && allConflicts{i}(k).AdvCAV.ID == ID
                        allConflicts{i}(k).hasDisadvantage = 1;
                        allConflicts{i}(k).Forced = Now + timeoutForDeadloackCheck;
                        resolutions = [resolutions; ID AdvID];
                        tDeadlock = Now;
                    end
                end
            end
        end
    end
end




while deadlock == 1 && ~isempty(G.Nodes)
    deadlock
    info = [];
    timeoutForDeadloackCheck = 1;
    for i = 1:length(allConflicts)
        for j = 1:length(allConflicts{i})
            CAV1ID = allConflicts{i}(j).CAV.ID;
            CAV2ID = allConflicts{i}(j).AdvCAV.ID;
            if allConflicts{i}(j).hasDisadvantage == 1
                hasDisAdv = allConflicts{i}(j).AdvCAV.ID;
            else
                hasDisAdv = allConflicts{i}(j).CAV.ID;
            end
            arrivalTime2 = allConflicts{i}(j).AdvCAV.arrival;
            arrivalTime1 = allConflicts{i}(j).CAV.arrival;
            zone = allConflicts{i}(j).zone;
            info = [info; CAV1ID CAV2ID hasDisAdv arrivalTime1 arrivalTime2];
        end
    end
    
    nodes = [];
    names = [];
    for i = 1:size(info,1)
        if min(info(i,1),info(i,2)) == info(i,1)
            arrivalofminCAV = info(i,4);
            arrivalofmaxCAV = info(i,5);
        else
            arrivalofminCAV = info(i,5);
            arrivalofmaxCAV = info(i,4);
        end
        zone = [min(info(i,1),info(i,2)) max(info(i,1),info(i,2)) arrivalofminCAV arrivalofmaxCAV];
        CAVID = info(i,1);
        AdvCAVID = info(i,2);
        if isempty(nodes)
            nodes = [nodes; zone CAVID; zone AdvCAVID];
            names = [names; sprintf('<%d%d-%3.2f-%3.2f,%d>', zone, CAVID); sprintf('<%d%d-%3.2f-%3.2f,%d>', zone, AdvCAVID)];
            % [Zone(minID maxID minArrival maxArrival) CAV]
        else
            found = 0;
            for j = 1:size(nodes,1)
                newNode = [zone];
                if nodes(j,1) == newNode(1) && nodes(j,2) == newNode(2) && nodes(j,3) == newNode(3) && nodes(j,4) == newNode(4)
                    found = 1;
                    break
                end
            end
            if found == 0
                nodes = [nodes; zone CAVID; zone AdvCAVID];
                names = [names; sprintf('<%d%d-%3.2f-%3.2f,%d>', zone, CAVID); sprintf('<%d%d-%3.2f-%3.2f,%d>', zone, AdvCAVID)];
                % [Zone(minID maxID minArrival maxArrival) CAV]
            end
        end
        
    end
    G = digraph;
    
    
    numVehicleInvolved = length(allConflicts);
    
    for i = 1:numVehicleInvolved
        set = [];
        for j = 1:size(nodes,1)
            if nodes(j,5) == i
                set = [set; j nodes(j,:)];
            end
        end
        newSet = [];
        while ~isempty(set)
            if i == set(1,2)
                [~, index] = min(set(:,4));
            elseif i == set(1,3)
                [~, index] = min(set(:,5));
            else
                error('not possible')
            end
            newSet = [newSet; set(index,:)];
            set(index,:) = [];
        end
        for j = 1:size(newSet,1)-1
            G = addedge(G, newSet(j+1,1), newSet(j,1));
        end
    end
    
    
    zones = [];
    for i = 1:size(nodes,1)
        if rem(i,2) == 0
            zones = [zones; nodes(i,1:4)];
        end
    end
    numZones = size(zones,1);
    %     if ~isempty(names)
    %         G.Nodes.Name = cellstr(names);
    %     end
    % plot(G)
    % disp('a')
    
    for i = 1:numZones
        for j = 1:size(info,1)
            if zones(i,1) == info(j,1) && zones(i,2) == info(j,2) && zones(i,3) == info(j,4) && zones(i,4) == info(j,5)
                node1 = [zones(i,:) zones(i,1)];
                node2 = [zones(i,:) zones(i,2)];
                for k = 1:size(nodes,1)
                    if isequal(nodes(k,:), node1)
                        node1index = k;
                    end
                    if isequal(nodes(k,:), node2)
                        node2index = k;
                    end
                    
                end
                if info(j,3) == zones(i,1)
                    G = addedge(G, node1index, node2index);
                elseif info(j,3) == zones(i,2)
                    G = addedge(G, node2index, node1index);
                else
                    error('not possible')
                end
            end
        end
    end
    if ~isempty(names)
        G.Nodes.Name = cellstr(names);
    end
    if isempty(G.Nodes)
        deadlock = 0;
        break;
    end
    % plot(G)
    % disp('a')
    
    
    %% Detect and resolve Deadlock
    if isdag(G) && ~isempty(G.Nodes)
        deadlock = 0;
    else
        deadlock = 1;
    end
    
    if deadlock == 1 && ~isempty(names)
        for i = 1:length(allConflicts)
            sumOfTime(i) = 0;
            for j = 1:length(allConflicts{i})
                
                sumOfTime(i) = sumOfTime(i) + allConflicts{i}(j).CAV.arrival;
                
            end
        end
        [~, minIndex] = min(sumOfTime);
        for j = 1:length(allConflicts{minIndex})
            if allConflicts{minIndex}(j).hasDisadvantage == 1
                AdvID = allConflicts{minIndex}(j).AdvCAV.ID;
                ID = allConflicts{minIndex}(j).CAV.ID;
                allConflicts{minIndex}(j).hasDisadvantage = 0;
                %                 allConflicts{minIndex}(j).Forced = -2;
                for i = 1:length(allConflicts)
                    for k = 1:length(allConflicts{i})
                        if allConflicts{i}(k).CAV.ID == AdvID && allConflicts{i}(k).AdvCAV.ID == ID
                            allConflicts{i}(k).hasDisadvantage = 1;
                            allConflicts{i}(k).Forced = Now + timeoutForDeadloackCheck;
                            resolutions = [resolutions; ID AdvID];
                            tDeadlock = Now;
                        end
                    end
                end
            end
        end
    end
    
    
    
end



