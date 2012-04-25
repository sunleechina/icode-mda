package omarclient;


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Properties;

/**
 * This class reads a property list (key and element pairs) from a URL
 * 
 * @author cysneros
 * 
 */
public class Configuration {

	/**
	 * Only one configuration object is available. This is so that the same
	 * configuration can be shared among multiple classes without each class
	 * having to load the configuration object. The configuration object must
	 * only be loaded once.
	 */
	private static Properties mProperties = new Properties();

	/**
	 * This flag represents whether or not the Configuration file was loaded.
	 */
	private static boolean mLoaded = false;

	/**
	 * The constructor is protected so that other classes cannot instantiate a
	 * configuration object.
	 */
	protected Configuration() {
	}

	/**
	 * Provides a reference to the configuration object
	 * 
	 * @return - The configuration object
	 */
	public static final Properties getConfiguration() {
		return mProperties;
	}

	/**
	 * Convenience method for setting the configuration from the specified
	 * Properties
	 * 
	 * @param properties
	 */
	public static final void setConfiguration(Properties properties) {
		mProperties = properties;
	}

	/**
	 * Convenience method for loading a configuration file from a URL
	 * 
	 * @param configFileUrl
	 *            - The URL of the config file you wish to load
	 * @return - An initialized configuration object
	 */
	public static final void loadConfigFile(String configFileUrl)
			throws IOException {
		Properties config = new Properties();
		try {
			// Read from the configuration file
			URL configUrl = new URL(configFileUrl);
			config.load(new BufferedInputStream(configUrl.openStream()));

			mLoaded = true;
		} catch (IOException ex) {
			throw ex;
		}

		mProperties = config;
	}

	/**
	 * Convenience method that returns the property value as a String
	 * 
	 * @param propertyName
	 *            - Name of the property to return
	 * @return - Property value as a String
	 */
	public static String getAsString(String propertyName) {
		if (mProperties.getProperty(propertyName) != null)
			return mProperties.getProperty(propertyName).trim();
		else
			return mProperties.getProperty(propertyName);
	}

	/**
	 * Convenience method that returns the property value as a double
	 * 
	 * @param propertyName
	 *            - Name of the property to return
	 * @return - Property value as a double
	 */
	public static double getAsDouble(String propertyName) {
		return Double.parseDouble(mProperties.getProperty(propertyName));
	}

	/**
	 * Convenience method that returns the property value as an int
	 * 
	 * @param propertyName
	 *            - Name of the property to return
	 * @return - Property value as an int
	 */
	public static int getAsInt(String propertyName) {
		return Integer.parseInt(mProperties.getProperty(propertyName));
	}

	/**
	 * Convenience method that returns the property value as a boolean
	 * 
	 * @param propertyName
	 *            - Name of the property to return
	 * @return - Property value as a boolean
	 */
	public static boolean getAsBoolean(String propertyName) {
		return (Boolean.valueOf(mProperties.getProperty(propertyName)))
				.booleanValue();
	}

	/**
	 * Convenience method that returns the property value as a URL
	 * 
	 * @param propertyName
	 *            - Name of the property to return
	 * @return - Property value as a URL
	 * @throws MalformedURLException
	 *             - If the property value is not a valid URL
	 */
	public static URL getAsURL(String propertyName)
			throws MalformedURLException {
		return new URL(mProperties.getProperty(propertyName));
	}

	/**
	 * Convenience method that sets a key/value pair in the property list
	 * 
	 * @param entryKey
	 *            - Name of the property key to set
	 * @param entryValue
	 *            - Property key value
	 * @return - True if entryKey found in property list
	 * @throws - N/A
	 */
	public static boolean setEntry(String entryKey, String entryValue) {
		// Returns null if key not found in property list (key is added if not found)
		return mProperties.setProperty(entryKey, entryValue) != null;
	}

	/**
	 * Convenience method that adds a key/value pair to the property list
	 * 
	 * @param entryKey
	 *            - Name of the property key to add
	 * @param entryValue
	 *            - Property key value
	 * @return - True if entryKey not found in property list
	 * @throws - N/A
	 */
	public static boolean addEntry(String entryKey, String entryValue) {
		// Returns previous value of key if key found in property list (key is then updated instead of added)
		return mProperties.setProperty(entryKey, entryValue) == null;
	}

	/**
	 * Convenience method that removes a key/value pair from the property list
	 * 
	 * @param entryKey
	 *            - Name of the property key to remove
	 * @return - True if entryKey found in property list
	 * @throws - N/A
	 */
	public static boolean removeEntry(String entryKey) {
		// Returns null if key not found in property list.
		return mProperties.remove(entryKey) != null;
	}

	/**
	 * Convenience method that saves properties list to configuration file
	 * 
	 * @param configFileUrl
	 *            - Name of the configuration file for saving the properties list
	 * @return - N/A
	 * @throws IOException
	 *             - If writing this property list to the configuration file throws an IOException
	 */
	public static final void savePropertyList(String configFile)
			throws IOException {
		
		if (mLoaded) {
			try {
				// Save to the configuration file
				mProperties.store(new BufferedOutputStream(new FileOutputStream(configFile)), null);
			} catch (IOException ex) {
				throw ex;
			}
		} else {
			// Attempt to write out property list that has not been loaded.  Throw IOException for now.
			throw new IOException();
		}
	}

	/**
	 * The getter for the mLoaded attribute.
	 * 
	 * @return - Returns the mLoaded variable value
	 */
	public static boolean isLoaded() {
		return mLoaded;
	}

}

