#!/usr/bin/env python2

""" Script that uploads nodes from file

This python script reads data from a csv file and uploads the data to 
OpenStreetMap using OSM API.
"""
from osmapi import OsmApi
import csv

'''Change below to edit the live-site'''
api_endpoint = "api06.dev.openstreetmap.org"
csvfile = "/tmp/mapathon.csv"

pwd = raw_input('Password:>' )
#osm_handler = OsmApi(username="eternaltyro-dev", passwordfile="/tmp/osm-dev.pwd", api=api_endpoint)
osm_handler = OsmApi(username="eternaltyro-dev", password=pwd, api=api_endpoint)
changeset = osm_handler.ChangesetCreate({u"comment":u"Public-Mapathon-Upload"})
print "changeset ID: %s" % changeset
def degrees_decimal(dot_string):
    x = dot_string.split('.')
    return float(x[0]) + float(x[1])/60 + float(x[2])/3600

def get_polygon(data_list):
    '''List of tuples of co-ordinate pairs'''
    polygon_nodes = []
    for ordinate_pair in data_list:
        node_id = osm_handler.NodeCreate({"lat":ordinate_pair[0],"lon":ordinate_pair[1],"tag": {}})
        polygon_nodes.append(node_id)
    for node in polygon_nodes:
        yield node[u'id']

with open(csvfile) as csv_ptr:
    for line in csv.reader(csv_ptr):
        if line[0] == "node":
            '''"node","police","name","operator","levels","opening hours","city","street","[(80,12)]"'''
            latlong = eval(line[8])[0]
            data = { "lat":latlong[0], "lon":latlong[1], "tag": { "amenity":line[1], "name":line[2], "operator":line[3], "level":line[4], "opening_hours":line[5], "addr:city":line[6], "addr:street":line[7] } }
            node_create = osm_handler.NodeCreate(data)
            print node_create
            #print data
        elif line[0] == "way":
            node_list = [x for x in get_polygon(eval(line[8]))]
            data = { "nd": node_list, "tag": { "amenity":line[1], "name":line[2], "operator":line[3], "level":line[4], "opening    _hours":line[5], "addr:city":line[6], "addr:street":line[7] } }
            way_create = osm_handler.WayCreate(data)
            print way_create
            #print data
        else:
            print "Malformed CSV. Please fix"

osm_handler.ChangesetClose()
