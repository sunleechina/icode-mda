#ifndef AisPostgreSqlDatabaseWriter_h
#define AisPostgreSqlDatabaseWriter_h

#include <exception>
#include <stdexcept>
#include <iostream>
#include <string>
#include <sstream>
#include <time.h>

#include <pqxx/pqxx>

using namespace std;
using namespace pqxx;

#include <AisMessage.h>
#include <AisWriter.h>

#include <boost/lexical_cast.hpp>
#include <boost/algorithm/string.hpp>

#define STATIC_MAX_ITER 10
#define CHANGE_MAX_ITER 10

/**
Class for writing AIS messages to an PostgreSql database.
Declare...check isReady()...writeEntry
*/
class AisPostgreSqlDatabaseWriter : public AisWriter{
public:
	AisPostgreSqlDatabaseWriter(std::string username, std::string password, std::string hostname, std::string databaseName, std::string staticTableName, std::string dynamicTableName, int iterations = 100000):
	m_con(static_cast<pqxx::connection*>(0)),
		m_username(username),
		m_password(password),
		m_hostname(hostname),
		m_databaseName(databaseName),
		m_staticTableName(staticTableName),
		m_dynamicTableName(dynamicTableName),
		m_targetTableName("Target_Location"),
		m_changeTableName("ais_change"),
		m_staticMaxIterations(STATIC_MAX_ITER),		//add static messages quicker than dynamic so dynamic has a 'real' static message to link to instead of dummy
		m_dynamicMaxIterations(iterations),
		m_changeMaxIterations(CHANGE_MAX_ITER),		//changes don't happen as often as dynamic, so can update more often
		m_staticIteration(1),
		m_dynamicIteration(1),
		m_changeIteration(1),
		m_targetIteration(1),
		m_staticSQLStatement(""),
		m_dynamicSQLStatement(""),
		m_changeSQLStatement(""),
		m_targetSQLStatement("")
	{
		m_initialized = init();
	}

	~AisPostgreSqlDatabaseWriter()
	{
		aisDebug("AisPostgreSqlDatabaseWriter Destructor");
		if(m_initialized)
		{
			//Finish executing static messages, if any left
			try
			{
				aisDebug("trying to execute update any remaining static entries");

				if(m_staticSQLStatement != "")
				{
					//execute statement to add any remainign
					//aisDebug("executing multirow insert start");
					StatementExecutor statementExecutor(m_staticSQLStatement);
					m_con->perform(statementExecutor);
					m_staticSQLStatement = string("");
					//aisDebug("executing multirow insert end");
					//m_sqlPreparedStatement->executeUpdate();
				}
			}
			catch(const exception &e)
			{
				cerr << "Error on Iteration: " << m_staticIteration << endl;
				cerr << "Error : " << e.what() << endl;
			}

			//Finish executing dynamic messages, if any left
			try
			{
				aisDebug("trying to execute update any remaining dynamic entries");

				if(m_dynamicSQLStatement != "")
				{
					//execute statement to add any remainign
					//aisDebug("executing multirow insert start");
					StatementExecutor statementExecutor(m_dynamicSQLStatement);
					m_con->perform(statementExecutor);
					m_dynamicSQLStatement = string("");
					//aisDebug("executing multirow insert end");
					//m_sqlPreparedStatement->executeUpdate();
				}
			}
			catch(const exception &e)
			{
				cerr << "Error on Iteration: " << m_dynamicIteration << endl;
				cerr << "Error : " << e.what() << endl;
			}

			//Finish executing target location messages, if any left
			try
			{
				aisDebug("trying to execute update any remaining target location entries");

				if(m_targetSQLStatement != "")
				{
					//execute statement to add any remainig
					//aisDebug("executing multirow insert start");
					StatementExecutor statementExecutor(m_targetSQLStatement);
					m_con->perform(statementExecutor);
					m_targetSQLStatement = string("");
					//aisDebug("executing multirow insert end");
					//m_sqlPreparedStatement->executeUpdate();
				}
			}
			catch(const exception &e)
			{
				cerr << "Error on Iteration: " << m_targetIteration << endl;
				cerr << "Error : " << e.what() << endl;
			}

			//Finish executing changed table messages, if any left
			try
			{
				aisDebug("trying to execute update any remaining change table entries");

				if(m_changeSQLStatement != "")
				{
					//execute statement to add any remainign
					//aisDebug("executing multirow insert start");
					StatementExecutor statementExecutor(m_changeSQLStatement);
					m_con->perform(statementExecutor);
					m_changeSQLStatement = string("");
					//aisDebug("executing multirow insert end");
					//m_sqlPreparedStatement->executeUpdate();
				}
			}
			catch(const exception &e)
			{
				cerr << "Error on Iteration: " << m_changeIteration << endl;
				cerr << "Error : " << e.what() << endl;
			}

			disconnectFromDatabase();
		}
	}

