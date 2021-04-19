from time import time
import numpy as np
from random import random
from operator import add

from pyspark.sql import SparkSession

spark = SparkSession.builder.appName('PiEstimator').getOrCreate()
sc = spark.sparkContext

#n is the number of times the sample will be taken, as n increases accuracy of PI incre$
n = 1000000


def isPointInsideCircle(p):
    x, y = random(), random()
    return 1 if x*x + y*y < 1 else 0


startingTime = time()

# parallelize creates a spark Resilient Distributed Dataset (RDD)
# its values are useless in this case
# but allows us to distribute our calculation (inside function) across multiple nodes

# count stores how many times a randomly sampled point falls in unit circle.
# We get the value of PI by taking the ratio of count to n and multiplying it with 4. 
# It is because areaOfUnitCircle/areaOfUnitCircle = 4* PI.
# We divide both sides by 4 and we can estimate PI. 
 
count = sc.parallelize(range(0, n)).map(isPointInsideCircle).reduce(add)
print(np.round(time()-startingTime, 3), "seconds elapsed with  n=", n)
print("Pi as estimated by Monte Carlo Method is  %f" % (4.0 * count / n))

spark.stop()