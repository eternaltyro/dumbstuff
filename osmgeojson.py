from geojson import FeatureCollection, Feature, Point

class LibraryPoint(object):

    def __init__(self, lat='', lon='', opening_hours='', operator='',
            housenumber='', city='', postcode='', amenity='library', country='IN'):
        self.lat = lat
        self.lon = lon
        self.opening_hours = opening_hours
        self.amenity = amenity
        self.operator = operator
        self.housenumber = housenumber
        self.city = city
        self.country = country
        self.postcode = postcode



def getDetails():
    lat = input('lat> ')
    lon = input('lon> ')
    opening_hours = raw_input('opening hours> ')
    operator = raw_input('operator> ')
    housenumber = raw_input('housenumber> ')
    postcode = raw_input('postcode> ')
    city = raw_input('city> ')
    return lat,lon,opening_hours,operator,housenumber,city,postcode

xyz = LibraryPoint(getDetails())
print xyz.lat, xyz.lon, xyz.postcode


