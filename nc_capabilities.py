from ncclient import manager
import os


m = manager.connect(host='dc1nwlc9800', port=830, username='srv-napalm', \
    password=os.getenv("NAPALM_PW"), device_params={'name': 'iosxe'})

# for item in m.client_capabilities:
#     print(item)

# for item in m.server_capabilities:
#     print(item)

SCHEMA = m.get_schema('Cisco-IOS-XE-wireless-ap-cfg')
print(SCHEMA)

# config = m.get_config("running")
m.close_session()
# print(config)