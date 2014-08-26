package com.wekaweb.testing;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.beans.PropertyChangeSupport;
import java.io.PrintWriter;
import java.io.StringReader;
import java.io.StringWriter;

import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JDialog;
import javax.swing.JOptionPane;
import javax.swing.SwingUtilities;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.TableModel;

import weka.core.Capabilities;
import weka.core.Instances;
import weka.core.OptionHandler;
import weka.core.Utils;
import weka.datagenerators.DataGenerator;
import weka.gui.AttributeSelectionPanel;
import weka.gui.AttributeSummaryPanel;
import weka.gui.AttributeVisualizationPanel;
import weka.gui.InstancesSummaryPanel;
import weka.gui.Logger;
import weka.gui.SysErrLog;
import weka.gui.explorer.DataGeneratorPanel;
import weka.gui.explorer.ExplorerDefaults;

public class Generator {
	protected static Instances m_Instances = null;

	protected static DataGenerator m_DataGenerator = null;
	protected static DataGeneratorPanel pan = new DataGeneratorPanel(){
		/**
		 * 
		 */
		private static final long serialVersionUID = 563843948046742585L;

		@Override
		public boolean execute(){
			
			System.out.print("metodo override");
			DataGenerator     generator;
		    boolean           result;
		    String            relName;
		    String            cname;
		    String            cmd;
		    
		    result    = true;
		    generator = (DataGenerator) m_GeneratorEditor.getValue();
		    relName   = generator.getRelationName();

		    cname = generator.getClass().getName().replaceAll(".*\\.", "");
		    cmd = generator.getClass().getName();
		    if (generator instanceof OptionHandler)
		      cmd += " " + Utils.joinOptions(((OptionHandler) generator).getOptions());
		    
		    try {
		      m_Log.logMessage("Started " + cname);
		      m_Log.logMessage("Command: " + cmd);
		      m_Output = new StringWriter();
		      generator.setOutput(new PrintWriter(m_Output));
		      DataGenerator.makeData(generator, generator.getOptions());
		      m_Instances = new Instances(new StringReader(getOutput()));
		      m_Log.logMessage("Finished " + cname);
		    }
		    catch (Exception e) {
		      e.printStackTrace();
		      JOptionPane.showMessageDialog(
		          this, "Error generating data:\n" + e.getMessage(), 
		          "Error", JOptionPane.ERROR_MESSAGE);
		      m_Instances = null;
		      m_Output    = new StringWriter();
		      result      = false;
		    }

		    generator.setRelationName(relName);
			return result;
		}
	};
	protected static Logger m_Log = new SysErrLog();
	//protected static  Instances m_Instances;
	protected static AttributeSelectionPanel m_AttPanel = new AttributeSelectionPanel();
	protected static InstancesSummaryPanel m_InstSummaryPanel =
		    new InstancesSummaryPanel();

	protected static JButton m_RemoveButton = new JButton("Remove");

	protected static AttributeSummaryPanel m_AttSummaryPanel =
		    new AttributeSummaryPanel();
	
	protected static AttributeVisualizationPanel m_AttVisualizePanel = 
		    new AttributeVisualizationPanel();

	  protected static JButton m_ApplyFilterBut = new JButton("Apply");


	  protected static JButton m_EditBut = new JButton("Edit...");

	  protected static JButton m_SaveBut = new JButton("Save...");
	  
	  //protected static PropertyChangeSupport m_Support = new PropertyChangeSupport(this);


