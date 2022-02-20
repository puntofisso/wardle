import geopandas as gpd
# GeoDataFrame creation
file = 'LAD_MAY_2021_UK_BFE_V2.shp'
poly = gpd.read_file(file)
points = poly.copy()

# change the geometry
points.geometry = points['geometry'].centroid
points.to_crs(epsg=4326, inplace=True)
# same crs #points.crs =poly.crs
# print(points['geometry'])
print("laid|laname|longitude|latitude")
for index, row in points.iterrows():
    laid = row['LAD21CD']
    laname = row['LAD21NM']
    centroid_lat = str(row['geometry'].x)
    centroid_lon = str(row['geometry'].y)
    print ( laid + "|" + laname + "|" + centroid_lat + "|" + centroid_lon )
