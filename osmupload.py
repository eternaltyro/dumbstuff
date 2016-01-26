#!/usr/bin/env python

""" Script that uploads nodes from file

This python script reads data from a csv file and uploads the data to 
OpenStreetMap using OSM API.
"""

from osmapi import OsmApi
import csv

'''Change below to edit the live-site'''
api_endpoint = "api06.dev.openstreetmap.org"
csvfile = "/tmp/mapathon.csv"

osm_handler = OsmApi(username="eternaltyro-dev", passwordfile="/tmp/osm-dev.pwd", api=api_endpoint)
changeset = osm_handler.ChangesetCreate({u"comment":u"Public-Mapathon-Upload"})

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
        yield node

data = 

with open(csvfile) as csv_ptr:
    for line in csv.reader(csv_ptr):
        data = { "lat":line[1], "lon":line[2],
                 "tag": { "amenity":line[3],
                          "name":line[0],
                          "operator":line[4],
                          "level":line[5],
                          "opening_hours":line[6],
                          "addr:city":"Chennai",
                          "addr:street":line[6] 
                          }
                }
        if line[7] == "node":
            osm_handler.NodeCreate(data)
        elif line[7] == "way":
            osm_handler.WayCreate(data)

