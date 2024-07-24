import requests

URI = "https://www.duckduckgo.com"

def heartbeat(event, context):
    r = requests.get(URI)
    return None
