# This script retrieves entire interface configuration from a network element via RESTCONF

# import the requests library
import requests
import json
import os

# disable warnings from SSL/TLS certificates
requests.packages.urllib3.disable_warnings()

# use the IP address or hostname
HOST = 'dc1nwlc9800'

# use your user credentials
USER = 'srv-napalm'
PASS = os.getenv("NAPALM_PW")

headers = {'Content-Type': 'application/yang-data+json',
           'Accept': 'application/yang-data+json'}

url = "https://{h}/restconf/data/ietf-interfaces:interfaces".format(h=HOST)
response = requests.get(url, auth=(USER, PASS), headers=headers, verify=False)
capabilities = json.loads(response.text)
print(capabilities)
print(capabilities.keys())
print(capabilities['ietf-interfaces:interfaces']['interface'])

for iface in capabilities['ietf-interfaces:interfaces']['interface']:
    print(iface)
