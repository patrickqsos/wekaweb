package com.wekaweb.testing;

import java.util.Hashtable;
import java.util.Properties;
import java.util.Vector;

import weka.core.ClassDiscovery;
import weka.core.converters.AbstractLoader;
import weka.core.converters.ConverterUtils;
import weka.core.converters.FileSourcedConverter;
import weka.core.converters.Loader;
import weka.core.converters.XRFFSaver;
import weka.gui.ExtensionFileFilter;
import weka.gui.GenericPropertiesCreator;

public class Runer {

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub

		String CORE_FILE_LOADERS = weka.core.converters.ArffLoader.class
			    .getName()
			    + ","
			    // + weka.core.converters.C45Loader.class.getName() + ","
			    + weka.core.converters.CSVLoader.class.getName()
			    + ","
			    + weka.core.converters.DatabaseConverter.class.getName()
			    + ","
			    // + weka.core.converters.LibSVMLoader.class.getName() + ","
			    // + weka.core.converters.MatlabLoader.class.getName() + ","
			    // + weka.core.converters.SVMLightLoader.class.getName() + ","
			    + weka.core.converters.SerializedInstancesLoader.class.getName()
			    + ","
			    + weka.core.converters.TextDirectoryLoader.class.getName()
			    + ","
			    + weka.core.converters.XRFFLoader.class.getName();
		
		Hashtable<String, String> m_FileLoaders;
		
		m_FileLoaders = new Hashtable<String, String>();
		
		 Properties props = GenericPropertiesCreator.getGlobalOutputProperties();
	      if (props == null) {
	        GenericPropertiesCreator creator = new GenericPropertiesCreator();

	        creator.execute(false);
	        props = creator.getOutputProperties();
	      }
	      
		m_FileLoaders = getFileConverters(
		        props.getProperty(Loader.class.getName(), CORE_FILE_LOADERS),
		        new String[] { FileSourcedConverter.class.getName() });
		
		
		for(int i=0;i<m_FileLoaders.size();i++){
			System.out.println(m_FileLoaders.entrySet());
		}
		       
	}
	
	public static Hashtable<String, String> getFileConverters(
		    String classnames, String[] intf) {
		    Vector<String> list;
		    String[] names;
		    int i;

		    list = new Vector<String>();
		    names = classnames.split(",");
		    for (i = 0; i < names.length; i++) {
		      list.add(names[i]);
		    }

		    return getFileConverters(list, intf);
		  }

	public static Hashtable<String, String> getFileConverters(
		    Vector<String> classnames, String[] intf) {
		    Hashtable<String, String> result;
		    String classname;
		    Class<?> cls;
		    String[] ext;
		    FileSourcedConverter converter;
		    int i;
		    int n;

		    result = new Hashtable<String, String>();

		    for (i = 0; i < classnames.size(); i++) {
		      classname = classnames.get(i);

		      // all necessary interfaces implemented?
		      for (n = 0; n < intf.length; n++) {
		        if (!ClassDiscovery.hasInterface(intf[n], classname)) {
		          continue;
		        }
		      }

		      // get data from converter
		      try {
		        cls = Class.forName(classname);
		        converter = (FileSourcedConverter) cls.newInstance();
		        ext = converter.getFileExtensions();
		      } catch (Exception e) {
		        cls = null;
		        converter = null;
		        ext = new String[0];
		      }

		      if (converter == null) {
		        continue;
		      }

		      for (n = 0; n < ext.length; n++) {
		        result.put(ext[n], classname);
		      }
		    }

		    return result;
		  }
	
}