	void disconnectFromDatabase()
	{
		cerr << "Disconnecting from database..." << endl;
		//Terminate Database connection
		try
		{
			m_con->disconnect();
		}
		catch(const exception &e)
		{
			cerr << "Error while freeing resources : " << e.what() << endl;
		}
		cerr << "Disconnected from database"<<endl;
	}

	void setNumberOfFields(int numFields)
	{
	
	}
	
	std::string sanitize(const std::string& in)
	{
		return m_con->esc(in);
	}

	//Main writeEntry function
	bool writeEntry(const AisMessage& message)
	{
		int message_type = message.getMESSAGETYPE();
		if (message_type == 5 || message_type == 24)	//Static message
		{
			return writeStaticEntry(message);
		}
		else if (message_type == 1 || message_type == 2 || message_type == 3 || message_type == 4 || message_type == 18 || message_type == 19) //Dynamic message with location
		{	
			//Skip dynamic entries with invalid lat/lon ranges: [-180,180] for lat, [-90,90] for lon.
			if (message.getLON() > 180 || message.getLON() < -180 || message.getLAT() > 90 || message.getLAT() < -90)
			{
				aisDebug("Skipping message with invalid lat/lon range: [" << message.getLAT() << ", " << message.getLON() 
							<< "]" << " by MMSI " << boost::lexical_cast<std::string>(message.getMMSI()));
				return false;
			}

			//Call write dynamic entry first, then call write target entry.  
			//This order is important for PostgreSQL to create the dependent static entry before write target is called.
			return (writeDynamicEntry(message) && writeTargetEntry(message));
		}
		else if (message_type == 9)		//Standard SAR Aircraft Position Report message
		{
			return false; //ignore this type of message for now.
		}
		else if (message_type == 12)	//Addressed Safety-Related Message
		{
			return false; //ignore this type of message for now.
		}
		else if (message_type == 14)	//Safety-Related Broadcast Message
		{
			return false; //ignore this type of message for now.
		}
		else if (message_type == -1)
		{
			return false; //ignore this type of message for now.
		}
		else
		{
			aisDebug("Message type " << message_type << " not handled");
			return false;
		}
	}

	bool isReady()
	{
		return m_initialized;
	}

private:

	bool init()
	{
		aisDebug("Initializing database");
		try
		{
			std::string connection_string = "user=" + m_username + " password=" + m_password + " dbname=" + m_databaseName + " hostaddr=" + m_hostname;
			m_con = std::shared_ptr<pqxx::connection>(new pqxx::connection(connection_string));
			
			if(!m_con)
			{
				throw std::runtime_error("Could not create PostgreSql connection");
			}
			
			/*
			try
			{
				//m_con->prepare("insert_message", "INSERT INTO " + m_tableName + " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
				
				
				//m_sqlPreparedStatement = m_con->prepareStatement("INSERT INTO " + m_tableName + " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
				//if(!m_sqlPreparedStatement){
				//	throw std::runtime_error("Could not create Mysql sql statement");
				//}
				//aisDebug("Query prepared successfully...");
			}
			catch (const exception &e)
			{      
				std::cerr << "Statement Creation Error : " << e.what() << std::endl;
				return false;
			}
			*/
		}
		catch (std::exception &e) 
		{
			std::cerr << "Exception: " << e.what() << std::endl;
			return false;
		}

		aisDebug("Database initialized successfully");
		return true;

	}

