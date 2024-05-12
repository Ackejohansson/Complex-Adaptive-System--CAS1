import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import os

# Read the CSV file
data = pd.read_csv(os.path.join('data', 'grassMean.csv'))

# Extract the time and grassMean columns using column indices
time_column_index = 0
grass_mean_column_index = 1

time = data.iloc[:, time_column_index]
grass_mean = data.iloc[:, grass_mean_column_index]

# Create a linearly spaced array for x-axis
x = np.linspace(0, 20, len(grass_mean))

# Create a line plot
plt.plot(x, grass_mean)
plt.xlabel('Time (days)')
plt.ylabel('Grass Mean')
plt.title('Grass Mean over Time')
plt.grid(True)

# Set x-axis tick format to integers
plt.xticks(np.arange(0, 21, 1))

plt.savefig('figures/mean3.png')
plt.show()
