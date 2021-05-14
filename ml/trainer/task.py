#!/usr/bin/env python
# coding: utf-8

# In[25]:


import os
import json
import tensorflow as tf
from tensorflow.keras import layers
from matplotlib import pyplot as plt

per_worker_batch_size = 100
tf_config = json.loads(os.environ['TF_CONFIG'])
num_workers = len(tf_config['cluster']['worker'])


# In[21]:


(x_train, y_train),(x_test, y_test) = tf.keras.datasets.mnist.load_data()


# In[4]:


x_train=tf.keras.utils.normalize(x_train, axis=1)
x_test=tf.keras.utils.normalize(x_test, axis=1)


# In[5]:


strategy=tf.distribute.experimental.MultiWorkerMirroredStrategy()

with strategy.scope():
    model=tf.keras.models.Sequential()
    model.add(layers.Flatten())
    model.add(layers.Dense(128, activation=tf.nn.relu))
    model.add(layers.Dense(128, activation=tf.nn.relu))
    model.add(layers.Dense(10, activation=tf.nn.softmax))
    model.compile(optimizer='SGD',loss='sparse_categorical_crossentropy',metrics=['accuracy'])
    model.fit(x_train, y_train, epochs=3)


# In[6]:


#Testing the model's accuracy
val_loss, val_acc=model.evaluate(x_test, y_test)
print(val_loss, val_acc)


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