	/**
	 Write dynamic entry 
	 */
	bool writeDynamicEntry(const AisMessage& message)
	{
		try
		{	
			if(m_dynamicIteration == 1 || m_dynamicMaxIterations <= 0)
			{
				m_dynamicSQLStatement = "INSERT INTO " + m_dynamicTableName + " VALUES(DEFAULT, ";
			}
			else
			{
				m_dynamicSQLStatement+= ", (DEFAULT, ";
			}
			m_dynamicSQLStatement +=
					boost::lexical_cast<std::string>(message.getMESSAGETYPE()) + ", " +
					boost::lexical_cast<std::string>(message.getMMSI()) + ", " +
					boost::lexical_cast<std::string>(message.getNAVSTATUS()) + ", " + 
					boost::lexical_cast<std::string>(message.getROT()) + ", " + 
					boost::lexical_cast<std::string>(message.getSOG()) + ", " +
					boost::lexical_cast<std::string>(message.getPOSACCURACY()) + ", " +
					boost::lexical_cast<std::string>(message.getCOG()) + ", " +
					boost::lexical_cast<std::string>(message.getTRUE_HEADING()) + ", " +
					"to_timestamp(" + boost::lexical_cast<std::string>(message.getDATETIME()) + "), " +
					"'" + sanitize(boost::lexical_cast<std::string>(message.getSTREAMID()))+ "')";
					
			if(m_dynamicIteration++ == m_dynamicMaxIterations || m_dynamicMaxIterations <= 0)
			{
				m_dynamicIteration = 1;

				StatementExecutor statementExecutor(m_dynamicSQLStatement);
				m_con->perform(statementExecutor);
				m_dynamicSQLStatement = string("");
			}
			return true;
		}
		catch(const exception &e)
		{
			cerr << "Error on Iteration: " << m_dynamicIteration << endl;
			cerr << "PostgreSQL Error : " << e.what() << endl;
			cerr << m_dynamicSQLStatement << endl << endl;
			return false;
		}
	}

	/**
	 Write static entry
	 */
	bool writeStaticEntry(const AisMessage& message)
	{
		string mmsi, imo, callsign, vesselname, unique_ID;

		//Generate unique ID using the 4 fields
		mmsi = boost::lexical_cast<std::string>(message.getMMSI());
		imo = boost::lexical_cast<std::string>(message.getIMO());;
		callsign = boost::lexical_cast<std::string>(message.getCALLSIGN());
		vesselname = boost::lexical_cast<std::string>(message.getVESSELNAME());	//use sanitize function to prevent escape characters in string
		unique_ID = genUniqueID(mmsi, imo, callsign, vesselname);

		//TESTING SPEED FOR SIMPLY PUSHING ALL STATIC AS NEW ROWS
		return addNewStaticEntry(message, mmsi, imo, callsign, vesselname, unique_ID);

		/*
		//Check if current unique ID exists in the table already
		string m_query = "SELECT ais_static_id, extract(epoch from latest_timestamp) as latest_timestamp,";
		m_query +=	"message_type, mmsi, imo, callsign, vessel_name, vessel_type, antenna_position_bow, ";
		m_query += "antenna_position_stern, antenna_position_port, antenna_position_starboard, length, width, draught, ";
		m_query += "destination, extract(epoch from eta) as eta, epfd FROM " + m_staticTableName + " WHERE UNIQUE_ID = '" + sanitize(unique_ID) + "'";

		//Try connecting using non-transaction method in order to obtain query results
		string connection_string = "user=" + m_username + " password=" + m_password + " dbname=" + m_databaseName + " hostaddr=" + m_hostname;
		pqxx::connection c(connection_string);
		pqxx::work w(c);
		pqxx::result r = w.exec(m_query);
		//cout << "RESULT IS: " << r.size() << endl;	//result size should only be 1 row if below is implemented completely

		if (r.size() == 0)		// No existing unique ID, check for special cases, otherwise simply push new entry
		{
			//Check for special cases
			if (!checkSpecialCasesChanged(message, version, mmsi, imo, callsign, vesselname, unique_ID, r))
			{
				//Push new entry
				return addNewStaticEntry(message, version, mmsi, imo, callsign, vesselname, unique_ID);
			}
		}
		else	// Unique ID exists in table, so do some matching
		{
			//Check for changes in existing entry with matching unique ID and entry occurs latter in time
			pqxx::tuple currentRow = r[0];
			if (atoi(currentRow["latest_timestamp"].c_str()) < message.getDATETIME())
			{

				return checkStaticChanges(message, version, mmsi, imo, callsign, vesselname, unique_ID, r);
			}
		}
		*/
	}