	public static void main(String[] args) {
		final DataGeneratorPanel generatorPanel = new DataGeneratorPanel();
        final JDialog dialog = new JDialog();
        final JButton generateButton = new JButton("Generar");
        final JCheckBox showOutputCheckBox = 
                            new JCheckBox("Show generated data as text, incl. comments");

        showOutputCheckBox.setMnemonic('S');
        pan.setLog(m_Log);
        pan.setGenerator(new weka.datagenerators.classifiers.classification.Agrawal());
        
        generatorPanel.setPreferredSize(
            new Dimension(
                  300, 
                  (int) generatorPanel.getPreferredSize().getHeight()));
        generateButton.setMnemonic('G');
        generateButton.setToolTipText("Generates the dataset according the settings.");
        generateButton.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent evt){
              // generate
              System.out.println("Generator: "+m_DataGenerator.getClass().getName());
              pan.execute();
              boolean generated = (pan.getInstances() != null);
              if (generated)
                setInstances(pan.getInstances());

              System.out.println("numero de atributos: "+m_Instances.numAttributes());
              System.out.println("numeor de instancias: "+m_Instances.numInstances());
              //System.out.println(generatorPanel.getOutput());
              
              // close dialog
              //dialog.dispose();

              // get last generator
              m_DataGenerator = generatorPanel.getGenerator();

              // display output?
              //if ( (generated) && (showOutputCheckBox.isSelected()) )
               // showGeneratedInstances(generatorPanel.getOutput());
          }
        });
          
        // close dialog
        //dialog.dispose();

        // get last generator
        m_DataGenerator = pan.getGenerator();
        
        
        
        dialog.setTitle("DataGenerator");
        dialog.getContentPane().add(pan, BorderLayout.CENTER);
        dialog.getContentPane().add(generateButton, BorderLayout.EAST);
        dialog.getContentPane().add(showOutputCheckBox, BorderLayout.SOUTH);
        dialog.pack();
        
        dialog.setVisible(true);
        
		
	}

	public static void  setInstances(Instances inst) {

	    m_Instances = inst;
	    try {
	      Runnable r = new Runnable() {
		public void run() {
		  boolean first = 
		    (m_AttPanel.getTableModel() == null);
		  
		  m_InstSummaryPanel.setInstances(m_Instances);
		  m_AttPanel.setInstances(m_Instances);
		  
		  if (first) {
		    TableModel model = m_AttPanel.getTableModel(); 
		    model.addTableModelListener(new TableModelListener() {
		      public void tableChanged(TableModelEvent e) {
		        if (m_AttPanel.getSelectedAttributes() != null &&
		            m_AttPanel.getSelectedAttributes().length > 0) {
		          m_RemoveButton.setEnabled(true);
		        } else {
		          m_RemoveButton.setEnabled(false);
		        }
		      }
		    });
		  }
//		  m_RemoveButton.setEnabled(true);
		  m_AttSummaryPanel.setInstances(m_Instances);
		  m_AttVisualizePanel.setInstances(m_Instances);

		  // select the first attribute in the list
		  m_AttPanel.getSelectionModel().setSelectionInterval(0, 0);
		  m_AttSummaryPanel.setAttribute(0);
		  m_AttVisualizePanel.setAttribute(0);

		  m_ApplyFilterBut.setEnabled(true);

		  m_Log.logMessage("Base relation is now "
				   + m_Instances.relationName()
				   + " (" + m_Instances.numInstances()
				   + " instances)");
		  m_SaveBut.setEnabled(true);
		  m_EditBut.setEnabled(true);
		  m_Log.statusMessage("OK");
		  // Fire a propertychange event
		 // m_Support.firePropertyChange("", null, null);
		  
		  // notify GOEs about change
		  /*
		  try {
		    // get rid of old filter settings
		    getExplorer().notifyCapabilitiesFilterListener(null);

		    int oldIndex = m_Instances.classIndex();
		    m_Instances.setClassIndex(m_AttVisualizePanel.getColorBox().getSelectedIndex() - 1);
		    
		    // send new ones
		    if (ExplorerDefaults.getInitGenericObjectEditorFilter())
		      getExplorer().notifyCapabilitiesFilterListener(
			  Capabilities.forInstances(m_Instances));
		    else
		      getExplorer().notifyCapabilitiesFilterListener(
			  Capabilities.forInstances(new Instances(m_Instances, 0)));

		    m_Instances.setClassIndex(oldIndex);
		  }
		  catch (Exception e) {
		    e.printStackTrace();
		    m_Log.logMessage(e.toString());
		  }
		  */
		}
	      };
	      if (SwingUtilities.isEventDispatchThread()) {
		r.run();
	      } else {
		SwingUtilities.invokeAndWait(r);
	      }
	    } catch (Exception ex) {
	      ex.printStackTrace();
	      /*
	      JOptionPane.showMessageDialog(this,
					    "Problem setting base instances:\n"
					    + ex,
					    "Instances",
					    JOptionPane.ERROR_MESSAGE);
					    */
	    }
	  }
}
