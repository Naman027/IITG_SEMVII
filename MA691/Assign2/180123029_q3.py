import numpy as np
import math
import matplotlib.pyplot as plt
import pandas as pd
from numpy import loadtxt
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import PolynomialFeatures
from sklearn.pipeline import Pipeline
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import cross_val_score
from sklearn.metrics import mean_squared_error as mse

print("------------------Q3----------------\n")

x = [(i+1) for i in range(36)]
y = loadtxt("FRWRD.txt", delimiter="\n", unpack=False)
x = np.array(x)
y = np.array(y)
N = 36

def polyRegressionModel(degree, k_fold):
    poly_features = PolynomialFeatures(degree=degree)
    X_poly = poly_features.fit_transform(x.reshape(-1, 1))
    poly = LinearRegression()
    return np.mean(cross_val_score(poly, X_poly, y.reshape(-1, 1), cv=k_fold, scoring='neg_mean_squared_error'))

err_Poly3 = polyRegressionModel(3, 10)
print("Error in Polynomial 3")
print(err_Poly3)

err_Poly6 = polyRegressionModel(6, 10)
print("Error in Polynomial 6")
print(err_Poly6)

err_Poly8 = polyRegressionModel(8, 10)
print("Error in Polynomial 8")
print(err_Poly8)

lm = LinearRegression()
lm.fit(x.reshape(-1, 1), y.reshape(-1, 1))
plt.scatter(x, y, s=15, label='Original Pts')

print("Calc for degree 3")
Inp3 = [('polynomial', PolynomialFeatures(degree=3)),('modal', LinearRegression())]
pipe3 = Pipeline(Inp3)
pipe3.fit(x.reshape(-1, 1), y.reshape(-1, 1))
predPoly3 = pipe3.predict(x.reshape(-1, 1))
sortZip3 = sorted(zip(x, predPoly3))
xPolyfor3, predPoly3 = zip(*sortZip3)
plt.plot(xPolyfor3, predPoly3, label='Polynomial Reg for degree -- 3')

print("Calc for degree 6")
Inp6 = [('polynomial', PolynomialFeatures(degree=6)),('modal', LinearRegression())]
pipe6 = Pipeline(Inp6)
pipe6.fit(x.reshape(-1, 1), y.reshape(-1, 1))
predPoly6 = pipe6.predict(x.reshape(-1, 1))
sortZip6 = sorted(zip(x, predPoly6))
xPolyfor6, predPoly6 = zip(*sortZip6)
plt.plot(xPolyfor6, predPoly6, label='Polynomial Reg for degree -- 6')

print("Calc for degree 8")
Inp8 = [('polynomial', PolynomialFeatures(degree=8)),('modal', LinearRegression())]
pipe8 = Pipeline(Inp8)
pipe8.fit(x.reshape(-1, 1), y.reshape(-1, 1))
predPoly8 = pipe8.predict(x.reshape(-1, 1))
sortZip8 = sorted(zip(x, predPoly8))
xPolyfor8, predPoly8 = zip(*sortZip8)
plt.plot(xPolyfor8, predPoly8, label='Polynomial Reg for degree -- 8')

plt.legend()
plt.show()
