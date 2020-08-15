Whole project with input files and output files has been submitted.

First, we have converted the input txt files into csv files that has been placed in folder named “input”.

The csv files were used to import the data into myql relational database.

If you want you can directly import sql file to your database, with the database name as “project2”. We
have provided the sql file under “input” folder the sql file.

We have used mysql database with name “project2” whose username is “root” and password is
“123456”.

We have also created database named “mydatabase” in mongodb

In the source code, we have connected to both relational database as well as mongodb to store data in
json format in mongodb.

Json output files were created by commands:
mongoexport --collection=collectionForEmployees --db=mydatabase --out=employees.json
mongoexport --collection=collectionForProjects --db=mydatabase --out=projects.json
mongoexport --collection=collectionForDepartments --db=mydatabase --out=departments.json

Here the above collections were created from the java code.
We have attached these json files in folder “output”. We have also made a Queries Output text file for
the result of the queries from MongoDB.

We have provided the required XML file in the XML folder.
Steps to run the project.
1) Install mongodb and mysql
2) Add mysql-connector-java-8.0.15.jar and mongo-java-driver-3.11.2.jar into your project.
3) Run MongoDb.java.

References :-
https://howtodoinjava.com/mongodb/java-mongodb-insert-documents-in-collection-examples/
https://examples.javacodegeeks.com/core-java/xml/parsers/documentbuilderfactory/create-xml-file-in-
java-using-dom-parser-example/
https://stackoverflow.com/questions/139076/how-to-pretty-print-xml-from-java
