
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
