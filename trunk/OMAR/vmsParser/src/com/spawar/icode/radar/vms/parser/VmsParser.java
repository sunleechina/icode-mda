package com.spawar.icode.radar.vms.parser;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Vector;

/**
 * VMSParser
 * 
 * Description: Parser for files containing VMS vessel tracking messages. A
 * typical VMS message looks like:
 * 
 * //SR//AD/SEY//FR/SYC//TM/POS//NA/FAITH SZ
 * 1146//DA/111108//TI/2144//LA/S0428//LO/E05501//SP/2//CO/351//FS/SEY//ER
 * 
 **/
public class VmsParser {

	static final Integer MAX_SEN_LEN = 1024;
	static final boolean DEBUG = false;
	
	String[] m_parsedSentence;
	String m_fullSentence;
	File m_file = null;
	FileReader m_fileReader = null;
	String delims = "//";
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMdd");
	String m_strFileName="";
	FileInputStream m_fstream = null;


	/**
	 * Constructor
	 * 
	 * Takes in the File name/location as a string value
	 * @throws FileNotFoundException 
	 * 
	 */
	public VmsParser(String strFileName) throws FileNotFoundException {
		
		m_strFileName = strFileName;
		m_fstream = new FileInputStream(m_file);

	}
	
	/**
	 * Constructor
	 * 
	 * Takes in the File descriptor as a File Object
	 * @throws FileNotFoundException 
	 * 
	 */
	public VmsParser(File newFile) throws FileNotFoundException {
		
		m_file = newFile;
		m_fstream = new FileInputStream(m_file);

	}
	
	/**
	 * Constructor
	 * 
	 * Takes in the File descriptor as a File Object
	 * 
	 */
	private VmsParser(FileReader newFile) {
		
		//m_fileReader = newFile;
		//m_fstream = new FileReaderInputStream(m_fileReader.);

	}
	
	
	

	/**
	 * ParseFile
	 * 
	 * 	Given a VMS data file with one or more entries per line, will return a VmsData Object
	 * 
	 * @param newFile
	 * @return Vector of VmsData Objects
	 * @throws Exception
	 * @throws IOException
	 */
	private Vector<VmsData> parseFile() throws Exception, IOException {
		
		m_parsedSentence = new String[16];
		Vector<VmsData> vmsVector = new Vector<VmsData>();

		try {

			//FileInputStream fstream = new FileInputStream(m_file);
			

			// Get the object of DataInputStream
			DataInputStream in = new DataInputStream(m_fstream);
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			String strLine;

			// Read File Line By Line
			while ((strLine = br.readLine()) != null) {

				if (strLine.length() < 1)
					continue;

				// Print the content on the console
				if(DEBUG)System.out.println("MSG: " + strLine);
				m_fullSentence = new String(strLine);

				// Parse string
				String[] tokens = strLine.split(delims);
				m_parsedSentence = new String[tokens.length];
				System.arraycopy(tokens, 0, m_parsedSentence, 0, tokens.length);

				if (isMessageValid()) {

					VmsData data = decodeVMSMessage(tokens);
					vmsVector.add(data);
					
				}
			}
		}// try
		catch (IOException ex2) {
			System.out.println("ERROR(11): Problem Parsing  file.");
			System.out.println(ex2.getMessage());
			throw (ex2);
		} catch (Exception ex3) {
			System.out.println("ERROR(12): Problem Parsing  file.");
			System.out.println(ex3.getMessage());
			throw ex3;
		}

		return vmsVector;
	}

	static void usage() {
		System.out.println("\n  Usage: java -jar VmsParser <input-filename> \n\n");

	}

	
	
