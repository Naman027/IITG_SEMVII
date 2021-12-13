import numpy as np
import matplotlib.pyplot as plt

print("------------------Q2----------------\n")

variance = 1
sigma = np.sqrt(variance)
epsilon = np.random.normal(0, sigma, 50)
n = 50
x_axis = np.linspace(1, n, n)
initSample = []
initSample.append(0)

for i in range(1, n):
    elem = initSample[i-1]*0.5 + epsilon[i]
    initSample.append(elem)

plt.plot(x_axis, initSample)
l = 5 # Size of Block

# NON-OVERLAPPING
numBlocks = int(n/l)
blocks = np.reshape(initSample, (numBlocks, l))
indexes = [x for x in range(numBlocks)]
resampleBlock = np.random.choice(indexes, numBlocks)
nonOverlap = []

for i in resampleBlock:
    nonOverlap.extend(blocks[i])
plt.plot(x_axis, nonOverlap)

# MOVING BLOCK
numBlocks = n - l + 1
resampleBlock = np.random.choice(indexes, int(n/l))
movBlock = []

for i in resampleBlock:
    movBlock.extend(initSample[i:i+l])
plt.plot(x_axis, movBlock)

# LOCAL BLOCK
numBlocks = n - l + 1
numBlocksReqd = int(n/l)
resampleBlock = []
delt = 4

for i in range(numBlocksReqd):
    # pick first block randomly
    if i == 0:
        resampleBlock.extend(np.random.choice(indexes, 1))
    else:
        # new block is selected from vicinity of previous block(+/- delt)
        lower_bound = max(0, resampleBlock[i-1] - delt)
        upper_bound = min(numBlocks-1, resampleBlock[i-1] + delt)
        resampleBlock.extend(np.random.choice(indexes[lower_bound:upper_bound+1], 1))

localBlock = []

for i in resampleBlock:
    localBlock.extend(initSample[i:i+l])
plt.plot(x_axis, localBlock)

plt.legend(["Initial Sample", "Non-Overlapping", "Moving Block", "Local Block"])
plt.show()
