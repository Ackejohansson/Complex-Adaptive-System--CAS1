import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm, expon

bd_vals = [
    (0.1, 0.2),
    (1, 2),
    (10, 5)]
n_0 = 10  # ??
iterations = int(1e3)
b_t = np.zeros((len(bd_vals), iterations))
d_t = np.zeros((len(bd_vals), iterations))
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


def plot(index):
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(10, 5), constrained_layout=True)

    n, bins, _ = ax1.hist(b_t[index, :], bins=100, log=True, density=True)
    params_b = expon.fit(b_t[index, :], floc=0)
    Y_b = expon.pdf(bins, *params_b)
    ax1.plot(bins, Y_b)
    
    n, bins, _ = ax2.hist(d_t[index, :], bins=100, log=True, density=True)
    params_d = expon.fit(d_t[index, :], floc=0)
    Y_d = expon.pdf(bins, *params_d)
    ax2.plot(bins, Y_d)
    ax1.ylabel("Log(occurrences)")

    plt.show()


def main():
    for index in range(len(bd_vals)):
        b, d = bd_vals[index]
        simulation(b, d, index)
        plot(index)


if __name__ == '__main__':
    main()
