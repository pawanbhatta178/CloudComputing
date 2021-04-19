#Python code that returns top 20 frequently used word using " " delimiter.

import sys

from pyspark import SparkContext, SparkConf
 
if __name__ == "__main__":
        
        # create Spark context with necessary configuration
        sc = SparkContext("local","PySpark Word Count Exmaple")
        
        # read data from text file and split each line into words
        words = sc.textFile("/hadoopFiles/prideAndPrejudice.txt").flatMap(lambda line: line.split(" "))
        
        # count the occurrence of each word
        wordCounts = words.map(lambda word: (word, 1)).reduceByKey(lambda a,b:a +b)
        
        sortedCount=wordCounts.sortBy(lambda a:a[1], ascending=False)
        
        top20=sortedCount.take(20)
        
        # save the counts to output
        sc.parallelize(top20).saveAsTextFile("/A9")
