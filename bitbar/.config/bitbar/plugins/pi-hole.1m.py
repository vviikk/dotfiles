#!/usr/bin/env python
# -*- coding: utf-8 -*-
# <bitbar.title>Pi-hole status</bitbar.title>
# <bitbar.version>v3.1</bitbar.version>
# <bitbar.author>Felipe Martin</bitbar.author>
# <bitbar.author.github>fmartingr</bitbar.author.github>
# <bitbar.author>Siim Ots</bitbar.author>
# <bitbar.author.github>siimots</bitbar.author.github>
# <bitbar.desc>Show summary and manage Pi-Hole from menubar.</bitbar.desc>
# <bitbar.image>https://files.fmartingrlabs.com/github/bitbar-plugins/pihole.1m.png</bitbar.image>
# <bitbar.dependencies>pi-hole,python</bitbar.dependencies>
import json
import os

try:  # Python 3
    from urllib.request import urlopen
except ImportError:  # Python 2
    from urllib2 import urlopen  # noqa


PLUGIN_PATH = os.path.join(os.getcwd(), __file__)

# ---
# Variables
# ---

# URL to the pi-hole admin path without trailing slash
base_url = "http://192.168.0.100/admin"

# Your Pi-hole password hash (used for management)
# THIS IS NOT YOUR PIHOLE ADMIN PASSWORD
# You can find this password hash in the setupVars.conf file of your pihole
# server which is typically is found in /etc/pihole/setupVars.conf.
# Look for the PASSWORDHASH key.
password = "pi"

# Menubar icon type ('color' or 'bw')
icon_type = 'bw'

