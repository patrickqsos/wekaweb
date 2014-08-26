package com.wekaweb.helpers;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class TempFilePopulator {
	   private File tf = null;
       public TempFilePopulator(String rootDir) throws IOException {
           tf = File.createTempFile("hello", ".tmp", new File(rootDir));
       }

       public void populate(String line) throws IOException {
           FileWriter fw = new FileWriter(tf, true);
           fw.write(line + "\n");
           fw.close();
       }

       public List<String> getContent() throws IOException {
           List<String> lines = new ArrayList<String>();
           BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(tf)));
           String line;
           while(null != (line = br.readLine())) {
               lines.add(line);
           }
           br.close();
           return lines;
       }

       public boolean deleteTempFile() { return tf.delete(); }
       public String toString() { return tf.getAbsolutePath(); }
}
