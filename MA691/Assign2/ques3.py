import numpy as np
import math
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import PolynomialFeatures
from sklearn.pipeline import Pipeline
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import cross_val_score
from sklearn.metrics import mean_squared_error as mse
from numpy import loadtxt

x = [(i+1) for i in range(36)]
y = loadtxt("FRWRD.txt", delimiter="\n", unpack=False)

x = np.array(x)
y = np.array(y)
num = 36



def create_polynomial_regression_model(degree,k_fold):
 poly_features = PolynomialFeatures(degree=degree)
 X_poly = poly_features.fit_transform(x.reshape(-1,1))
 poly = LinearRegression()
 return np.mean(cross_val_score(poly, X_poly, y.reshape(-1,1), cv=k_fold,scoring='neg_mean_squared_error'))

p3_err = create_polynomial_regression_model(3,10)
p6_err = create_polynomial_regression_model(6,10)
p8_err = create_polynomial_regression_model(8,10)

print(p3_err)
print(p6_err)
print(p8_err)
  


lm=LinearRegression()
lm.fit(x.reshape(-1,1),y.reshape(-1,1))

Input3=[('polynomial',PolynomialFeatures(degree=3)),('modal',LinearRegression())]
pipe3=Pipeline(Input3)
pipe3.fit(x.reshape(-1,1),y.reshape(-1,1))

poly_pred3=pipe3.predict(x.reshape(-1,1))
#sorting predicted values with respect to predictor
sorted_zip3 = sorted(zip(x,poly_pred3))
x_poly3, poly_pred3 = zip(*sorted_zip3)
#plotting predictions

Input6=[('polynomial',PolynomialFeatures(degree=6)),('modal',LinearRegression())]
pipe6=Pipeline(Input6)
pipe6.fit(x.reshape(-1,1),y.reshape(-1,1))

poly_pred6=pipe6.predict(x.reshape(-1,1))
#sorting predicted values with respect to predictor
sorted_zip6 = sorted(zip(x,poly_pred6))
x_poly6, poly_pred6 = zip(*sorted_zip6)
#plotting predictions


Input8=[('polynomial',PolynomialFeatures(degree=8)),('modal',LinearRegression())]
pipe8=Pipeline(Input8)
pipe8.fit(x.reshape(-1,1),y.reshape(-1,1))

poly_pred8=pipe8.predict(x.reshape(-1,1))
#sorting predicted values with respect to predictor
sorted_zip8 = sorted(zip(x,poly_pred8))
x_poly8, poly_pred8 = zip(*sorted_zip8)

#plotting predictions
# plt.figure(figsize=(10,6))
plt.scatter(x,y,s=15,label='Original points')
plt.plot(x_poly3,poly_pred3,label='Polynomial Regression: Degree 3')
plt.plot(x_poly6,poly_pred6,label='Polynomial Regression: Degree 6')
plt.plot(x_poly8,poly_pred8,label='Polynomial Regression: Degree 8')

plt.legend()
plt.show()

