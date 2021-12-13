from sklearn.linear_model import Ridge
from sklearn.linear_model import Lasso
from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import KFold
from sklearn.metrics import mean_squared_error
import numpy as np
import matplotlib.pyplot as plt
y = []
with open("FRWRD.txt", 'r') as f:
    for line in f.readlines():
        try:
            y.append(float(line))
        except:
            pass
y = np.asarray(y)
x = np.asarray([i for i in range(1,37)]).reshape(-1,1)
m = 8

print(f"Polynomial degree : {m}")
poly = PolynomialFeatures(degree = m)
X_poly = poly.fit_transform(x)

kf = KFold(n_splits=6, shuffle=True, random_state=0)
i = 0 
print("Metric used: Mean squared error")
for train, test in kf.split(X_poly):
    i = i+1
    X_train, y_train, X_validation, y_validation = X_poly[train], y[train], X_poly[test], y[test] 
    model = LinearRegression()
    model.fit(X_train, y_train)
    y_hat_train = model.predict(X_train)
    y_hat_val = model.predict(X_validation)
    print(f"Fold {i}:\n train set: {mean_squared_error(y_hat_train,y_train)} \n val set: {mean_squared_error(y_hat_val,y_validation)}")

not_best = model

def score_model(model,X_train,y_train,X_test,y_test):
    y_hat_train = model.predict(X_train)
    y_hat_val = model.predict(X_validation)
    return mean_squared_error(y_hat_train,y_train),mean_squared_error(y_hat_val,y_validation)

X_train, X_test, y_train, y_test=train_test_split(X_poly,y,test_size=0.3)

for alp in [0.01, 0.1,1, 10,100]:
    rr = Ridge(alpha=alp)
    rr.fit(X_train, y_train)
    Ridge_score = score_model(rr, X_train,y_train, X_test, y_test)
    print(f"for alpha = {alp}, score fpr train and test set is {Ridge_score}")

for alp in [0.01, 0.1,1, 10,100]:
    rr = Lasso(alpha=alp)
    rr.fit(X_train, y_train)
    Ridge_score = score_model(rr, X_train,y_train, X_test, y_test)
    print(f"for alpha = {alp}, score fpr train and test set is {Ridge_score}")


plt.plot(x, model.predict(X_poly))
plt.plot(x, rr.predict(X_poly))
print("--------------------------------------------")

plt.legend(["Not best","Regularised", "True label"],loc='upper right')
plt.scatter(x,y)
plt.show()