# Menubar icon
icon_bw = 'iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAAAXNSR0IArs4c6QAAAAlwSFlzAAAWJQAAFiUBSVIk8AAAActpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDUuNC4wIj4KICAgPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIKICAgICAgICAgICAgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyI+CiAgICAgICAgIDx4bXA6Q3JlYXRvclRvb2w+d3d3Lmlua3NjYXBlLm9yZzwveG1wOkNyZWF0b3JUb29sPgogICAgICAgICA8dGlmZjpPcmllbnRhdGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4KGMtVWAAAA2dJREFUWAnFlluITWEUx4dmGPdcHlA8yClK1MyTS03G0xByV5TEeCKKlAYRkoaUJ0Lz4FbkUngwNC8uDUoI5TrRFHIZzCAzZvj92auWbZ8znLPPmVW/+da3vvWtteY7a3975+W1Lz3bd8mdxwlS/YDPcArKoEOliewqyHOReaKjqqoNFWOFNWDvkNNakqQgFdYMpZBM1HtFUJDMIR27gt0FO5nw+I61QaHA3Zjvhq8g/+MQqxQTzYKHC9J8u8tWiH4VvN8ltx6buohIbaFElvSey7IuwmeBW49VXUG0qKJkGwz6eevBCtVYDVmVWUT/AD6pdPXMypD9BvP+kHUZSIZKuA/fIVycLtEq6AU5FxV3EHxRi3NehUvYGX0M+N56xVyF5lTUwFvgPfjTMf0m9u6QE1GjXgFLrvEyqLEbnP08ehfIquhW1r1jxXxD13VgkkB5CbZ+Bl2nmRXRyejJsmSv0SdEZJrjfOR7EmIvSv3g3/yfmI+FKJmJUYWcDkbp+q7Kh1ikE1H0grST8eND7AdgFSwD9VEjnIO54H2PMddTmbFUEMECP0CfDuWgYsweHieytjdifSu2jEQ/Swv4hK3Mj4DeXypM945f1ymp3z6CPl1GwnOQj+4rnVxa0pVdT0CB3sAG0Ju7BmR7Ckqs/poNq6EEJCpKPvamnxfMZXsLA+C/ZS07FEAooMk4FLNvMqMbh6E3g3yGBHb1of+J9wT2v4ZUTbbUeT9zuj7WTBKmuFGnUhDMdSdJVNy1X9rvPzOc/oeaqiDvOMpNRjj9kdNNHW4KY6HTeztd/RUpqQqqcjumOl0Xn0SfHmrusOinMRkfKP0YJ5mRcb/T/1nVf1cHOm49HWrqzcFctn2gd9VOeAxnQTd3X9DJyecFrIHrwVw2+ab9jiths05CgTyNzPWJsStkV+Fq2KFwCFrB72throciI9nIbh9U+jYohXBC86tnbT2UQx2YvQI9Y9EjexQsqEZdmLq1lXgK9IA+MB/0M3lf0w9jV6xYRJdkDVhwff9IXw5hWYjB/GzUXsWIVXQKvigl2xGRIdxX2qO9WRG9JqrB/vMm9CKXqRj9i1u/gK49WZV8ousU2kCF6bt6WoB9Y2utEuSbM5lMpttgp2XjLWxl6VaRaddrv5640UEBdxhrQcWlJT8BdaxGflEnmuwAAAAASUVORK5CYII==' # noqa
icon_color = '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//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA/+wAAP+jAAD/MgAAcQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA////AP///wD///8A////AP///wAA////AP///wD///8A////AP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALAAAf90AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD/4AAA/7gAAP/cAAD/JgAAbwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD///8A////AP///wD///8A////AAD///8A////AP///wD///8A////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADQAAHjdAAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP/oAAD/kgAA/+wAAP/bAAD/JAAAawAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wD///8A////AP///wD///8AAP///wD///8A////AP///wD///8AAAAAAAAAAAAAAAAAAAAAAAAAAAA2AAB14QAA//8AAP/6AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA/90AAP+UAAD/9gAA//8AAP/TAAD/HwAAXgAAAAADAAAAAQAAAAAAAAAAAAAA////AP///wD///8A////AP///wAA////AP///wD///8A////AP///wAAAAAAAAAAAAAAAAAAAAAADgAAbp8AAP/HAAD/mQAA/5cAAP++AAD/+QAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD/lgAA/5UAAP//AAD//wAA//8AAP/LAAD+IgAAVSAAAAAUAAAAAAAAAAAAAAD///8A////AP///wD///8A////AAD///8A////AP///wD///8A////AAAAAAAAAAAAAAAAAAgAAGyiAAD/6AAA/9UAAP/ZAAD/xQAA/3sAAP9PAAD/wwAA//8AAP//AAD//wAA//8AAP//AAD//wAA/8YAAP8/AAD/2wAA//8AAP//AAD//wAA//8AAP+9AAD6HwAATwkAAAAAAAAAAAAAAP///wD///8A////AP///wD///8AAP///wD///8A////AP///wD///8AAAAAAAAAAAAYAABcxQAA//8AAP//AAD//wAA//8AAP//AAD//wAA/44AAP8KAAD/dAAA/9sAAP//AAD//wAA//8AAP/AAAD/FQAA/5QAAP//AAD//wAA//8AAP//AAD//wAA//8AAP+oAADxBwAAPAAAAAAAAAAA////AP///wD///8A////AP///wAA////AP///wD///8A////AP///wAAAAAAAAAAG54AAOL/AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA/4YAAP8AAAD/EAAA/0IAAP9hAAD/QwAA/wAAAP9eAAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP94AADKAAAAAAAAAAD///8A////AP///wD///8A////AAD///8A////AP///wD///8A////AAAAACwuAACI7AAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD/5QAA/yAAAP8AAAD/AAAA/wAAAP8AAAD/BQAA/9cAAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA/9sAAP0NAABVAAAAC////wD///8A////AP///wD///8AAP///wD///8A////AP///wD///8AGQAAiG0AAOX/AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP/9AAD/UAAA/wAAAP8AAAD/AAAA/wAAAP9IAAD/+QAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD/+gAA/0oAAM0DAABu////AP///wD///8A////AP///wACAAAAAAAAAAAAAAAAAAAAAAAAAAAJAAALCAAABwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPwAAAD4AAAAAAAAAAAAAAAAAAAAAAAAAB0AAAAGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFAAAAEwAAIQcAACcAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAOAAALXPAAC++AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA5wAAAM4AAAAAAAAAAAAAAAAAAAAAAAAA8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPUAAADiAADI9gAAwwAAAAAAAAAAAAAAAAAAAAAAAAAAAP///wD///8A////AP///wD///8AAAAAAAIAADvSAADz/wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP+YAAD/AAAA/wgAAP8VAAD/CAAA/wAAAP8MAAD/2wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD/0gAA8wEAADsAAAAA////AP///wD///8A////AP///wAA////AP///wD///8A////AP///wAAAAAAAAAAAEkAAKH8AAD//wAA//8AAP//AAD//wAA//8AAP//AAD/1gAA/w8AAP9ZAAD/vQAA/9oAAP++AAD/gAAA/xAAAP87AAD/9AAA//8AAP//AAD//wAA//8AAP//AAD//wAA//wAAP9IAACeAAAAAAAAAAD///8A////AP///wD///8A////AAD///8A////AP///wD///8A////AAAAAAAAAAAAAAAAEnMAAL//AAD//wAA//8AAP//AAD//wAA//8AAP9JAAD/eAAA//8AAP//AAD//wAA//8AAP//AAD/5QAA/2AAAP9eAAD/1AAA//8AAP//AAD//wAA//8AAP/sAAD/VQAAugAAAA4AAAAAAAAAAP///wD///8A////AP///wD///8AAP///wD///8A////AP///wD///8AAAAAAAAAAAAAAAAAAAAAE3UAAMb/AAD//wAA//8AAP//AAD/oAAA/1kAAP/2AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA/78AAP+IAAD/mgAA/64AAP/GAAD/zAAA/zgAAMIAAAAPAAAAAAAAAAAAAAAA////AP///wD///8A////AP///wAA////AP///wD///8A////AP///wAAAAAAAAAAAAYAAAANAAAAAAAAF3cAAM//AAD//wAA//8AAP9/AAD/xwAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//gAAP/SAAD/xAAA//AAAP9kAADLAAAAFQAAAAAAAAAAAAAAAAAAAAD///8A////AP///wD///8A////AAD///8A////AP///wD///8A////AAAAAAAAAAAABAAAABUAAAAVAAAAAAAAHHIAAMr/AAD/4AAA/44AAP/rAAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD/gAAAygkAABsJAAAAAAAAAAAAAAAAAAAAAAAAAP///wD///8A////AP///wD///8AAP///wD///8A////AP///wD///8AAAAAAAAAAAAEAAAAFAAAABYAAAATAAAAAAAAHIAAAMLzAAD/mAAA/+oAAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA/3cAAMYAAAAeHgAAAAkAAAAAAAAAAAAAAAAAAAAAAAAA////AP///wD///8A////AP///wAA////AP///wD///8A////AP///wAAAAAAAAAAAAQAAAAUAAAAFgAAABUAAAAMAAAAAQAAFHMAAMfFAAD/9QAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP9+AADNAAAAGREAAAAgAAAACQAAAAAAAAAAAAAAAAAAAAAAAAD///8A////AP///wD///8A////AAD///8A////AP///wD///8A////AAAAAAAAAAAABAAAABQAAAAWAAAAFAAAABQAAAANAAAADQAAF0QAAM/oAAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA//8AAP//AAD/hwAA2wMAAB0SAAAAGgAAACAAAAAJAAAAAAAAAAAAAAAAAAAAAAAAAP///wD///8A////AP///wD///8AAP///wD///8A////AP///wD///8AAAAAAAAAAAAEAAAAFAAAABYAAAAUAAAAEgAAABUAAAAiAAAAAAAAHV4AAMv/AAD//wAA//8AAP//AAD//wAA//8AAP//AAD//wAA/4cAANsMAAAnHgAAABkAAAAYAAAAIAAAAAkAAAAAAAAAAAAAAAAAAAAAAAAA////AP///wD///8A////AP///wAA////AP///wD///8A////AP///wAAAAAAAAAAAAQAAAAUAAAAFgAAABQAAAASAAAAFQAAACQAAAAKAAAAAAAAHGsAALz2AAD//wAA//8AAP//AAD//wAA//IAAP9tAAC/DAAAJyQAAAAfAAAAGQAAABgAAAAgAAAACQAAAAAAAAAAAAAAAAAAAAAAAAD///8A////AP///wD///8A////AAH///8AAAAAAAAAAAAAAAAAAAAAAAEBAQAAAAAABAAAABAAAAACAAAA/gAAAP4AAAADAAAADwAAAOcAAAD+AAAA9wAABioAAGtgAABeOQAAHPsAAP/BAADepQAAoNwAAJ4jAAD6AwAAAPkAAAD6AAAA/wAAAAgAAADpAAAA9wAAAAAAAAAAAAAAAAAAAP///wAAAAAAAAAAAAAAAAAAAAAAAQAA//8wabirP4J+hgAAAABJRU5ErkJggg==' # noqa

