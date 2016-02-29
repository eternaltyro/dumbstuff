from geojson import Point
from geojson import Feature, FeatureCollection
from geojson import dump, load
import os

DATAFILE='libraries_new.geojson'

lat = input('lat: ')
lon = input('lon: ')
my_point = Point((lat,lon))

''' Properties:
    Name
    Operator
    Opening Hours
    Address
'''

name = raw_input('Name: ')
timings = raw_input('Time: ')
street = raw_input('Street: ')
housenumber = raw_input('Numb: ')
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
    'address:postcode':postcode } )

if os.stat(DATAFILE).st_size == 0:
    FILE_EMPTY = True
else:
    FILE_EMPTY = False

if not FILE_EMPTY:
    with open(DATAFILE,'r') as data:
        current = load(data)
        featureSet = current['features']
        featureSet.append(my_feature)
        libraries = FeatureCollection(featureSet)
else:
        libraries = FeatureCollection([my_feature])

with open(DATAFILE,'w+') as data:
    dump(libraries,data)

