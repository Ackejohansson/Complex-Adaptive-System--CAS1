import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import expon

bd_vals = [
    (0.1, 0.2),
    (1, 2),
    (10, 5)]
iterations = int(1e5)
b_t = np.zeros((len(bd_vals), iterations))
d_t = np.zeros((len(bd_vals), iterations))
dt = 1e-2

# Task d)
N = 1000
alpha = 1.1
beta = 1
time_max = 100
number_of_runs = 6000
population = np.zeros([number_of_runs, int(time_max/dt)], dtype=int)
population[:, 0] = N * (1-beta/alpha)
time_observing = np.array([.2, 0.7, 0.9])*int(time_max/dt)


def bn(run, index):
    return alpha*population[run, index]*(1-population[run, index]/N)


def dn(run, index):
    return beta*population[run, index]


def sample_random_exp(a):
    return np.random.exponential(scale=1/a, size=1)


def time_to_event(a):
    t = 0
    while True:
        r = np.random.rand()
        t += dt
        if r < a * dt:
            return t


def simulation_c(b, d, index):
    for n in range(iterations):
        b_t[index, n] = time_to_event(b)
        d_t[index, n] = time_to_event(d)


def simulation_d():
    for run in range(number_of_runs):
        time, index_old = 0, 0
        while time < time_max:
            if population[run, index_old] == 0:
                population[run, index_old:] = population[run, index_old]
                break
            tb_sample = sample_random_exp(bn(run, index_old))
            td_sample = sample_random_exp(dn(run, index_old))
            time += min(tb_sample, td_sample)
            index = int(time/dt)
            if index > np.size(population, axis=1)-1:
                population[run, index_old:] = population[run, index_old]
                break
            population[run, index_old:index] = population[run, index_old]
            if tb_sample < td_sample:
                population[run, index] = population[run, index_old] + 1
            else:
                population[run, index] = population[run, index_old] - 1
            index_old = index
    plt.plot(population[0,:])
    plt.show()


def plot_histogram():
    for pl in range(3):
        plt.hist(population[:, int(time_observing[pl])], bins=100, density=True)
        plt.show()


def plot(index, b, d):
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(10, 5), constrained_layout=True)

    _, bins_b, _ = ax1.hist(b_t[index, :], bins=100, log=True, density=True, label=f'$b_n$={b}')
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
    #for index in range(len(bd_vals)):
    #    b, d = bd_vals[index]
    #    simulation_c(b, d, index)
    #    plot(index, b, d)
    simulation_d()
    plot_histogram()


if __name__ == '__main__':
    main()
