package com.wekaweb.testing;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.beans.BeanInfo;
import java.beans.Beans;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.MethodDescriptor;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyDescriptor;
import java.beans.PropertyEditor;
import java.beans.PropertyEditorManager;
import java.beans.PropertyVetoException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Enumeration;

import javax.swing.BorderFactory;
import javax.swing.JComponent;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.SwingConstants;

import weka.core.Environment;
import weka.core.EnvironmentHandler;
import weka.core.Option;
import weka.datagenerators.classifiers.classification.Agrawal;
import weka.datagenerators.classifiers.classification.LED24;
import weka.datagenerators.classifiers.classification.RandomRBF;
import weka.datagenerators.clusterers.BIRCHCluster;
import weka.datagenerators.clusterers.SubspaceCluster;
import weka.gui.GenericObjectEditor;
import weka.gui.PropertyPanel;
import weka.gui.PropertySheetPanel;
//import weka.gui.PropertyValueSelector;
import weka.gui.beans.GOECustomizer;

public class Test {

	private static PropertyEditor m_Editors[];
	private static PropertyDescriptor m_Properties[];
	 private static MethodDescriptor m_Methods[];
	 private static Object m_Values[];
	 private static JComponent m_Views[];
	 private static Object m_Target;
	 private static JLabel m_Labels[];
	 private static String m_TipTexts[];
	 private transient static Environment m_env;

	 private static String labels[];
	 
	public static void main(String[] argss) {
		setTarget();
	}
	
