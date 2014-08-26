package com.wekaweb.testing;

import weka.core.Instances;
import weka.datagenerators.DataGenerator;
import weka.datagenerators.classifiers.classification.LED24;

public class Generate {

	protected static DataGenerator ins = null;
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub

		Agrawal ag = new Agrawal();
		//ag.list();
		LED24 led = new LED24();
		
		//led.setDatasetFormat(ins);
		//Instances i = led.generateExamples();
		
		
		//System.out.println(i);
	}

}
