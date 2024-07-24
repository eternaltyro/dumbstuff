#!/usr/bin/env python
"""
Send alerts when a URL path is down to lambstatus
"""

import json
import os
import urllib3

TARGETS = [
    {
        "name": "Moodle",
        "uri": "http://sub1.example.org/",
        "component_id": "JHv8gQiZeRHC",
    },
    {
        "name": "Mumble",
        "uri": "http://sub2.example.org/mumble/1",
        "component_id": "VtIEmgYILfHc",
    },
]
API_EP = "https://status-admin.example.org/api/v0"
HEADERS = {"x-api-key": os.environ["API_KEY"]}
http = urllib3.PoolManager()


def lambda_handler(event, context):
    """Iterate through TARGETS and update status

    Args: Lambda args event, context
    Raises: Exception if URL is not reachable
    Returns: None
    """
    for t in TARGETS:
        try:
            r = http.request("HEAD", t["uri"])
            if r.status >= 400:
                update_status(t["component_id"], "Major Outage")
            else:
                update_status(t["component_id"], "Operational")
        except Exception as e:
            raise (e)


def get_components():
    """Get available components

    Args: None
    Raises: None
    Returns: (dict) all components
    """
    r = http.request("GET", API_EP + "/components", headers=HEADERS)
    return json.loads(r.data.decode("utf-8"))


def get_status(component_id):
    """Get status of one component

    Args: (str) Component ID
    Raises: None
    Returns: (str) Status of component <component_id>
    """
    data = [x for x in get_components() if x["componentID"] == component_id][0]
    return data["status"]


def update_status(component_id, status_string):
    """Update status of component

    Args: (str) component_id
          (str) status_string (enum per. Lambstatus)
    Raises: None
    Returns: None
    """
    body = json.dumps({"status": status_string}).encode("utf-8")
    if not get_status(component_id) == status_string:
        r = http.request(
            "PATCH", API_EP + f"/components/{component_id}", body=body, headers=HEADERS
        )
    return None


def send_slack_alerts():
    """Stub for Slack alerting
    """
    pass


# lambda_handler(None, None)
