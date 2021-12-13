print("_____________________________Q1_____________________________\n")

import numpy as np

# generating initial normal random sample of size 10 with mean 0, variance 1
inital_sample = []

for i in range(10):
    inital_sample.append(np.random.normal(0,1))

#resampling with replacement and generating new sample
new_sample = np.random.choice(inital_sample,10)

print("Regenerating 1000 more samples")
#now verification
#generate 1000 more samples and check the average number of unique elements from the original sample
num_unique = []


for i in range(1000):
    sample = np.random.choice(inital_sample,10)
    x = np.unique(sample)
    num_unique.append(len(x)/10)

print("Original Sample: ",inital_sample)
print("Mean: ", np.mean(inital_sample))
print("Variance: ", np.var(inital_sample))
print("__________________________________________________________\n")
print("New Sample using non-parametric bootstrap: ", new_sample)
print("Mean: ", np.mean(new_sample))
print("Variance: ", np.var(new_sample))
print("__________________________________________________________\n")

print("Avg number of elements from original sample: ",np.mean(num_unique))



