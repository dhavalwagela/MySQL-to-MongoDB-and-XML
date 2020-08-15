import java.io.File;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.mongodb.*;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

public class MongoDB {
    public static void main(String args[]) throws Exception {

        //JDBC connection to fetch dsta from database
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/project2?serverTimezone=UTC", "root", "123456");
        if (!connection.isClosed()) {
            Statement stmt = connection.createStatement();

            String query = "select Pname, Pnumber, Dnum from project";
            ResultSet rsForXml = stmt.executeQuery(query);
            DocumentBuilderFactory documentFactory = DocumentBuilderFactory.newInstance();

            DocumentBuilder documentBuilder = documentFactory.newDocumentBuilder();

            //XML document for projects
            Document documentForProjectsXML = documentBuilder.newDocument();

            //parent tag in the projects' XML document
            Element projects = documentForProjectsXML.createElement("projects");
            documentForProjectsXML.appendChild(projects);

            if (rsForXml.next()) {
                do {
                    //Indiviual project tag in parent projects tag
                    Element project = documentForProjectsXML.createElement("project");
                    projects.appendChild(project);

                    Element pname = documentForProjectsXML.createElement("Pname");
                    pname.appendChild(documentForProjectsXML.createTextNode(rsForXml.getString("Pname")));
                    project.appendChild(pname);

                    Element pnumber = documentForProjectsXML.createElement("Pnumber");
                    pnumber.appendChild(documentForProjectsXML.createTextNode(rsForXml.getString("Pnumber")));
                    project.appendChild(pnumber);

                    Element dname = documentForProjectsXML.createElement("Dname");
                    dname.appendChild(documentForProjectsXML.createTextNode(getDepartmentName(rsForXml.getString("Dnum"), connection)));
                    project.appendChild(dname);

                    List<String> listOfSsn = getListOfEmployeesForProject(rsForXml.getString("Pnumber"), connection);
                    List<Element> listOfWorkers = new ArrayList<>();

                    Element workers = documentForProjectsXML.createElement("workers");
                    for (String ssn : listOfSsn) {
                        Element hours = documentForProjectsXML.createElement("hours");
                        hours.appendChild(documentForProjectsXML.createTextNode(getHours(rsForXml.getString("Pnumber"), ssn, connection)));
                        Element worker = getElementForEmployeeName(ssn, connection, documentForProjectsXML);
                        worker.appendChild(hours);
                        workers.appendChild(worker);
                    }
                    project.appendChild(workers);
                } while (rsForXml.next());
            }
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "2");
            DOMSource domSource = new DOMSource(documentForProjectsXML);
            StreamResult streamResult = new StreamResult(new File("projectsXMLDoc.xml"));

            //Writing document in XML file
            transformer.transform(domSource, streamResult);

            //Connection with MongoDB, by connecting to database in mongodb
            DB database = (new MongoClient("localhost",27017)).getDB("mydatabase");

            DBCollection collectionForProjects = database.getCollection("collectionForProjects");
            ResultSet rs = stmt.executeQuery(query);

            if (rs.next() == true)  {
               do {
                   //Putting data into db object for mongodb
                   BasicDBObject dbObject = new BasicDBObject();
                   dbObject.put("Pname", rs.getString("Pname"));
                   dbObject.put("Pnumber", rs.getString("Pnumber"));
                   dbObject.put("Dname", getDepartmentName(rs.getString("Dnum"), connection));
                   List<String> listOfSsn = getListOfEmployeesForProject(rs.getString("Pnumber"), connection);
                   List<BasicDBObject> listOfWorkers = new ArrayList<>();
                   for (String ssn : listOfSsn) {
                       listOfWorkers.add(getEmployeeName(ssn, connection).append("hours", getHours(rs.getString("Pnumber"), ssn, connection)));
                   }
                   dbObject.put("workers", listOfWorkers);
                   //Adding object to collection which is in MongoDB
                   collectionForProjects.insert(dbObject);
                } while (rs.next());
            }


            query = "select * from employee";
            ResultSet rsForEmployees = stmt.executeQuery(query);

            //XML document for employees
            Document documentForEmployeesXML = documentBuilder.newDocument();

            //parent tag in the employees' XML document
            Element employees = documentForEmployeesXML.createElement("employees");
            documentForEmployeesXML.appendChild(employees);

            if (rsForEmployees.next()) {
                do {
                    //Indiviual employee tag in parent employees tag
                    Element employee = documentForEmployeesXML.createElement("employee");
                    employees.appendChild(employee);

                    Element lname = documentForEmployeesXML.createElement("Lname");
                    lname.appendChild(documentForEmployeesXML.createTextNode(rsForEmployees.getString("Lname")));
                    employee.appendChild(lname);

                    Element fname = documentForEmployeesXML.createElement("Fname");
                    fname.appendChild(documentForEmployeesXML.createTextNode(rsForEmployees.getString("Fname")));
                    employee.appendChild(fname);

                    Element dname = documentForEmployeesXML.createElement("Dname");
                    dname.appendChild(documentForEmployeesXML.createTextNode(getDepartmentName(rsForEmployees.getString("Dno"), connection)));
                    employee.appendChild(dname);

                    List<String> listOfPno = getListOfProjectsForEmployees(rsForEmployees.getString("ssn"), connection);

                    Element projectsOfEmployees = documentForEmployeesXML.createElement("projects");
                    for (String pno : listOfPno) {
                        Element hours = documentForEmployeesXML.createElement("hours");
                        hours.appendChild(documentForEmployeesXML.createTextNode(getHours(pno, rsForEmployees.getString("ssn"), connection)));
                        Element project = getProjectElements(pno, connection, documentForEmployeesXML);
                        project.appendChild(hours);
                        projectsOfEmployees.appendChild(project);
                    }
                    employee.appendChild(projectsOfEmployees);
                } while (rsForEmployees.next());
            }

            domSource = new DOMSource(documentForEmployeesXML);
            streamResult = new StreamResult(new File("employeesXMLDoc.xml"));

            //Writing document in XML file
            transformer.transform(domSource, streamResult);


            DBCollection collectionForEmployees = database.getCollection("collectionForEmployees");
            rs = stmt.executeQuery(query);
            if (rs.next() == true)  {
                do {
                    BasicDBObject dbObject = new BasicDBObject();
                    dbObject.put("Lname",rs.getString("Lname"));
                    dbObject.put("Fname",rs.getString("Fname"));

                    dbObject.put("Dname",getDepartmentName(rs.getString("Dno"), connection));

                    List<String> listOfPno = getListOfProjectsForEmployees(rs.getString("ssn"), connection);
                    List<BasicDBObject> listOfProjects = new ArrayList<>();
                    for (String pno : listOfPno) {
                        listOfProjects.add(getProjectDoc(pno, connection).append("hours", getHours(pno, rs.getString("ssn"), connection)));
                    }
                    dbObject.put("projects", listOfProjects);
                    collectionForEmployees.insert(dbObject);
                } while (rs.next());
            }

            query = "select * from department";
            rs = stmt.executeQuery(query);

            DBCollection collectionForDepartments = database.getCollection("collectionForDepartments");

            if (rs.next() == true)  {
                do {
                    BasicDBObject dbObject = new BasicDBObject();
                    dbObject.put("Dname",rs.getString("Dname"));
                    dbObject.put("Dnumber",rs.getString("Dnumber"));
                    BasicDBObject nameQuery = getEmployeeName(rs.getString("Mgr_ssn"), connection);
                    dbObject.put("Lname", nameQuery.get("Lname"));
                    dbObject.put("Fname", nameQuery.get("Fname"));
                    dbObject.put("Dname",getDepartmentName(rs.getString("Dnumber"), connection));

                    List<String> listOfEmpSsn = getListOfEmployeesForDepartment(rs.getString("Dnumber"), connection);
                    List<BasicDBObject> listOfEmp = new ArrayList<>();
                    for (String ssn : listOfEmpSsn) {
                        listOfEmp.add(getEmployeeInfo(ssn, connection));
                    }
                    dbObject.put("employees", listOfEmp);
                    collectionForDepartments.insert(dbObject);
                } while (rs.next());
            }

        }
    }
    public static BasicDBObject getEmployeeInfo(String ssn, Connection connection) throws Exception {
        Statement stmt = connection.createStatement();
        String query = "select * from employee where ssn = "+ssn;
        ResultSet rs = stmt.executeQuery(query);
        BasicDBObject dbObject = new BasicDBObject();
        if (rs.next())  {
            do {
                dbObject.put("Lname", rs.getString("Lname"));
                dbObject.put("Fname", rs.getString("Fname"));
                dbObject.put("Salary", rs.getString("Salary"));

            } while (rs.next());
        }
        rs.close();
        return dbObject;
    }
    public static List<String> getListOfEmployeesForDepartment(String dno, Connection connection) throws Exception {
        Statement stmt = connection.createStatement();
        String query = "select * from employee where Dno = "+dno;
        ResultSet rs = stmt.executeQuery(query);
        List<String> result = new ArrayList<>();
        if (rs.next())  {
            do {
                result.add(rs.getString("ssn"));
            } while (rs.next());
        }
        rs.close();
        return result;
    }
    public static BasicDBObject getEmployeeName(String ssn, Connection connection) throws Exception {
        Statement stmt = connection.createStatement();
        String query = "select * from employee where ssn = "+ssn;
        ResultSet rs = stmt.executeQuery(query);
        BasicDBObject dbObject = new BasicDBObject();
        if (rs.next())  {
            do {
                dbObject.put("Fname", rs.getString("Fname"));
                dbObject.put("Lname", rs.getString("Lname"));
            } while (rs.next());
        }
        rs.close();
        return dbObject;
    }
    public static Element getElementForEmployeeName(String ssn, Connection connection, Document document) throws Exception {
        Statement stmt = connection.createStatement();
        String query = "select * from employee where ssn = "+ssn;
        ResultSet rs = stmt.executeQuery(query);
        Element worker = document.createElement("worker");

        if (rs.next())  {
            do {
                Element fname = document.createElement("Fname");
                fname.appendChild(document.createTextNode(rs.getString("Fname")));
                worker.appendChild(fname);

                Element lname = document.createElement("Lname");
                lname.appendChild(document.createTextNode(rs.getString("Lname")));
                worker.appendChild(fname);

            } while (rs.next());
        }
        rs.close();
        return worker;
    }
    public static List<String> getListOfEmployeesForProject(String pno, Connection connection) throws Exception {
        Statement stmt = connection.createStatement();
        String query = "select essn, pno from works_on where pno = "+pno;
        ResultSet rs = stmt.executeQuery(query);
        List<String> result = new ArrayList<>();
        if (rs.next())  {
            do {
                result.add(rs.getString("essn"));
            } while (rs.next());
        }
        rs.close();
        return result;
    }
    public static List<String> getListOfProjectsForEmployees(String ssn, Connection connection) throws Exception {
        Statement stmt = connection.createStatement();
        String query = "select essn, pno from works_on where essn = "+ssn;
        ResultSet rs = stmt.executeQuery(query);
        List<String> result = new ArrayList<>();
        if (rs.next())  {
            do {
                result.add(rs.getString("pno"));
            } while (rs.next());
        }
        rs.close();
        return result;
    }
    public static Element getProjectElements(String pno, Connection connection, Document document) throws Exception {
        Statement stmt = connection.createStatement();
        String query = "select * from project where pnumber = "+pno;
        ResultSet rs = stmt.executeQuery(query);
        Element project = document.createElement("project");
        if (rs.next())  {
            do {
                Element pname = document.createElement("Pname");
                pname.appendChild(document.createTextNode(rs.getString("Pname")));
                project.appendChild(pname);

                Element pnumber = document.createElement("Pnumber");
                pnumber.appendChild(document.createTextNode(rs.getString("Pnumber")));
                project.appendChild(pnumber);

            } while (rs.next());
        }
        rs.close();
        return project;
    }
    public static BasicDBObject getProjectDoc(String pno, Connection connection) throws Exception {
        Statement stmt = connection.createStatement();
        String query = "select * from project where pnumber = "+pno;
        ResultSet rs = stmt.executeQuery(query);
        BasicDBObject dbObject = new BasicDBObject();
        if (rs.next())  {
            do {
                dbObject.put("Pname", rs.getString("Pname"));
                dbObject.put("Pnumber", rs.getString("Pnumber"));
            } while (rs.next());
        }
        rs.close();
        return dbObject;
    }
    public static String getHours(String pno, String ssn, Connection connection) throws Exception {
        Statement stmt = connection.createStatement();
        String query = "select * from works_on where pno = "+pno+" and essn = "+ssn;
        ResultSet rs = stmt.executeQuery(query);
        String hours = new String();
        if (rs.next())  {
            do {
                hours = rs.getString("hours");
            } while (rs.next());
        }
        rs.close();
        return hours;
    }
    public static String getDepartmentName(String dno, Connection connection) throws Exception {
        Statement stmt = connection.createStatement();
        String query = "select * from department where dnumber = "+dno;
        ResultSet rs = stmt.executeQuery(query);
        String dptName = new String();
        if (rs.next())  {
            do {
                dptName =  rs.getString("dname");
            } while (rs.next());
        }
        rs.close();
        return dptName;
    }
}
