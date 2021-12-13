print("_____________________________Q2_____________________________\n")

import numpy as np
import matplotlib.pyplot as plt

variance = 1
sigma = np.sqrt(variance)
epsilon = np.random.normal(0,sigma, 50)
n = 50

x_axis = np.linspace(1,n,n)

initial_sample_array = []
initial_sample_array.append(0)

for i in range(1,n):
    elem = initial_sample_array[i-1]*0.5  + epsilon[i]
    initial_sample_array.append(elem)


plt.plot(x_axis, initial_sample_array)

l = 5

num_blocks = int(n/l)
blocks = np.reshape(initial_sample_array, (num_blocks, l))
indexes = [x for x in range(num_blocks)]

resample_blocks_array = np.random.choice(indexes,num_blocks)
non_overlapping_array = []


for i in resample_blocks_array:
    non_overlapping_array.extend(blocks[i])
plt.plot(x_axis,non_overlapping_array)

num_blocks = n - l + 1
indexes = [x for x in range(num_blocks)]
resample_blocks_array = np.random.choice(indexes,int(n/l))

moving_block_array = []

for i in resample_blocks_array:
    moving_block_array.extend(initial_sample_array[i:i+l])
plt.plot(x_axis,moving_block_array)

num_blocks = n - l + 1

num_blocks_reqd = int(n/l)

resample_blocks_array = []
delta =4

for i in range(num_blocks_reqd):
    if i==0:
        resample_blocks_array.extend(np.random.choice(indexes,1))
    else:
        lower_bound = max(0, resample_blocks_array[i-1]- delta)
        upper_bound = min(num_blocks-1, resample_blocks_array[i-1]+ delta)

        resample_blocks_array.extend(np.random.choice(indexes[lower_bound:upper_bound+1],1))

local_block_array = []

for i in resample_blocks_array:
    local_block_array.extend(initial_sample_array[i:i+l])
plt.plot(x_axis,local_block_array)


plt.legend(["Initial Sample", "Non-Overlapping", "Moving Block", "Local Block"])
plt.show()