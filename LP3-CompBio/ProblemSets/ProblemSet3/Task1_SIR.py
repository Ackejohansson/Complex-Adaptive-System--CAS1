import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm, expon

bd_vals = [
    (0.1, 0.2),
    (1, 2),
    (10, 5)]
n_0 = 10  # ??
iterations = 1000
b_t = np.zeros((3, iterations))
d_t = np.zeros((3, iterations))
dt = 1e-3


def time_to_event(a):
    t = 0
    while True:
        r = np.random.rand()
        t += dt
        if r < a * dt:
            break
    return t


def simulation(b, d, index):
    for n in range(iterations):
        b_t[index, n] = time_to_event(b)
        d_t[index, n] = time_to_event(d)


def plot():
    for i in range(3):
        n, bins, _ = plt.hist(b_t[i, :], bins=100, log=True, density=True)
        params = expon.fit(b_t[i, :], floc=0)
        Y = expon.pdf(bins, *params)
        plt.plot(bins, Y)
        plt.show()


def main():
    for index in range(3):
        b, d = bd_vals[index]
        simulation(b, d, index)
    plot()


if __name__ == '__main__':
    main()
