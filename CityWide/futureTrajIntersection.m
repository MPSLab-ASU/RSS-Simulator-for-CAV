function [x,y] = futureTrajIntersection(vehicle1,vehicle2)
% fo1 and fo2 are Matlab fitobjects with 'poly2' fittype
fo1 = fit(vehicle1.CX', vehicle1.CY', 'poly2');
fo2 = fit(vehicle2.CX', vehicle2.CY', 'poly2');
xmin1=min(vehicle1.CX);xmax1=max(vehicle1.CX);
xmin2=min(vehicle2.CX);xmax2=max(vehicle2.CX);
ymin1=min(vehicle1.CY);ymax1=max(vehicle1.CY);
ymin2=min(vehicle2.CY);ymax2=max(vehicle2.CY);
r = roots([fo1.p1-fo2.p1 fo1.p2-fo2.p2 fo1.p3-fo2.p3]);
x=[];y=[];
for i = 1:length(r)
    if r(i) > xmin1 && r(i) > xmin2 && r(i) < xmax1 && r(i) < xmax2
        if fo1(r(i)) > ymin1 && fo1(r(i)) > ymin2 && fo1(r(i)) < ymax1 && fo1(r(i)) < ymax2
            x = r(i);
            y = fo1(r(i));
        end
    end
end


