import json


def get_device_profile_by_hwid(deviceKey):
    f = open('config/devices/config.json')
    devices_data_conf = json.load(f)
    for x in devices_data_conf:
        for key, value in x.items():
            if key == deviceKey:
                status_devices = value
    f.close()
    return status_devices

# f = open('config.json')
deviceKey = "000EC60131F000A1"
# devices_data_conf = json.load(f)
# for x in devices_data_conf:
#     for key, value in x.items():
#         if key == deviceKey:
#             status_devices = value
# print(status_devices['TYPE'])
# f.close()

print(get_device_profile_by_hwid(deviceKey))
