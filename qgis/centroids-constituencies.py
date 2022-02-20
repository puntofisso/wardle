import geopandas as gpd
# GeoDataFrame creation
file = 'constituencies.shp'
poly = gpd.read_file(file)
points = poly.copy()

# change the geometry
# points.geometry = points['geometry'].centroid
points.to_crs(epsg=4326, inplace=True)
# same crs #points.crs =poly.crs
# print(points['geometry'])
for index, row in points.iterrows():
    conid = row['PCON20CD']
    conname = row['PCON20NM']
    lat = row['LAT']
    lon = row['LONG']
    # centroid_lat = str(row['geometry'].x)
    # centroid_lon = str(row['geometry'].y)
    print ( conid + "|" + conname + "|" + str(lat) + "|" + str(lon) )
