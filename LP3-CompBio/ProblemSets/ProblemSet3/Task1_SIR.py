import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm, expon

bd_vals = [
    (0.1, 0.2),
    (1, 2),
    (10, 5)]
iterations = int(1e5)
b_t = np.zeros((len(bd_vals), iterations))
d_t = np.zeros((len(bd_vals), iterations))
dt = 1e-3

# Task d)
N = 10000
alpha = 2
beta = 1
n0 = N * (1-beta/alpha)
time_max = 10000
nRun = 2000
population = np.zeros((nRun, int(time_max/dt-1)))


def bn():
    return alpha*population*(1-population/N)


def dn():
    return beta*population


def time_to_event(a):
    t = 0
    while True:
        r = np.random.rand()
        t += dt
        if r < a * dt:
            break
    return t


def simulation_c(b, d, index):
    for n in range(iterations):
        b_t[index, n] = time_to_event(b)
        d_t[index, n] = time_to_event(d)


def simulation():
    time_to_event(dn())


def plot(index, b, d):
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(10, 5), constrained_layout=True)

    _, bins_b, _ = ax1.hist(b_t[index, :], bins=100, log=True, density=True, label=f'$b_n$={b}'
                            )
    params_b = expon.fit(b_t[index, :], floc=0)
    Y_b = expon.pdf(bins_b, *params_b)
    ax1.plot(bins_b, Y_b, label=f'$\lambda=$ {round(1/params_b[1], 3)}')
    ax1.set_ylabel('Log( Probability )')
    ax1.set_xlabel('Time until event')

    _, bins_d, _ = ax2.hist(d_t[index, :], bins=100, log=True, density=True, label=f'$d_n$={d}')
    params_d = expon.fit(d_t[index, :], floc=0)
    Y_d = expon.pdf(bins_d, *params_d)
    ax2.plot(bins_d, Y_d, label=f'$\lambda=$ {round(1/params_d[1], 3)}')

    ax2.set_xlabel('Time until event')

    fig.suptitle('Histogram over probability distribution', fontsize=16)
    ax1.legend()
    ax2.legend()
    plt.show()


def main():
    for index in range(len(bd_vals)):
        b, d = bd_vals[index]
        simulation_c(b, d, index)
        plot(index, b, d)




if __name__ == '__main__':
    main()
