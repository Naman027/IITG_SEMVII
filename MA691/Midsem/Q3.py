import numpy as np
import scipy.stats

mu, sigma = 0, 5 # mean and standard deviation
s = np.random.normal(mu, sigma, 100)

param_alpha = (5+100)/2
param_beta = (1+sum(i*i for i in s))/2;
print('Alpha = ',param_alpha)
print('Beta = ',param_beta)
print("--------------------------------------------")

i = 0
generated_random = []
while(i<30):
    val = scipy.stats.invgamma.rvs(param_alpha, loc=0, scale=param_beta)
    i=i+1
    generated_random.append(val)
    
print("Random Values from Inv Gamma distribution")
print(generated_random)

# Bayes Estimate
bayes_estimate = np.mean(generated_random)
std = np.std(generated_random)
print('Bayes_estimate = ',bayes_estimate)