	/**
	Check if special cases matches any existing unique IDs
	*/
	bool checkSpecialCasesChanged(const AisMessage& message, string version, string mmsi, string imo, string callsign, string vesselname, string unique_ID, pqxx::result r)
	{
		bool changed = false;
		string connection_string = "user=" + m_username + " password=" + m_password + " dbname=" + m_databaseName + " hostaddr=" + m_hostname;
		string test_query;
		string update_record;
		pqxx::connection c(connection_string);
		pqxx::work w(c);
		pqxx::result test_result;
		pqxx::tuple row = r[0];		//extract a single row of the result

		try
		{
		test_query = "SELECT * FROM " + m_staticTableName + " WHERE MMSI = '" + mmsi + "'";
		test_result = w.exec(test_query);
		if (test_result.size() != 0)
		{
			row = test_result[0];

			//Only update existing record if it has all blank or invalid values
			string old_imo = row["IMO"].c_str();
			string old_vesselname = row["vessel_name"].c_str();
			string old_callsign = row["callsign"].c_str();
			string old_ais_static_id = row["ais_static_id"].c_str();

			//cout << "OLD: " << old_imo << "\t" << old_vesselname << "\t" << old_callsign << "\tID:" << old_ais_static_id << endl;
			//cout << "NEW: " << imo << "\t" << vesselname << "\t" << callsign << endl;

			if (old_imo == "-1" && old_callsign == "" && old_vesselname == "")
			{
				//Update unique_id
				update_record = "UPDATE " + m_staticTableName + " SET unique_id = '" + unique_ID + "', imo = '" + imo + 
								"', vessel_name = '" + sanitize(vesselname) + "', callsign = '" + sanitize(callsign) + "', latest_timestamp = " + 
								"to_timestamp(" + boost::lexical_cast<std::string>(message.getDATETIME()) + ") WHERE ais_static_id = " + old_ais_static_id + ";";
				w.exec(update_record);
				w.commit();

				//aisDebug("Record " << row["ais_static_id"].c_str() << " updated.");
				changed = true;
			}
			//Case where MMSI and vesselname exists, but has blank IMO and callsign
			else if ( (old_imo == "-1" && old_callsign == "" && old_vesselname == vesselname) &&
					  (old_imo == "0" && old_callsign == "" && old_vesselname == vesselname) )
			{
				//Update unique_id
				update_record = "UPDATE " + m_staticTableName + " SET unique_id = '" + unique_ID + "', imo = '" + imo + 
								"', callsign = '" + sanitize(callsign) + "', latest_timestamp = " + 
								"to_timestamp(" + boost::lexical_cast<std::string>(message.getDATETIME()) + ") WHERE ais_static_id = " + old_ais_static_id + ";";
				w.exec(update_record);
				w.commit();

				changed = true;
			}
			//Case where IMO is -1 or 0 but the other 3 unique fields matches
			else if ( (old_imo == "-1" && old_callsign == callsign && old_vesselname == vesselname) &&
					  (old_imo == "0" && old_callsign == callsign && old_vesselname == vesselname) )
			{
				aisDebug("CALLED! for updating IMO only");
				//Update unique_id
				update_record = "UPDATE " + m_staticTableName + " SET unique_id = '" + unique_ID + "', imo = '" + imo + 
								"', latest_timestamp = " + "to_timestamp(" + boost::lexical_cast<std::string>(message.getDATETIME()) + 
								") WHERE ais_static_id = " + old_ais_static_id + ";";
				w.exec(update_record);
				w.commit();

				changed = true;
			}
			else
			{
				//no change or update needed
			}
		}

		//No special case change (truely new static entry)
		return changed;
		}
		catch(const exception &e)
		{
			cerr << "Error on check special cases." << endl;
			cerr << "PostgreSQL Error : " << e.what() << endl;

			return false;
		}
	}

