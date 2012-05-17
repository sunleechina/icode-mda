import zipfile
import urllib
import sys
import re

base_address = 'http://dds.cr.usgs.gov/srtm/version2_1'

srtm_level = ['SRTM1', 'SRTM3']

srtm1_region = ['Region_01', 'Region_02', 'Region_03', 'Region_04', 'Region_05', 'Region_06', 'Region_07']
srtm3_region = ['Africa', 'Australia', 'Eurasia', 'Islands', 'North_America', 'South_America']

swbd_region = ['SWBDeast', 'SWBDwest' ]

def download_srtm_files(in_url):
    html = urllib.urlopen(in_url).read()
    pattern = re.compile('".*"')
    files = re.findall(pattern, html)
        for file in files:
            if(file[1] == 'N' or file[1] == 'S'):
                file_name = file.replace('"','')
                print file_name
                urllib.urlretrieve(in_url+'/'+ file_name , file_name )
                zfile = zipfile.ZipFile(filename)
                zfile.extractall()



def download_swbd_files(in_url):
    html = urllib.urlopen(in_url).read()
    pattern = re.compile('".*"')
    files = re.findall(pattern, html)
        for file in files:
            if(file[1] == 'e' or file[1] == 'w'):
                file_name = file.replace('"','')
                print file_name
                urllib.urlretrieve(in_url+'/'+ file_name , file_name )
                zfile = zipfile.ZipFile(file_name)
                zfile.extractall()

'''
for region in swbd_region:
	swbd_url = base_address + '/SWBD/' + region
	download_swbd_files(swbd_url)


for region in srtm1_region:
	srtm_url = base_address + '/SRTM1/' + region
	download_strm_files(srtm_url)


for region in srtm3_region:
	srtm_url = base_address + '/SRTM3/' + region
	download_strm_files(srtm_url)
''' 
