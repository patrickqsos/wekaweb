package com.wekaweb.testing;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = "/ptf.html")
public class PopulateTempFile extends HttpServlet { 
    private static final long serialVersionUID = -144949663400032218L;

    private static class TempFilePopulator {
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


    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession();
        TempFilePopulator tfp = (TempFilePopulator) session.getAttribute("tempfilepopulator");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html>");

        out.println("<a href=\"" + request.getServletContext().getContextPath()
            + request.getServletPath() + "\">Refresh</a>");
        out.println("&nbsp;|&nbsp;");
        out.println("<a href=\"" + request.getServletContext().getContextPath()
            + request.getServletPath() + "?logout=true\">Logout</a>");

        String logout = request.getParameter("logout");
        if("true".equals(logout)) {
            if(tfp != null) {
                if(tfp.deleteTempFile()) {
                    log("Temp file '" + tfp + "' deleted.");
                } else {
                    log("Unable to delete temp file '" + tfp + "'");
                }
            }
            session.invalidate();
        } else {
            if(tfp == null) {
                tfp = new TempFilePopulator(request.getServletContext().getRealPath("/"));
                log("Temp file '" + tfp + "' created.");
                session.setAttribute("tempfilepopulator", tfp);
            }
            tfp.populate(new Date().toString());
            out.println("<p>Content of temp file</p>");
            List<String> lines = tfp.getContent();
            for(String line : lines) {
                out.write(line);
                out.write("<br/>");
            }
        }
        out.println("</html>");
    }
}