	/**
	 Add a new static entry
	 */
	bool addNewStaticEntry(const AisMessage& message, string mmsi, string imo, string callsign, string vesselname, string unique_ID)
	{
		//aisDebug("Unique ID does not exist, pushing new static vessel row");

		try
		{
			//New method of pushing static using custom Postgres functions
			// Simply push a static row, let pg/plsql function insert_static() handle checking for duplicates and updates
			m_staticSQLStatement = "SELECT insert_static(";
			m_staticSQLStatement += "'" + sanitize(unique_ID) + "'::varchar, " +
									"to_timestamp(" + boost::lexical_cast<std::string>(message.getDATETIME()) + "), " +
									"to_timestamp(" + boost::lexical_cast<std::string>(message.getDATETIME()) + "), " +
									boost::lexical_cast<std::string>(message.getMESSAGETYPE()) + "::smallint, " +
									"'" + mmsi + "'::varchar, " +
									"'" + imo + "'::varchar, " +
									"'" + sanitize(callsign) + "'::varchar, " + 
									"'" + sanitize(vesselname) + "'::varchar, " +
									boost::lexical_cast<std::string>(message.getVESSELTYPEINT()) + "::int, " +
									boost::lexical_cast<std::string>(message.getBOW()) + "::int, " +
									boost::lexical_cast<std::string>(message.getPORT()) + "::int, " +
									boost::lexical_cast<std::string>(message.getSTARBOARD()) + "::int, " +
									boost::lexical_cast<std::string>(message.getSTERN()) + "::int, " +
									boost::lexical_cast<std::string>(message.getSHIPLENGTH()) + "::int, " +
									boost::lexical_cast<std::string>(message.getSHIPWIDTH()) + "::int, " +
									boost::lexical_cast<std::string>(message.getDRAUGHT()) + "::int, " +
									"'" + sanitize(boost::lexical_cast<std::string>(message.getDESTINATION())) + "'::varchar, " +
									"to_timestamp(" + boost::lexical_cast<std::string>(message.getETA()) + "), " +
									boost::lexical_cast<std::string>(message.getPARTNUMBER()) + "::smallint, " +
									"'" + boost::lexical_cast<std::string>(message.getPOSFIXTYPE()) + "'::varchar, " + 
									"'" + sanitize(boost::lexical_cast<std::string>(message.getSTREAMID())) + "'::varchar)";
			StatementExecutor statementExecutor(m_staticSQLStatement);
			m_con->perform(statementExecutor);	//execute the statement
			m_staticSQLStatement = string("");	//reset the statement

			return true;
		}
		catch(const exception &e)
		{
			aisDebug(m_staticSQLStatement);
			cerr << "Error on static write iteration: " << m_staticIteration << endl;
			cerr << "PostgreSQL Error : " << e.what() << endl;
			return false;
		}
	}

	///**
	// Check for changes in the static entry with matching unique ID
	// */
	//bool checkStaticChanges(const AisMessage& message, string version, string mmsi, string imo, string callsign, string vesselname, string unique_ID, pqxx::result r)
	//{
	//	//aisDebug("Unique ID exists, need to check for changes");

	//	pqxx::tuple row = r[0];		//extract a single row of the result

	//	//Do the check for differences
	//	//	CAN'T CHECK FOR NAME, CALLSIGN, IMO, OR MMSI CHANGES BECAUSE THIS WILL CREATE A DIFFERENT UNIQUE ID THAN THE EXISTING ONE

	//	if (atoi(row["vessel_type"].c_str()) != message.getVESSELTYPEINT())
	//	{
	//		aisDebug("Vessel type has changed: \"" << message.getVESSELTYPEINT() << "\" --> \"" << row["vessel_type"] << "\"");
	//		//Do change update and push to change table
	//		addNewChangeEntry(row, message, "Vessel_Type", 
	//			boost::lexical_cast<std::string>(message.getVESSELTYPEINT()), unique_ID);
	//		UpdateStaticEntry(row, message, "Vessel_Type", unique_ID);

