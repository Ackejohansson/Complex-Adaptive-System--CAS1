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


def plot(index, b, d):
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(10, 5), constrained_layout=True)

    _, bins_b, _ = ax1.hist(b_t[index, :], bins=100, log=True, density=True, label=b)
    params_b = expon.fit(b_t[index, :], floc=0)
    Y_b = expon.pdf(bins_b, *params_b)
    ax1.plot(bins_b, Y_b, label=1/params_b[1])
    ax1.set_ylabel('Log( Probability )')
    ax1.set_xlabel('Time until event')

    _, bins_d, _ = ax2.hist(d_t[index, :], bins=100, log=True, density=True, label=d)
    params_d = expon.fit(d_t[index, :], floc=0)
    Y_d = expon.pdf(bins_d, *params_d)
    ax2.plot(bins_d, Y_d, label=1/params_d[1])
    ax2.set_xlabel('Time until event')

    fig.suptitle('Histogram over probability distribution', fontsize=16)
    ax1.legend()
    ax2.legend()
    plt.show()


def main():
    for index in range(len(bd_vals)):
        b, d = bd_vals[index]
        simulation(b, d, index)
        plot(index, b, d)


if __name__ == '__main__':
    main()
