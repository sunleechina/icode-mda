###############################################################Libraries
import os
import csv
import time 
import xlrd
import pylab as pl
import numpy as np
import datetime as dt

#############################################################Definitions

############################################################Repositories

class ICODE_RP:
	#-------------------------------------------------------------------
	def __init__(self):
		self.data = []
	
	#-------------------------------------------------------------------
	def time2unix(self, strdate, formdate):
		"""
		Description:
			Function to convert a date string into UNIX stamp.
		Sintax:
			time2unix(strdate, formdate)
		Parameters:
			- strdate: the date string.
			- formdate: the format of the date string.
		Example:
			time2unix('2014-03-25 12:34:06.0', '%Y-%m-%d %H:%M:%S.0')
			
			This function returns: 1395761646.0
		"""
		return time.mktime(dt.datetime.strptime(strdate,formdate).timetuple())

	#------------------------------------------------------------------- 
	def unix2time(self, flounix, formdate):
		"""
		Description:
			Function to convert a UNIX stamp into time.
		Sintax:
			unix2time(flounix, formdate)
		Parameters:
			- strdate: the UNIX stamp.
			- formdate: the format of the date result.
		Example:
			unix2time(1395761646.0, '%Y-%m-%d %H:%M:%S.0')
			
			This function returns: '2014-03-25 12:34:06.0'
		"""
		return dt.datetime.fromtimestamp(flounix).strftime(formdate)
		
	#-------------------------------------------------------------------	
	def fname(self, fnam):
		"""
		Description:
			Function to obtain the name of a file.
		Sintax:
			fname(fnam)
		Parameters:
			- fnam: the file path.
		Example:
			fname('xls_files/example.xls')
			
			This function returns: 'example'
		"""
		x = os.path.splitext(os.path.basename(fnam))
		return x[0]
		
	#-------------------------------------------------------------------
	def foldrv(self, folder):
		"""
		Description:
			Function to give format to a folder and create if necessary.
			This program is usefull to save files.
		Sintax:
			foldrv(folder, sv = 1)
		Parameters:
			- folder: the name of the folder.
			- sv: 1: save mode, 0: read mode
		Example:
			foldrv('example', )
			
			If the folder doesn't exists, the function creates it, 
			besides, the function return is 'example/'
	
		"""
		if folder[len(folder)-1] != '/':
			folder += '/'
		try:
			os.stat(folder)
		except:
			os.mkdir(folder)
		return folder
		
	#-------------------------------------------------------------------
	def AIS2list(self, xfiles):
		"""
		Description:
			Function to retrieve a list from an excel or text file. Note 
			that each row in the excel file is a row in the list. this is
			usefull to give format to data or upload it into a database.
		Sintax:
			AIS2list(xfiles)
		Parameters:
			- xfiles: the location and name of the file.
		Example:
			
			xfile('xls_files/test1.xls') 	
		"""
		count = 0
		try:
			xfile = xlrd.open_workbook(xfiles)			#open the file
			for i in range(len(xfile.sheet_names())):	#for each sheet
				aux = xfile.sheet_by_index(i)			#save the values into a list
				if not(count):
					out = aux._cell_values[:][:]			
					count = 1
				else:
					out += aux._cell_values[:][:]
		except:
			xfile = open(xfiles, 'r')
			xfile = csv.reader(xfile, delimiter = ',')
			out = []
			for row in xfile:
				out.append(row)
		return out
				
	#-------------------------------------------------------------------
	def AISfilter(self, data, dform = None):
		"""
		Description:
			function for give format to an AIS list with the next 
			parameters:
				MMSI, RecvTime, LocalRecvTime, NavigationalStatus, ROT, 
				SOG, COG, TrueHeading, PositionAccuracy, Longitude, 
				Latitude and CRC
		Sintax:
			AISfilter(data, dform = None)
		Parameters:
			- data: A list with the AIS data.
			- dform: The format of the date string. 
		Example:
			AISfilter(data, dform = '%Y-%m-%d %H:%M:%S.0')
			
			This funtion will return a numpy array with all the data as
			floats. The function deletes all the rows that have a format
			error as an invalid navigation status, latitude or longitude,
			etc. 
		"""
		if isinstance(data,list):
			try:
				a = int(data[0][1])
			except:
				data = data[1:][:]
			if dform:
				for i in range(0,len(data)):
					data[i][1:3] = [self.time2unix(data[i][1],dform),self.time2unix(data[i][2],dform)]
			try:
				data = np.array(data, dtype = float)
			except:
				print '*** Error: dform (date format) is missing, cannot convert the data ***'
			#--------------------------------------------------------find errors
			nst = pl.find((data[:,4]<-1)|(data[:,4]>15))
			trh = pl.find((data[:,8]<0)|(data[:,8]>359)&(data[:,8]!=511))
			lon = pl.find(abs(data[:,10])>=180)
			lat = pl.find(abs(data[:,11])>=180)
			tot = np.unique(np.hstack((nst, trh, lon, lat)))				
			#--------------------------------------------------delete the errors
			for i in range(len(tot)):					
				data = np.delete(data, tot[:], axis = 0) 
			return data
		else:
			print '*** Error: The input must be a list ***'
				   
	#-------------------------------------------------------------------
	def dat2text(self, data, name, folder = None):
		"""
		Description:
			function for save a list or numpy array into a file. If the
			folder doesn't exists, the function will create it.
		Sintax:
			dat2text(data, name, folder = None)
		Parameters:
			- data: A list or numpy array.
			- name: The name of the output file.
			- folder: The place to save the file. 
		Example:
			dat2text(data, 'example', folder = 'tests')
			
			This funtion will save the data in 'tests/' folder with the
			name 'example.csv' if it's a list or 'example.npy' if it's a
			numpy array 
		"""
		if folder:
			name = self.foldrv(folder) + name
		if isinstance(data,list):
			xfil = open(name + '.csv', "wb")
			writ = csv.writer(xfil, delimiter = '\t', quoting = csv.QUOTE_NONE)
			for row in outdata:
				writ.writerow(row)
			xfil.close()
		else:
			np.save(name, data)
	
	#-------------------------------------------------------------------
	def unrows(self, data):
		"""
		Description:
			function that finds unique rows of a numpy array. created
			by Joe Kington
		Sintax:
			unrows(data)
		Parameters:
			- data: A numpy array. 
		Example:
			unrows(data)
			
			This function returns a numpy array with the unique rows.
		"""
		uniq = np.unique(data.view(data.dtype.descr * data.shape[1]))
		return uniq.view(data.dtype).reshape(-1,data.shape[1])
			
	#-------------------------------------------------------------------
	def histfromfile(self, filename, ndy = 1):
		xfile = file(filename, 'rb')
		finfo = np.load(xfile)
		if ndy > finfo[1]+1:
			print 'Number of days stored exceeded, try with a lower ndy'
			xfile.close()
			return finfo, None
		elif ndy == 0:
			print 'ndy has to be greater than 0'
			xfile.close()
			return finfo, None
		else:
			for i in range(ndy):
				out = np.load(xfile)
			xfile.close()
			return finfo, out
	
	#-------------------------------------------------------------------
	def histplot(self, hist):
		temp = np.ma.masked_where(hist == 0,hist)
		pl.imshow(temp)
		pl.show()
			
		
		
		