# Url to check the service status
url_status = "%s/api.php?status&auth=%s" % (base_url, password)

# Url to get the summary
url_summary = "%s/api.php?summary" % base_url

# Urls to enable/disable service
url_enable = "%s/api.php?enable&auth=%s" % (base_url, password)
url_disable = "%s/api.php?disable&auth=%s" % (base_url, password)


# ---
# Helper methods
# ---
def convert_to_native(data):
    return json.loads(data)


def do_request(url, method='GET'):
    response = urlopen(url)
    return convert_to_native(response.read())


def get_summary():
    response = do_request(url_summary)
    return response


def get_status():
    response = do_request(url_status)
    return response['status']


def separator():
    print('---')


# Data
summary = get_summary()
status = get_status()
enabled = status == 'enabled'


# Layout
def bitbar():
    # Menubar icon
    print('| templateImage=%s' % globals()['icon_%s' % icon_type])
    separator()

    print("Open pi-hole admin | href=%s" % base_url)
    separator()

    print('Status: %s' % status)
    if enabled:
        print('Disable Pi-hole | href=%s' % url_disable)
    else:
        print('Enable Pi-hole | href=%s' % url_enable)

    separator()
    print("Domains being locked: %s" % summary['domains_being_blocked'])
    print("Ads blocked today: %s (%s%%)" % (summary['ads_blocked_today'],
                                            summary['ads_percentage_today']))
    print("DNS queries today: %s" % summary['dns_queries_today'])
    print("Queries cached today: %s" % summary['queries_cached'])
    print("Queries forwarded today: %s" % summary['queries_forwarded'])
    print("Unique domains today: %s" % summary['unique_domains'])
    separator()


# Execution
try:
    bitbar()
except Exception as e:
    print('Script error:')
    print(e)
    separator()
