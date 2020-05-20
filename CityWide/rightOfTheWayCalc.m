function conflicts = rightOfTheWayCalc(conflicts, Now)
% if length(conflicts) == 1
%     conflicts.hasDisadvantage = 0;
%     for i = 1:length(conflicts)
%         if conflicts(i).CAV.arrival > conflicts(i).AdvCAV.arrival
%             conflicts.hasDisadvantage = 1;
%         end
%     end
% else
%% deadlock check
%     for i = 1:length(conflicts)

for i = 1:length(conflicts)
    %     if oldConflicts(i).Forced == -1 || oldConflicts(i).Forced == -2
    conflicts(i).hasDisadvantage = 0;
    if conflicts(i).AdvCavArrivalDistance < 6
        conflicts(i).hasDisadvantage = 1;
    else
        if conflicts(i).egoCavArrivalTime > conflicts(i).AdvCavArrivalTime
            conflicts(i).hasDisadvantage = 1;
        end
    end
    %     else
    %         if oldConflicts(i).Forced < Now
    %             conflicts(i).Forced  = -1; % release if timeout has passed
    %         else
    %             conflicts(i).Forced  = oldConflicts.Forced;
    %             conflicts(i).hasDisadvantage = 1;
    %         end
    %     end
end

% end