	public static synchronized void setTarget(){
		// TODO Auto-generated method stub
				 //Agrawal leed = new Agrawal();
				// LED24 leed = new LED24();
				 //RandomRBF leed = new RandomRBF();
				 //System.out.println("global info: "+ag.globalInfo());
					
				 BIRCHCluster leed = new BIRCHCluster();
				 Enumeration<Option> j = leed.listOptions();
				// System.out.println("argumentos: "+j.);
				 JPanel scrollablePanel = new JPanel();
				 
				 int componentOffset = 0;
				 int m_NumEditable = 0;
				 GridBagLayout gbLayout = new GridBagLayout();
				 
				 
				 scrollablePanel.setLayout(gbLayout);
				 
				 
				 PropertySheetPanel p = new PropertySheetPanel();
				 p.setTarget(leed);
				 //System.out.println("about: "+p.getAboutPanel());
				 //p.list();
				 
				 GOECustomizer m_Customizer;
				 PropertyDescriptor m_Properties[] = null;
				 MethodDescriptor m_Methods[] = null;
				 Class custClass = null;
				 try {
				      BeanInfo bi = Introspector.getBeanInfo(leed.getClass());
				      m_Properties = bi.getPropertyDescriptors();
				      m_Methods = bi.getMethodDescriptors();
				      custClass = Introspector.
				        getBeanInfo(leed.getClass()).getBeanDescriptor().getCustomizerClass();            
				    } catch (IntrospectionException ex) {
				      System.err.println("PropertySheet: Couldn't introspect");
				      
				    }
				 
				 Object args[] = { };
				    boolean firstTip = true;
				    StringBuffer optionsBuff = new StringBuffer();
				    
				 for (int i = 0;i < m_Methods.length; i++) {
					 String name = m_Methods[i].getDisplayName();
				      Method meth = m_Methods[i].getMethod();
				      //System.out.println(name);
				  	
				      if (name.endsWith("TipText")) {
				          if (meth.getReturnType().equals(String.class)) {
				            try {
				              String tempTip = (String)(meth.invoke(leed, args));
//				              int ci = tempTip.indexOf('.');
				             
				                if (firstTip) {
				                  optionsBuff.append("OPTIONS\n");
				                  firstTip = false;
				                }
				                tempTip = tempTip.replace("<html>", "").
				                  replace("</html>", "").replace("<br>", "\n").replace("<p>", "\n\n");
				                optionsBuff.append(name.replace("TipText", "")).append(" -- ");
				                optionsBuff.append(tempTip).append("\n\n");
				                //jt.setText(m_HelpText.toString());

				            } catch (Exception ex) {

				            }
				         //   break;
				          }
				        } 
				 }
				 
				 
				 //imprime todo el text del boton more
				 //System.out.println(optionsBuff.toString());

				 if (custClass != null) {
				      // System.out.println("**** We've found a customizer for this object!");
				      try {
				        Object customizer = custClass.newInstance();

				        if (customizer instanceof JComponent && 
				            customizer instanceof GOECustomizer) {
				          m_Customizer = (GOECustomizer)customizer;

				          m_Customizer.dontShowOKCancelButtons();
				          m_Customizer.setObject(leed);
				          
				          
				          GridBagConstraints gbc = new GridBagConstraints();
				          gbc.fill = GridBagConstraints.BOTH;
				          gbc.gridwidth = 2;
				          gbc.gridy = componentOffset;     gbc.gridx = 0;
				          gbc.insets = new Insets(0,5,0,5);
				          gbLayout.setConstraints((JComponent)m_Customizer, gbc);
				          scrollablePanel.add((JComponent)m_Customizer);

				          //validate();

				          // sometimes, the calculated dimensions seem to be too small and the
				          // scrollbars show up, though there is still plenty of space on the
				          // screen. hence we increase the dimensions a bit to fix this.
				          Dimension dim = scrollablePanel.getPreferredSize();
				          dim.height += 20;
				          dim.width  += 20;
				         
				          return;
				        }
				      } catch (InstantiationException e) {
				        // TODO Auto-generated catch block
				        e.printStackTrace();
				      } catch (IllegalAccessException e) {
				        // TODO Auto-generated catch block
				        e.printStackTrace();
				      }   
				    }
				 
				 
				
					 
					 
				 m_Editors = new PropertyEditor[m_Properties.length];
				    m_Values = new Object[m_Properties.length];
				    m_Views = new JComponent[m_Properties.length];
				    m_Labels = new JLabel[m_Properties.length];
				    m_TipTexts = new String[m_Properties.length];
				    labels = new String[m_Properties.length];
				    
					//System.err.println("Propiedades: "+m_Properties.length);
		    		
				    
				 for (int i = 0; i < m_Properties.length; i++) {
					 if (m_Properties[i].isHidden() || m_Properties[i].isExpert()) {
							continue;
						      }
					 
					 String name = m_Properties[i].getDisplayName();
					 
					 System.out.println("Name: "+name);
			      		
				      Class type = m_Properties[i].getPropertyType();
				      Method getter = m_Properties[i].getReadMethod();
				      Method setter = m_Properties[i].getWriteMethod();
					  //System.err.println(type.getName());
					  //System.err.println(setter.getName());
					  
				         
					  
				      if (getter == null || setter == null) {
				    	 	continue;
				      }
				         
				      JComponent view = null;
				      //System.out.println("Name:" + name);
				      
				      try {
//				    		Object args[] = { };
				    		Object value = getter.invoke(leed, args);
				    		m_Values[i] = value;
				    		  	
				    		PropertyEditor editor = null;
				    		Class pec = m_Properties[i].getPropertyEditorClass();
				    		
				    		 	
				    		
				    		if (pec != null) {
				    		  try {
				    		    editor = (PropertyEditor)pec.newInstance();
				    			System.err.println("entro...");
					    		
				    		  } catch (Exception ex) {
				    		    // Drop through.
				    			  System.err.println(ex);
							    	
				    		  }
				    		}
				    		if (editor == null) {
				    		  editor = PropertyEditorManager.findEditor(type);
				    		}
				    		m_Editors[i] = editor;

				    		labels[i] = name;
						    
				    		// If we can't edit this component, skip it.
				    		if (editor == null) {
				    		  // If it's a user-defined property we give a warning.
				    		  String getterClass = m_Properties[i].getReadMethod()
				    		    .getDeclaringClass().getName();
				    		  /*
				    		  if (getterClass.indexOf("java.") != 0) {
				    		    System.err.println("Warning: Can't find public property editor"
				    				       + " for property \"" + name + "\" (class \""
				    				       + type.getName() + "\").  Skipping.");
				    		  }
				    		  */
				    		  continue;
				    		}
				    		
				    		
				    		 
				    		if (editor instanceof GenericObjectEditor) {
				    		
				    		  ((GenericObjectEditor) editor).setClassType(type);
				    		}
				    		
				    		if (editor instanceof EnvironmentHandler) {
				    			
				    		  ((EnvironmentHandler)editor).setEnvironment(m_env);
				    		}

				    		// Don't try to set null values:
				    		if (value == null) {
				    		  // If it's a user-defined property we give a warning.
				    		  String getterClass = m_Properties[i].getReadMethod()
				    		    .getDeclaringClass().getName();
				    		  
				    			  System.err.println("getter class: "+getterClass);
							  
				    		  /*
				    		  if (getterClass.indexOf("java.") != 0) {
				    		    System.err.println("Warning: Property \"" + name 
				    				       + "\" has null initial value.  Skipping.");
				    		  }
				    		  */
				    		  continue;
				    		}

				    		editor.setValue(value);

				    		// now look for a TipText method for this property
				    	        String tipName = name + "TipText";
				    		for (int k = 0; k < m_Methods.length; k++) {
				    		  String mname = m_Methods[k].getDisplayName();
				    		  Method meth = m_Methods[k].getMethod();
				    		  if (mname.equals(tipName)) {
				    		    if (meth.getReturnType().equals(String.class)) {
				    		      try {
				    			String tempTip = (String)(meth.invoke(leed, args));
				    			int ci = tempTip.indexOf('.');
				    			if (ci < 0) {
				    			  m_TipTexts[i] = tempTip;
				    			} else {
				    			  m_TipTexts[i] = tempTip.substring(0, ci);
				    			}
				    	/*                if (m_HelpText != null) {
				    	                  if (firstTip) {
				    	                    m_HelpText.append("OPTIONS\n");
				    	                    firstTip = false;
				    	                  }
				    	                  m_HelpText.append(name).append(" -- ");
				    	                  m_HelpText.append(tempTip).append("\n\n"); 
				    	                  //jt.setText(m_HelpText.toString());
				    	                } */
				    		      } catch (Exception ex) {

				    		      }
				    		      break;
				    		    }
				    		  }
				    		}	  

				    		// Now figure out how to display it...
				    		if (editor.isPaintable() && editor.supportsCustomEditor()) {
				    		  view = new PropertyPanel(editor);
				    		    System.err.println( view.getName());
							} else if (editor.supportsCustomEditor() && (editor.getCustomEditor() instanceof JComponent)) {
				    		  view = (JComponent) editor.getCustomEditor();
				    		    System.err.println( view.getName());
							  
				    		} else if (editor.getTags() != null) {
				    		  //view = new PropertyValueSelector(editor);
				    		  String tags[] = editor.getTags();
				    		  
				    		  for(int u=0;u<tags.length;u++)
				    				System.out.println(tags[u]+"  ");
					    			  
				    		  
				    		} else if (editor.getAsText() != null) {
				    		  //view = new PropertyText(editor);
				    			System.out.println("saca un campo de texto...");
				    		} else {
				    		  System.err.println("Warning: Property \"" + name 
				    				     + "\" has non-displayabale editor.  Skipping.");
				    		  continue;
				    		}
				    		
				    		//editor.addPropertyChangeListener(this);

				    	      } catch (InvocationTargetException ex) {
				    		System.err.println("Skipping property " + name
				    				   + " ; exception on target: "
				    				   + ex.getTargetException());
				    		ex.getTargetException().printStackTrace();
				    		continue;
				    	      } catch (Exception ex) {
				    		System.err.println("Skipping property " + name
				    				   + " ; exception: " + ex);
				    		ex.printStackTrace();
				    		continue;
				    	      }
				  	
				      
				      //m_Labels[i] = new JLabel(name, SwingConstants.RIGHT);
				      m_NumEditable ++;
				      
				      
				 }
				 System.out.println("Numeros de opciones: "+m_NumEditable);
				 
				 System.out.println("***Printing tiptexts***\n");
				 for(int l=0;l<m_TipTexts.length;l++)
					 System.out.println(labels[l]+" "+m_TipTexts[l]);
				 	 
				 /*
				 while(j.hasMoreElements()){
					 Option aux = j.nextElement();
					 System.out.println("args: "+aux.numArguments());
					 System.out.println(aux.name());
						System.out.println("desc: "+aux.description()+"\n");
				 }
				 */
	}
	synchronized void wasModified(PropertyChangeEvent evt) {

	    //    System.err.println("wasModified");
	    if (evt.getSource() instanceof PropertyEditor) {
	      PropertyEditor editor = (PropertyEditor) evt.getSource();
	      for (int i = 0 ; i < m_Editors.length; i++) {
		if (m_Editors[i] == editor) {
		  PropertyDescriptor property = m_Properties[i];
		  Object value = editor.getValue();
		  m_Values[i] = value;
		  Method setter = property.getWriteMethod();
		  try {
		    Object args[] = { value };
		    args[0] = value;
		    setter.invoke(m_Target, args);
		  } catch (InvocationTargetException ex) {
		    if (ex.getTargetException()
			instanceof PropertyVetoException) {
	              String message = "WARNING: Vetoed; reason is: " 
	                               + ex.getTargetException().getMessage();
		      System.err.println(message);
	              
	              Component jf;
	              if(evt.getSource() instanceof JPanel)
	                  jf = ((JPanel)evt.getSource()).getParent();
	              else
	                  jf = new JFrame();
	              JOptionPane.showMessageDialog(jf, message, 
	                                            "error", 
	                                            JOptionPane.WARNING_MESSAGE);
	              if(jf instanceof JFrame)
	                  ((JFrame)jf).dispose();

	            } else {
		      System.err.println(ex.getTargetException().getClass().getName()+ 
					 " while updating "+ property.getName() +": "+
					 ex.getTargetException().getMessage());
	              Component jf;
	              if(evt.getSource() instanceof JPanel)
	                  jf = ((JPanel)evt.getSource()).getParent();
	              else
	                  jf = new JFrame();
	              JOptionPane.showMessageDialog(jf,
	                                            ex.getTargetException().getClass().getName()+ 
	                                            " while updating "+ property.getName()+
	                                            ":\n"+
	                                            ex.getTargetException().getMessage(), 
	                                            "error", 
	                                            JOptionPane.WARNING_MESSAGE);
	              if(jf instanceof JFrame)
	                  ((JFrame)jf).dispose();

	            }
		  } catch (Exception ex) {
		    System.err.println("Unexpected exception while updating " 
			  + property.getName());
		  }
		  if (m_Views[i] != null && m_Views[i] instanceof PropertyPanel) {
		    //System.err.println("Trying to repaint the property canvas");
		    m_Views[i].repaint();
		    //revalidate();
		  }
		  break;
		}
	      }
	    }

	    // Now re-read all the properties and update the editors
	    // for any other properties that have changed.
	    for (int i = 0; i < m_Properties.length; i++) {
	      Object o;
	      try {
		Method getter = m_Properties[i].getReadMethod();
		Method setter = m_Properties[i].getWriteMethod();
		
		if (getter == null || setter == null) {
		  // ignore set/get only properties
		  continue;
		}

		Object args[] = { };
		o = getter.invoke(m_Target, args);
	      } catch (Exception ex) {
		o = null;
	      }
	      if (o == m_Values[i] || (o != null && o.equals(m_Values[i]))) {
		// The property is equal to its old value.
		continue;
	      }
	      m_Values[i] = o;
	      // Make sure we have an editor for this property...
	      if (m_Editors[i] == null) {
		continue;
	      }
	      // The property has changed!  Update the editor.
	      //m_Editors[i].removePropertyChangeListener(this);
	      m_Editors[i].setValue(o);
	      //m_Editors[i].addPropertyChangeListener(this);
	      if (m_Views[i] != null) {
		//System.err.println("Trying to repaint " + (i + 1));
		m_Views[i].repaint();
	      }
	    }

	    // Make sure the target bean gets repainted.
	    if (Beans.isInstanceOf(m_Target, Component.class)) {
	      ((Component)(Beans.getInstanceOf(m_Target, Component.class))).repaint();
	    }
	  }


}
