""" Script that uploads nodes from file

This python script reads data from a csv file and uploads the data to 
OpenStreetMap using OSM API.

TODO:
    Classify and methodify better
    Better Error Handling OsmApi, try except raise
    Haversine's distance formula??
    Logging to be improved
"""

from osmapi import OsmApi
import csv

"""Change below to edit the live-site"""
api_endpoint = u"api06.dev.openstreetmap.org"
csvfile = u'/tmp/mapathon.csv'
logfile = u'/tmp/osmupdate.log'

log_handle = open(logfile, 'a')

"""password file contents -  username:password"""
api_handle = OsmApi(passwordfile=u'/tmp/osm-dev.pwd', api=api_endpoint)
changeset = api_handle.ChangesetCreate({u'comment': u'Public-Mapathon-Upload'})
print "changeset ID: %d" % changeset

class OsmUpload(object):

    def __init__(self, csv_file):
        self.api = u'api06.dev.openstreetmap.org'
        self.passwordfile = u'/tmp/osm.pwd'
        self.csv_file = csv_file

    def create_point(self, list):
        self.lat = list[0]
        self.lon = list[1]
        return self.lat, self.lon

    def create_polygon(self, list):
        self.polygon_nodes = []
        for ordinate_pair in list:
            osm_handle = OsmApi(passwordfile=self.passwordfile, api=self.api)
            current_node = osm_handle.NodeCreate({"lat": ordinate_pair[0], 
                                                  "lon": ordinate_pair[1], 
                                                  "tag": {} })
            self.polygon_nodes.append(current_node)
        return self.polygon_nodes


def degrees_decimal(dot_string):
    x = dot_string.split('.')
    return float(x[0]) + float(x[1])/60 + float(x[2])/3600

def get_polygon(data_list):
    """List of tuples of co-ordinate pairs"""
    polygon_nodes = []
    for ordinate_pair in data_list:
        node_id = api_handle.NodeCreate({"lat": ordinate_pair[0],
                                         "lon": ordinate_pair[1], 
                                         "tag": {}})
        polygon_nodes.append(node_id)
    for node in polygon_nodes:
        yield node[u'id']

with open(csvfile) as csv_ptr:
    for line in csv.reader(csv_ptr):
        if line[0] == "node":
            """node,police,name,operator,levels,
               opening_hours,city,street,[(80,12)]
            """
            larr = eval(line[8])
            latlong = larr[0]
            data = {
                    u'lat':latlong[0], 
                    u'lon':latlong[1], 
                    u'tag': {
                        u'amenity':line[1], 
                        u'name':line[2], 
                        u'operator':line[3], 
                        u'level':line[4], 
                        u'opening_hours':line[5], 
                        u'addr:city':line[6], 
                        u'addr:street':line[7] 
                        } 
                    }
            node_create = api_handle.NodeCreate(data)
            #log_handle.write(node_create)
            print node_create

        elif line[0] == "way":
            node_list = [x for x in get_polygon(eval(line[8]))]
            data = { 
                    u'nd': node_list, 
                    u'tag': {
                        u'amenity':line[1], 
                        u'name':line[2], 
                        u'operator':line[3], 
                        u'level':line[4], 
                        u'opening_hours':line[5], 
                        u'addr:city':line[6], 
                        u'addr:street':line[7] 
                        } 
                    }
            way_create = api_handle.WayCreate(data)
            #log_handle.write(way_create)
            print way_create

        else:
            print 'Malformed CSV. Please fix'

api_handle.ChangesetClose()
log_handle.close()