	/**
	 * Given an array of strings of VMS encoded data, returns a VmsData Object
	 * 
	 * @param tokens
	 * @return VmsData Object
	 */
	private VmsData decodeVMSMessage(String[] tokens) {
		VmsData data = new VmsData();
		for (int i = 0; i < tokens.length; i++) {
			if(DEBUG)System.out.println("Full : " + tokens[i]);

			if (tokens[i].isEmpty())
				continue;
			if (tokens[i].equalsIgnoreCase("SR"))
				continue;
			if (tokens[i].equalsIgnoreCase("ER"))
				continue;
			else {

				String[] kvp = tokens[i].split("/");
				String key = kvp[0];
				String value = kvp[1];

				if (key.equalsIgnoreCase("AD")) // Destination
				{
					data.setDESTINATION(value);
					continue;
				}
				if (key.equalsIgnoreCase("FR")) // Country
												// code
				{
					data.setCOUNTRY(value);
					continue;
				}
				if (key.equalsIgnoreCase("TM")) // Message
												// type
				{
					data.setMESSAGETYPE(value);
					continue;
				}
				if (key.equalsIgnoreCase("NA")) // Vessel
												// name
				{
					data.setVESSELNAME(value);
					continue;
				}
				if (key.equalsIgnoreCase("IR")) // Registration
				{
					data.setREGISTRATION(value);
					continue;
				}
				if (key.equalsIgnoreCase("RC")) // Call
												// sign
				{
					data.setCALLSIGN(value);
					continue;
				}
				if (key.equalsIgnoreCase("DA")) // Date
				{
					try {
						String strDate = value;
						Date date = (Date) dateFormat.parse(strDate);
						data.setDATE(date);
					} catch (Exception ex) {
						System.err.println(ex.getMessage());
					}

					continue;

				}
				if (key.equalsIgnoreCase("TI")) // Time
				{
					String strTime = value;
					Integer dTime = Integer.parseInt(strTime);
					data.setTIME(dTime);

					// Add it to Date object, just in case
					if (data.getDATE() != null) {

						Date date = data.getDATE();
						Calendar cal = Calendar.getInstance();
						cal.setTime(date);
						String strHours = strTime.substring(0, 2);
						String strMins = strTime.substring(2, 4);
						cal.set(Calendar.HOUR_OF_DAY,
								Integer.parseInt(strHours));
						cal.set(Calendar.MINUTE, Integer.parseInt(strMins));
						date = cal.getTime();
					}

					continue;
				}
				if (key.equalsIgnoreCase("LA")) // Latitude
				{
					double lat, lat_deg, lat_min;
					String strLatDeg = value.substring(1, 3);
					lat_deg = Double.parseDouble(strLatDeg);
					String strLatMin = value.substring(3, 5);
					lat_min = Double.parseDouble(strLatMin);

					lat = lat_deg + lat_min / 60;

					if (value.substring(0, 1).equalsIgnoreCase("S"))
						;
					lat = -lat;

					data.setLAT(lat);

					continue;
				}
				if (key.equalsIgnoreCase("LO")) // Longitude
				{
					double lon, lon_deg, lon_min;
					String strLonDeg = value.substring(1, 4);
					lon_deg = Double.parseDouble(strLonDeg);
					String strLonMin = value.substring(4, 6);
					lon_min = Double.parseDouble(strLonMin);

					lon = lon_deg + (lon_min / 60);

					if (value.substring(0, 1).equalsIgnoreCase("W"))
						lon = -lon;

					data.setLON(lon);

					continue;
				}
				if (key.equalsIgnoreCase("SP")) // Speed
				{
					String strSpeed = value;
					data.setSPEED(Double.parseDouble(strSpeed));
					continue;
				}
				if (key.equalsIgnoreCase("CO")) // Course
				{
					String strCourse = value;
					data.setCOURSE(Integer.parseInt(strCourse));
					continue;
				}
				if (key.equalsIgnoreCase("FS")) // Flag
												// state
				{
					String strFlag = value;
					data.setFLAG(strFlag);
					continue;
				}

			}// KLV

		}// Tokens

		return data;
	}

	
	/**
	 * Checks if the message is valid
	 * 
	 * @return boolean
	 */
	boolean isMessageValid() {
		if (m_fullSentence.length() > MAX_SEN_LEN
				|| m_fullSentence.length() < 1) {
			System.out.println("Invalid Message. Message longer than "
					+ MAX_SEN_LEN + " characters.");
			return false;
		}

		// do checksums and other validation here, none known for now
		if (!m_parsedSentence[1].equalsIgnoreCase("SR")) {
			System.out.println("Invalid start of sentence (no SR)");
			return false;
		}
		if (!m_parsedSentence[m_parsedSentence.length - 1]
				.equalsIgnoreCase("ER")) {
			System.out.println("Invalid end of sentence (no ER)");
			return false;
		}
		return true;
	}

	/**
	 * Main program
	 * 	Can be used as an example of how to use the API
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		
		if(args.length !=1){
			usage();
			
		}

		//String testFile = "./sample/vmsData.txt";
		String testFile = args[0];

		File newFile = new File(testFile);

		// FileInputStream fstream = new FileInputStream(testFile);

		Vector<VmsData> dataVector = new Vector<VmsData>();

		try {
			VmsParser parser = new VmsParser(newFile);
			dataVector = parser.parseFile();
		} catch (IOException ex) {

		} catch (Exception ex) {

		}
		
		System.out.println("Everything seems to be working.");

	}

}
