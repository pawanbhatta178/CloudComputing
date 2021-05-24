#!/usr/bin/env python
# coding: utf-8



import os
import json
import tensorflow as tf
from tensorflow.keras import layers
from matplotlib import pyplot as plt

per_worker_batch_size = 64
tf_config = json.loads(os.environ['TF_CONFIG'])
num_workers = len(tf_config['cluster']['worker'])

print(tf_config)

(x_train, y_train),(x_test, y_test) = tf.keras.datasets.mnist.load_data()

x_train=tf.keras.utils.normalize(x_train, axis=1)
x_test=tf.keras.utils.normalize(x_test, axis=1)


strategy=tf.distribute.experimental.ParameterServerStrategy(
    cluster_resolver=None,
    variable_partitioner=None)
    
coordinator = tf.distribute.experimental.coordinator.ClusterCoordinator(
    strategy=strategy
    )


with strategy.scope():
    model=tf.keras.models.Sequential()
    model.add(layers.Flatten())
    model.add(layers.Dense(128, activation=tf.nn.relu))
    model.add(layers.Dense(128, activation=tf.nn.relu))
    model.add(layers.Dense(10, activation=tf.nn.softmax))
    model.compile(optimizer='SGD',loss='sparse_categorical_crossentropy',metrics=['accuracy'])
    model.fit(x_train, y_train, batch_size=per_worker_batch_size, epochs=3)



#Testing the model's accuracy
val_loss, val_acc=model.evaluate(x_test, y_test)
print(val_loss, val_acc)







