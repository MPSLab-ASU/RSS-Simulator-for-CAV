# OSM CONVERTER

### Dependencies
python 3.6.8  

numpy 1.17.5  

matplotlib 3.1.3  

geopy 2.0.0  

lxml 4.5.2

xmltodict 0.12.0

### Usage
Extract edges and nodes from the osm file to json file.  
We only extract the roads that are labeled motorway, trunk, primary, secondary
```
python src/extract.py <input osm file> <output json file>
```
Convert the json file into desired format(Two lanes, Directions, Arcs)
```
python src/Convert.py --input <input json file> --log <log png file> --output <output json file>
```

### Next Step, Convert to MAT
After generating the json file, run the ConvertWorld.m file to create the World file wit MAT format.
Later, this file can be used by the simulator (main.m)
