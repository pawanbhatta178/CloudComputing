
#Copying already running cluster configuration into local 
gcloud dataproc  clusters  export cluster-898a --destination cluster.yaml --region us-central1

#Running a cluster using the yaml file
gcloud dataproc clusters import my-hadoop-cluster --source cluster.yaml --region us-central1

#Downloading the text version of our text file
pawanbhatta178@cluster-898a-m:~$ wget https://www.gutenberg.org/files/1342/1342-0.txt

#Copying the file into a folder that I want to share with my HDFS cluster
pawanbhatta178@cluster-898a-m:~$ sudo cp 1342-0.txt ./hadoopFiles/prideAndPrejudice.txt

#Checking if the file was successfully created
pawanbhatta178@cluster-898a-m:~$ cd hadoopFiles/
pawanbhatta178@cluster-898a-m:~/hadoopFiles$ ls
prideAndPrejudice.txt

#Saving the text file into HDFS cluster
pawanbhatta178@cluster-898a-m:~$ hadoop fs -copyFromLocal ./hadoopFiles /
pawanbhatta178@cluster-898a-m:~$ hadoop fs -ls /
Found 3 items
drwxr-xr-x   - pawanbhatta178 hadoop          0 2021-04-18 17:10 /hadoopFiles
drwxrwxrwt   - hdfs           hadoop          0 2021-04-18 13:49 /tmp
drwxrwxrwt   - hdfs           hadoop          0 2021-04-18 13:52 /user

#Running the python code
pawanbhatta178@cluster-898a-m:~$ spark-submit wordCount2.py

#Output
pawanbhatta178@cluster-898a-m:~$ hadoop fs -cat /A9/part-00000
('', 73700)
('the', 4216)
('to', 4123)
('of', 3667)
('and', 3309)
('a', 1944)
('her', 1856)
('in', 1817)
('was', 1796)
('I', 1725)
('that', 1417)
('not', 1363)
('she', 1303)
('be', 1209)
('his', 1166)
('had', 1125)
('as', 1119)
('with', 1040)
('he', 1039)
('for', 1003)


#Result of Monte Carlo Method for estimating Pi
pawanbhatta178@cluster-898a-m:~$ spark-submit piEstimator.py
21/04/18 22:55:08 INFO org.spark_project.jetty.util.log: Logging initialized @3000ms
21/04/18 22:55:08 INFO org.spark_project.jetty.server.Server: jetty-9.3.z-SNAPSHOT, build timestamp: unknown, git hash: unknown
21/04/18 22:55:08 INFO org.spark_project.jetty.server.Server: Started @3113ms
21/04/18 22:55:08 INFO org.spark_project.jetty.server.AbstractConnector: Started ServerConnector@6f6720c6{HTTP/1.1,[http/1.1]}{0.0.0.0:36841}
21/04/18 22:55:09 INFO org.apache.hadoop.yarn.client.RMProxy: Connecting to ResourceManager at cluster-898a-m/10.128.0.7:8032
21/04/18 22:55:09 INFO org.apache.hadoop.yarn.client.AHSProxy: Connecting to Application History server at cluster-898a-m/10.128.0.7:10200
21/04/18 22:55:09 INFO org.apache.hadoop.conf.Configuration: resource-types.xml not found
21/04/18 22:55:09 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Unable to find 'resource-types.xml'.
21/04/18 22:55:09 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Adding resource type - name = memory-mb, units = Mi, type = COUNTABLE
21/04/18 22:55:09 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Adding resource type - name = vcores, units = , type = COUNTABLE
21/04/18 22:55:11 INFO org.apache.hadoop.yarn.client.api.impl.YarnClientImpl: Submitted 
application application_1618753755784_0005
5.34 seconds elapsed with  n= 1000000
Pi as estimated by Monte Carlo Method is  3.141352
21/04/18 22:55:24 INFO org.spark_project.jetty.server.AbstractConnector: Stopped Spark@6
f6720c6{HTTP/1.1,[http/1.1]}{0.0.0.0:0}