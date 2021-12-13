import numpy as np
import matplotlib.pyplot as plt

mu = [10, 3]
sigma = [1, 1]
p_i = [0.4, 0.6]
n = 10000
print("Question 3")

def univariate_normal(x, mean, variance):
    """pdf of the univariate normal distribution."""
    return ((1. / np.sqrt(2 * np.pi * variance)) * 
            np.exp(-(x - mean)**2 / (2 * variance)))

x = []
for i in range(n):
    z_i = np.argmax(np.random.multinomial(1, p_i))
    x_i = np.random.normal(mu[z_i], sigma[z_i])
    x.append(x_i)

a = np.arange(-7, 18, 0.01)
y = p_i[0] * univariate_normal(a, mean=mu[0], variance=sigma[0]*2) + p_i[1] * univariate_normal(a, mean=mu[1], variance=sigma[0]*2)

fig, ax = plt.subplots(figsize=(8, 4))
ax.hist(x, bins=100, density=True)
ax.plot(a, y)
plt.savefig("Q3_MultiNormal.png")