	//	}
	//	if (atoi(row["antenna_position_bow"].c_str()) != message.getBOW())
	//	{
	//		aisDebug("Vessel antenna position to bow changed");
	//		//Do change update and push to change table
	//		addNewChangeEntry(row, message, "Antenna_Position_Bow", 
	//			boost::lexical_cast<std::string>(message.getBOW()), unique_ID);
	//		UpdateStaticEntry(row, message, "Antenna_Position_Bow", unique_ID);
	//	}
	//	if (atoi(row["antenna_position_stern"].c_str()) != message.getSTERN())
	//	{
	//		aisDebug("Vessel antenna position to stern changed");
	//		//Do change update and push to change table
	//		addNewChangeEntry(row, message, "Antenna_Position_Stern", 
	//			boost::lexical_cast<std::string>(message.getSTERN()), unique_ID);
	//		UpdateStaticEntry(row, message, "Antenna_Position_Stern", unique_ID);
	//	}
	//	if (atoi(row["antenna_position_port"].c_str()) != message.getPORT())
	//	{
	//		aisDebug("Vessel antenna position to port changed");
	//		//Do change update and push to change table
	//		addNewChangeEntry(row, message, "Antenna_Position_Port", 
	//			boost::lexical_cast<std::string>(message.getPORT()), unique_ID);
	//		UpdateStaticEntry(row, message, "antenna_position_port", unique_ID);
	//	}
	//	if (atoi(row["antenna_position_starboard"].c_str()) != message.getSTARBOARD())
	//	{
	//		aisDebug("Vessel antenna position to starboard changed");
	//		//Do change update and push to change table
	//		addNewChangeEntry(row, message, "Antenna_Position_Starboard", 
	//			boost::lexical_cast<std::string>(message.getSTARBOARD()), unique_ID);
	//		UpdateStaticEntry(row, message, "antenna_position_starboard", unique_ID);
	//	}
	//	if (atoi(row["length"].c_str()) != message.getSHIPLENGTH())
	//	{
	//		aisDebug("Vessel length changed");
	//		//Do change update and push to change table
	//		addNewChangeEntry(row, message, "Length", 
	//			boost::lexical_cast<std::string>(message.getSHIPLENGTH()), unique_ID);
	//		UpdateStaticEntry(row, message, "length", unique_ID);
	//	}
	//	if (atoi(row["width"].c_str()) != message.getSHIPWIDTH())
	//	{
	//		aisDebug("Vessel width changed");
	//		//Do change update and push to change table
	//		addNewChangeEntry(row, message, "Width", 
	//			boost::lexical_cast<std::string>(message.getSHIPWIDTH()), unique_ID);
	//		UpdateStaticEntry(row, message, "width", unique_ID);
	//	}
	//	if (atoi(row["draught"].c_str()) != message.getDRAUGHT())
	//	{
	//		aisDebug("Vessel draught changed");
	//		//Do change update and push to change table
	//		addNewChangeEntry(row, message, "Draught", 
	//			boost::lexical_cast<std::string>(message.getDRAUGHT()), unique_ID);
	//		UpdateStaticEntry(row, message, "draught", unique_ID);
	//	}
	//	string old_destination = row["destination"].c_str();
	//	if (old_destination != message.getDESTINATION())
	//	{
	//		aisDebug("Vessel destination changed");
	//		//Do change update and push to change table
	//		addNewChangeEntry(row, message, "Destination", 
	//			boost::lexical_cast<std::string>(message.getDESTINATION()),unique_ID);
	//		UpdateStaticEntry(row, message, "destination", unique_ID);
	//	}
	//	if (atoi(row["eta"].c_str()) != message.getETA())
	//	{
	//		aisDebug("Vessel ETA has changed: \"" << message.getETA() << "\" --> \"" << row["eta"] << "\"");
	//		//Do change update and push to change table
	//		addNewChangeEntry(row, message, "Eta", 
	//			boost::lexical_cast<std::string>(message.getETA()),unique_ID);
	//		UpdateStaticEntry(row, message, "eta", unique_ID);
	//	}
	//	/*
	//	if (atoi(row["epfd"].c_str()) != message.getEPFD())
	//	{
	//	aisDebug("Vessel EPFD changed");
	//	//Do change update and push to change table
	//	}
	//	*/
	//}

	//// Add new entries to AIS_Change table for existing unique ID when the static messages change
	//bool addNewChangeEntry(pqxx::tuple row, const AisMessage& message, string tag_name, string new_value, string unique_ID)
	//{
	//	string version = "'TEST'";
	//
	//	try
	//	{
	//		if(m_changeIteration == 1 || m_changeMaxIterations <= 0)
	//		{
	//			m_changeSQLStatement = "INSERT INTO " + m_changeTableName + " VALUES(DEFAULT, ";
	//		}
	//		else
	//		{
	//			m_changeSQLStatement+= ", (DEFAULT, ";
	//		}

