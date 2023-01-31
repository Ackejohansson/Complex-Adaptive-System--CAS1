import numpy as np
from ddeint import ddeint
import matplotlib.pyplot as plt


def main():
    T = 0.1
    A = 20
    K = 100
    r = 0.1
    ts = np.linspace(0, 3.0, num=5)
    ns = ddeint(Nprim, initial_population, ts, fargs=(r, A, K, T))
    plt.plot(ts, ns)
    plt.show()

def Nprim(population, t, r, a, k, time_delay):
    return r*population(t)*(1 - population(t - time_delay) / k)*(population(t) / a - 1)


def initial_population(t):
    return 50.


if __name__ == '__main__':
    main()

