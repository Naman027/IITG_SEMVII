from sklearn.cluster import KMeans
from sklearn.mixture import GaussianMixture
from sklearn.datasets import load_iris, load_breast_cancer, load_wine
import pandas as pd 
import numpy as np 

print('Question 4')
def get_class_levels(data):
    return len(np.unique(data['target']))

# For Breast Cancer
breast_cancer = load_breast_cancer(as_frame=True)
class_levels = get_class_levels(breast_cancer)
k_means = KMeans(n_clusters=class_levels, random_state=0).fit(breast_cancer['data'].to_numpy())
gmm = GaussianMixture(n_components=class_levels).fit(breast_cancer['data'].to_numpy())
print(gmm.means_, gmm.weights_)
print(k_means.labels_)

# For Iris
iris = load_iris(as_frame=True)
class_levels = get_class_levels(iris)
k_means = KMeans(n_clusters=class_levels, random_state=0).fit(iris['data'].to_numpy())
gmm = GaussianMixture(n_components=class_levels).fit(iris['data'].to_numpy())
print(gmm.means_, gmm.weights_)
print(k_means.labels_)

# For Wine
wine = load_wine(as_frame=True)
class_levels = get_class_levels(wine)
k_means = KMeans(n_clusters=class_levels, random_state=0).fit(wine['data'].to_numpy())
gmm = GaussianMixture(n_components=class_levels).fit(wine['data'].to_numpy())
print(gmm.means_, gmm.weights_)
print(k_means.labels_)


