name = 'openstreetmap';
url = 'a.tile.openstreetmap.org';
copyright = char(uint8(169));
attribution = copyright + "OpenStreetMap contributors";
addCustomBasemap(name,url,'Attribution',attribution)
pts = gpxread('boston_placenames');
gb = geobubble(pts.Latitude,pts.Longitude,'Basemap','openstreetmap');
gb.BubbleWidthRange = 25;
gb.MapLayout = 'maximized';
gb.ZoomLevel = 14;