	//		//Build the change SQL statement
	//		m_changeSQLStatement += boost::lexical_cast<std::string>(row["ais_static_id"].c_str()) + "," +
	//			version + "," +
	//			"'" + sanitize(unique_ID) + "'," +
	//			"to_timestamp(" + boost::lexical_cast<std::string>(message.getDATETIME()) + "), " +
	//			"'" + tag_name + "'," ;
	//		if (tag_name == "Destination")
	//		{
	//			m_changeSQLStatement += "'" + boost::lexical_cast<std::string>(row[tag_name].c_str()) + "'," +
	//				"'" + sanitize(new_value) + "')";
	//		} 
	//		else if  (tag_name == "Eta")
	//		{
	//			m_changeSQLStatement += "to_timestamp(" + boost::lexical_cast<std::string>(row[tag_name].c_str()) + ")," +
	//				"to_timestamp(" + new_value + "))";
	//		} 
	//		else
	//		{
	//			m_changeSQLStatement += boost::lexical_cast<std::string>(row[tag_name].c_str()) + "," +
	//				sanitize(new_value) + ")";
	//		}

	//		if(m_changeIteration++ == m_changeMaxIterations || m_changeMaxIterations <= 0)
	//		{
	//			m_changeIteration = 1;	//Reset iteration number

	//			StatementExecutor statementExecutor(m_changeSQLStatement);
	//			m_con->perform(statementExecutor);	//execute the statement
	//			m_changeSQLStatement = string("");	//reset the statement
	//		}
	//		return true;
	//	}
	//	catch(const exception &e)
	//	{
	//		cerr << "Error on change write iteration: " << m_changeIteration << endl;
	//		cerr << "PostgreSQL Error : " << e.what() << endl;
	//		return false;
	//	}
	//}

	//bool UpdateStaticEntry(pqxx::tuple row, const AisMessage& message, string tag_name, string unique_ID)
	//{
	//	string version = "'TEST'";
	//	
	//	string updateStaticSQLStatement = "UPDATE " + m_staticTableName + " SET ";
	//	
	//	//Build the update SQL statement
	//	updateStaticSQLStatement += tag_name + " = ";
	//	cout << "tag_name " << tag_name << endl;
	//	if (tag_name == "destination")
	//	{
	//		updateStaticSQLStatement += "'" + sanitize(boost::lexical_cast<std::string>(row[tag_name].c_str())) + "'";
	//		cout << m_changeSQLStatement << endl;
	//		
	//	} 
	//	else if  (tag_name == "Eta")
	//	{
	//		updateStaticSQLStatement += "to_timestamp(" + boost::lexical_cast<std::string>(row[tag_name].c_str()) + ")";

	//	} 
	//	else
	//	{
	//		updateStaticSQLStatement +=  boost::lexical_cast<std::string>(row[tag_name].c_str());
	//	}
	//	updateStaticSQLStatement += ", latest_timestamp = ";
	//	updateStaticSQLStatement += "to_timestamp(" + boost::lexical_cast<std::string>(message.getDATETIME()) + ") " ;

	//	updateStaticSQLStatement += " WHERE AIS_Static_ID = "  + boost::lexical_cast<std::string>(row["ais_static_id"].c_str());
	//	cout << updateStaticSQLStatement << endl;
	//	StatementExecutor statementExecutor(updateStaticSQLStatement);
	//	m_con->perform(statementExecutor);	//execute the statement
	//	updateStaticSQLStatement = string("");	//reset the statement
	//		
	//	return true;
	//}

	/**
	Unique vessel ID generator
	*/
	string genUniqueID(string mmsi, string imo, string callsign, string vesselname)
	{
		int MAX_MMSI_LEN = 10;
		int MAX_IMO_LEN = 10;
		int MAX_CALL_SIGN_LEN = 7;
		int MAX_VESSEL_NAME_LEN = 20;

		string temp, uniqueID;

		temp = mmsi;
		boost::algorithm::trim(temp); // trim whitespace before and after string
		boost::algorithm::erase_all(temp, " "); // remove all whitespaces in string
		uniqueID = fillString(temp, MAX_MMSI_LEN); // insert fill characters up to maximum allowed string size

		temp = imo;
		boost::algorithm::trim(temp);
		boost::algorithm::erase_all(temp, " "); // remove all whitespaces in string
		uniqueID += fillString(temp, MAX_IMO_LEN);

		temp = callsign;
		boost::algorithm::trim(temp);
		boost::algorithm::erase_all(temp, " "); // remove all whitespaces in string
		uniqueID += fillString(temp, MAX_CALL_SIGN_LEN);

		temp = vesselname;
		boost::algorithm::trim(temp);
		boost::algorithm::erase_all(temp, " "); // remove all whitespaces in string
		uniqueID += fillString(temp, MAX_VESSEL_NAME_LEN);

		return(uniqueID);
	}

