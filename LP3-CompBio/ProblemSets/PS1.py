import numpy as np
from ddeint import ddeint
import matplotlib.pyplot as plt


def main():
    T = 0.1
    A = 20
    K = 100
    r = 0.1
    ts = np.linspace(0, 20, 1000)
    ns = ddeint(Nprim, initial_population, ts, fargs=(r, A, K, T))
    plt.plot(ts, ns)
    plt.show()


def Nprim(N, t, r, A, K, T):
    return r*N(t)*(1-N(t-T)/K)*(N(t)/A-1)


def initial_population(t):
    return 50.


if __name__ == '__main__':
    main()

