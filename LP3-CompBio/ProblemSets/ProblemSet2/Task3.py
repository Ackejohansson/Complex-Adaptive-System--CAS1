import numpy as np
import matplotlib.pyplot as plt
from scipy import stats
from scipy.stats import cauchy


def update_theta(theta, k, N, omega, dt):
    diff = theta[:, np.newaxis] - theta[np.newaxis, :]
    theta += dt * (omega + k / N * (np.sin(diff)).sum(axis=0))
    return theta


def calculate_r(theta, N):
    return np.abs(np.sum(np.exp(1j * theta)) / N)


def main():
    N = np.array([20, 100, 300])
    N = 20
    gamma = .1
    Kc = 2 * gamma
    dt = 1/100
    time_max = 50
    r = np.zeros(int(time_max/dt))

    K = Kc*0.08
    omega = cauchy.rvs(scale=0.1, size=N) * gamma / np.pi
    theta = np.random.uniform(low=-np.pi/2, high=np.pi/2, size=N)

    for t in range(int(time_max/dt)):
        theta = update_theta(theta, K, N, omega, dt)
        r[t] = calculate_r(theta, N)

    plt.plot(r)
    plt.show()

if __name__ == '__main__':
    main()
