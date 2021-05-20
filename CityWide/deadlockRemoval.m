function [found, Resolution] = deadlockRemoval(allConflicts)
Edge = [];
found = 0;
Resolution = [];
E = []; % 1st vehicle yields to the 2nd vehicle
for i = 1:length(allConflicts)
    for j=1:length(allConflicts{i})
        if allConflicts{i}(j).hasDisadvantage == 1
            E = [E; allConflicts{i}(j).egoCavID allConflicts{i}(j).AdvCavID i j];
        else
            E = [E; allConflicts{i}(j).AdvCavID allConflicts{i}(j).egoCavID i j];
        end
    end
end
if ~isempty(E)
Edge = E(:,1:2);
Edge = unique(Edge, 'row');
G = digraph;
for i = 1:size(Edge,1)
    G = addedge(G, Edge(i,1), Edge(i,2));
end
disp('')
while ~isdag(G)
    found = 1;
    nodes = Edge(:,1);
    for i = 1:length(nodes)
        sum(i) = 10000;
        for j = 1:length(allConflicts)
            for k = 1:length(allConflicts{j})
                if allConflicts{j}(k).egoCavID == Edge(i,1)
                    if allConflicts{j}(k).AdvCavID == Edge(i,2)
                        sum(i) = min(sum(i), allConflicts{j}(k).egoCavArrivalTime);
                    end
                end
            end
        end
    end
    [~,b] = max(sum);
    ACAV = Edge(b,1);
    DCAV = Edge(b,2);
    Resolution = [Resolution; ACAV DCAV];
    for j = 1:length(allConflicts)
        for k=1:length(allConflicts{j})
            if allConflicts{j}(k).egoCavID == ACAV
                if allConflicts{j}(k).AdvCavID == DCAV
                    allConflicts{j}(k).hasDisadvantage = 0;
                end
            end
            if allConflicts{j}(k).egoCavID == DCAV
                if allConflicts{j}(k).AdvCavID == ACAV
                    allConflicts{j}(k).hasDisadvantage = 1;
                end
            end
        end
    end
    
    E = []; % 1st vehicle yields to the 2nd vehicle
    for i = 1:length(allConflicts)
        for j=1:length(allConflicts{i})
            if allConflicts{i}(j).hasDisadvantage == 1
                E = [E; allConflicts{i}(j).egoCavID allConflicts{i}(j).AdvCavID i j];
            else
                E = [E; allConflicts{i}(j).AdvCavID allConflicts{i}(j).egoCavID i j];
            end
        end
    end
    Edge = E(:,1:2);
    Edge = unique(Edge, 'row');
    G = digraph;
    for i = 1:size(Edge,1)
        G = addedge(G, Edge(i,1), Edge(i,2));
    end
    
end
end