	string fillString(string input, int MAX_LEN)
	{
		int fillLen;
		char DEFAULT_FILL = '|';
		string outputString;
		outputString.append(input);
		if (outputString.length() < MAX_LEN)
		{
			fillLen = MAX_LEN - outputString.length();
			outputString.append(fillLen, DEFAULT_FILL);
		} 
		else if (outputString.length() > MAX_LEN)
		{
			cerr << "Error in fillString length check: " << outputString.length() << " > " << MAX_LEN  << " string = " << outputString << endl;
			exit(1);
		}
		return(outputString);
	}

	bool writeTargetEntry(const AisMessage& message)
	{
		string altitude ="0.0";

		try
		{	
			//Use the same max iterations number as the dynamic table
			if(m_targetIteration == 1 || m_dynamicMaxIterations <= 0)
			{
				m_targetSQLStatement = "INSERT INTO " + m_targetTableName + " VALUES(DEFAULT,";
			}
			else
			{
				m_targetSQLStatement+= ", (DEFAULT, ";
			}

			m_targetSQLStatement+= "to_timestamp(" +
				boost::lexical_cast<std::string>(message.getDATETIME())+ "), " + "'" +
				sanitize(boost::lexical_cast<std::string>(message.getSTREAMID())) + "'," +
				boost::lexical_cast<std::string>(message.getMESSAGETYPE()) + ", " +
				"ST_SetSRID(ST_Point(" +
				boost::lexical_cast<std::string>(message.getLON())+ ", " +
				boost::lexical_cast<std::string>(message.getLAT())+ "),4326)::geography)";

			if(m_targetIteration++ ==m_dynamicMaxIterations || m_dynamicMaxIterations <= 0)
			{
				m_targetIteration = 1;

				StatementExecutor statementExecutor(m_targetSQLStatement);
				m_con->perform(statementExecutor);
				m_targetSQLStatement = string("");
			}
			return true;
		}
		catch(const exception &e)
		{
			cerr << "Error on target iteration: " << m_targetIteration << endl;
			cerr << "PostgreSQL Error : " << e.what() << endl;

			return false;
		}
	}

	void print()
	{
		cout << "Username: " << m_username << endl;
		cout << "Password: " << m_password << endl;
		cout << "Hostname: " << m_hostname << endl;
		cout << "Database Name: " << m_databaseName<< endl;
		cout << "Static Table Name: " << m_staticTableName<< endl;
		cout << "Dynamic Table Name: " << m_dynamicTableName<< endl;
		cout << "Target Location Table Name: " << m_targetTableName<< endl;
		cout << "Change Table Name: " << m_changeTableName<< endl;
		cout << "Static Iteration: " << m_staticIteration<< endl;
		cout << "Dynamic Iteration: " << m_dynamicIteration<< endl;
		cout << "Change Iteration: " << m_changeIteration<< endl;
		cout << "Target Location Iteration: " << m_targetIteration<< endl;
		cout << "Initialized: " << m_initialized<< endl;

		if(m_con)
		{
			cout << "Connection is not null" << endl;
		}
	}

	class StatementExecutor : public pqxx::transactor<>
	{
	private:
		const std::string* m_statement;
	public:
		//Constructor
		StatementExecutor(const std::string& statement) : pqxx::transactor<>("StatementExecutor"), 
			m_statement(&statement)
		{
		}

		void operator()(argument_type &T)
		{
			T.exec(*m_statement);
		}
	};

	string m_username;
	string m_password;
	string m_hostname;
	string m_databaseName;
	string m_staticTableName;
	string m_dynamicTableName;
	string m_targetTableName;
	string m_changeTableName;

	int m_staticMaxIterations;
	int m_dynamicMaxIterations;
	int m_changeMaxIterations;

	int m_staticIteration;
	int m_dynamicIteration;
	int m_changeIteration;
	int m_targetIteration;
	bool m_initialized;
	
	string m_staticSQLStatement;
	string m_dynamicSQLStatement;
	string m_changeSQLStatement;
	string m_targetSQLStatement;
	std::shared_ptr<pqxx::connection>  m_con;
};

#endif
