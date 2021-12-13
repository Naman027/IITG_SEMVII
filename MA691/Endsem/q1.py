# Importing General libraries
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
 
# Importing keras
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import LSTM
 
from sklearn.preprocessing import MinMaxScaler
min_max_scaler = MinMaxScaler()
 
# Reading dataset
df = pd.read_csv("./BitcoinPrice.csv")
df_norm = df.drop(['Timestamp'], 1, inplace=True)
daysPrediction = 20
df_train= df[:len(df)-daysPrediction]
df_test= df[len(df)-daysPrediction:]
 
# Encoding categorical data
training_set = df_train.values
training_set = min_max_scaler.fit_transform(training_set)
 
x_set = training_set[0:len(training_set)-1]
y_set = training_set[1:len(training_set)]
x_set = np.reshape(x_set, (len(x_set), 1, 1))
 
num_units = 4
activation_function = 'sigmoid'
optimizer = 'adam'
loss_function = 'mean_squared_error'
batch_size = 5
num_epochs = 100
 
# Initialize the RNN
helper = Sequential()
 
# Adding the input layer and the LSTM layer
helper.add(LSTM(units = num_units, activation = activation_function, input_shape=(None, 1)))
 
# Adding the output layer
helper.add(Dense(units = 1))
 
# Compiling the RNN
helper.compile(optimizer = optimizer, loss = loss_function)
 
# Using the training set to train the model
helper.fit(x_set, y_set, batch_size = batch_size, epochs = num_epochs)
 
test_set = df_test.values
 
inputs = np.reshape(test_set, (len(test_set), 1))
inputs = min_max_scaler.transform(inputs)
inputs = np.reshape(inputs, (len(inputs), 1, 1))
 
predicted_price = helper.predict(inputs)
predicted_price = min_max_scaler.inverse_transform(predicted_price)
 
plt.figure(figsize=(15, 15), dpi=80, facecolor = 'w', edgecolor = 'k')
 
plt.plot(test_set[:, 0], color='green', label='Real BTC Price')
plt.plot(predicted_price[:, 0], color = 'red', label = 'Predicted BTC Price')
 
plt.title('BTC Price Prediction', fontsize = 25)
plt.xlabel('Time', fontsize=25)
plt.ylabel('BTC Price(USD)', fontsize = 25)
plt.legend(loc = 'best')
plt.show()
