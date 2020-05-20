function drawLight(phase)
if phase == 1
    color1 = 'g'; % green
    color2 = 'r'; % red
    color3 = 'r'; % red
    color4 = 'r'; % red
elseif phase == 11
    color1 = 'y'; % yellow
    color2 = 'r'; % red
    color3 = 'r'; % red
    color4 = 'r'; % red
elseif phase == 2
    color1 = 'r'; % red
    color2 = 'g'; % green
    color3 = 'r'; % red
    color4 = 'r'; % red
elseif phase == 22
    color1 = 'r'; % red
    color2 = 'y'; % yellow
    color3 = 'r'; % red
    color4 = 'r'; % red
elseif phase == 3
    color1 = 'r'; % red
    color2 = 'r'; % red
    color3 = 'g'; % green
    color4 = 'r'; % red
elseif phase == 33
    color1 = 'r'; % red
    color2 = 'r'; % red
    color3 = 'y'; % yellow
    color4 = 'r'; % red
elseif phase == 4
    color1 = 'r'; % red
    color2 = 'r'; % red
    color3 = 'r'; % red
    color4 = 'g'; % green
elseif phase == 44
    color1 = 'r'; % red
    color2 = 'r'; % red
    color3 = 'r'; % red
    color4 = 'y'; % yellow
end


rectangle('Position',[122.5,160,10,2],'FaceColor',color1,'EdgeColor',[0 0 0],'LineWidth',1)
rectangle('Position',[107.5,185-2,10,2],'FaceColor',color1,'EdgeColor',[0 0 0],'LineWidth',1)

rectangle('Position',[117.5,160,5,2],'FaceColor',color2,'EdgeColor',[0 0 0],'LineWidth',1)
rectangle('Position',[117.5,185-2,5,2],'FaceColor',color2,'EdgeColor',[0 0 0],'LineWidth',1)

rectangle('Position',[107.5,160,2,10],'FaceColor',color3,'EdgeColor',[0 0 0],'LineWidth',1)
rectangle('Position',[132.5-2,175,2,10],'FaceColor',color3,'EdgeColor',[0 0 0],'LineWidth',1)

rectangle('Position',[107.5,170,2,5],'FaceColor',color4,'EdgeColor',[0 0 0],'LineWidth',1)
rectangle('Position',[132.5-2,170,2,5],'FaceColor',color4,'EdgeColor',[0 0 0],'LineWidth',1)