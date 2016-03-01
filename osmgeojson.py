from geojson import Point
from geojson import Feature, FeatureCollection
from geojson import dump, load
import os

def degree_decimal(dms_list):
    return dms_list[0] + (dms_list[1] / 60.0) + (dms_list[2] / 3600.0)

DATAFILE='libraries_new.geojson'
TESTFILE='libraries_test.geojson'
# Change the value to switch between test data and actual data
GEODATAFILE=DATAFILE
# COORD_SYSTEM='degree'
COORD_SYSTEM='decimal'

if COORD_SYSTEM == 'decimal':
    lat = input('lat: ')
    lon = input('lon: ')
elif COORD_SYSTEM == 'degree':
    lat_dms = raw_input('deg,min,sec: ')
    lon_dms = raw_input('deg,min,sec: ')
    lat = degree_decimal([float(x.strip()) for x in lat_dms.split(',')])
    lon = degree_decimal([float(y.strip()) for y in lon_dms.split(',')])

# GeoJSON point is (Easting, Northing) / (Long, Lat) order!
my_point = Point((lon,lat))

''' Properties: {
        Name: Name of the library
        Operator: Directorate of Public Libraries
        Opening Hours: Open hours in OSM format
        Address: Door number if available and street
'''

name = raw_input('Name: ')
timings = raw_input('Time: ')
street = raw_input('Street: ')
housenumber = raw_input('Door: ')
postcode = raw_input('PINCODE: ')

my_feature = Feature(geometry=my_point, properties={
    'amenity':'library',
    'name':name,
    'operator':'Directorate of Public Libraries',
    'opening_hours':timings,
    'addr:country':'IN',
    'addr:city':'Chennai',
    'addr:street':street,
    'addr:housenumber':housenumber,
    'address:postcode':postcode,
    'marker-symbol': 'library'
    } )

if os.stat(GEODATAFILE).st_size == 0:
    FILE_EMPTY = True
else:
    FILE_EMPTY = False

if not FILE_EMPTY:
    with open(GEODATAFILE,'r') as data:
        current = load(data)
        featureSet = current['features']
        featureSet.append(my_feature)
        libraries = FeatureCollection(featureSet)
else:
    libraries = FeatureCollection([my_feature])

with open(GEODATAFILE,'w+') as data:
    dump(libraries, data, indent=4, sort_keys=True)


