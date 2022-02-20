import geopandas as gpd
# GeoDataFrame creation
file = 'wardsjoined.shp'
poly = gpd.read_file(file)
points = poly.copy()

# change the geometry
points.geometry = points['geometry'].centroid
points.to_crs(epsg=4326, inplace=True)
# same crs #points.crs =poly.crs
# print(points['geometry'])
print("wardid|wardname|laid|laname|longitude|latitude")
for index, row in points.iterrows():
    wardid = row['WD20CD']
    wardname = row['WD20NM']
    laid = row['ward2LA_LA']
    laname = row['ward2LA__1']
    centroid_lat = str(row['geometry'].x)
    centroid_lon = str(row['geometry'].y)
    print ( wardid + "|" + wardname + "|" + laid + "|" + laname + "|" + centroid_lat + "|" + centroid_lon )
