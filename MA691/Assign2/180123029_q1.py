import numpy as np
print("------------------Q1----------------\n")

# generating initial normal random sample of size 10 with mean 0, variance 1
initSample = []

for i in range(10):
    initSample.append(np.random.normal(0, 1))

# resampling with replacement and generating new sample
newSample = np.random.choice(initSample, 10)

# Regenerating 1000 more samples for new case
# now verification
# generate 1000 more samples and check the average number of unique elements from the original sample
uniqueNo = []

for i in range(1000):
    sample = np.random.choice(initSample, 10)
    x = np.unique(sample)
    uniqueNo.append(len(x)/10)

print("For Original Sample")
print("Original Sample: ", initSample)
print("Mean: ", np.mean(initSample))
print("Variance: ", np.var(initSample))
print("---------------------------------\n")

print("For New Sample")
print("New Sample using non-parametric bootstrap: ", newSample)
print("Mean: ", np.mean(newSample))
print("Variance: ", np.var(newSample))
print("---------------------------------\n")

print("Avg number of elements from original sample: ", np.mean(uniqueNo))
