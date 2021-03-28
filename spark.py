from pyspark import SparkContext
sc=SparkContext("local", "sumOfCubes")

def sumOfCubes(n):
    l = list(range(n))

    #Creating a RDD
    nums = sc.parallelize(l)

    #Retrieve RDD contents as a local collection
    nums.collect()

    #Pass each element through a function
    cubes = nums.map(lambda x: x * x * x)
    
    #Applying reduce action on RDD produced above
    result = cubes.reduce(lambda x, y: x + y)
    
    return result
