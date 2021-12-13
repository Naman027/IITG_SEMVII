import numpy as np 
import pandas as pd
import matplotlib.pyplot as plt
import sklearn
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
from sklearn.metrics import recall_score
from sklearn.metrics import precision_score
from sklearn.metrics import confusion_matrix
from sklearn.model_selection import train_test_split

#Logistic Regression

file = pd.read_csv("ecoli.csv")
df = file.values
X = df[:,0:7]
y = df[:,7]

clf = LogisticRegression()
clf = clf.fit(X,y)

X_train, X_test, y_train, y_test = train_test_split(X, y)

clf.fit(X_train,y_train)
y_pred = clf.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)
print('Accuracy Score',accuracy*100)
precision = precision_score(y_test, y_pred)
print('Precision Score',precision*100)
recall = recall_score(y_test, y_pred, average = 'macro')
print('Recall Score',recall*100)
conf_mat = confusion_matrix(y_true=y_test, y_pred=y_pred)
print('Confusion matrix:\n', conf_mat)
