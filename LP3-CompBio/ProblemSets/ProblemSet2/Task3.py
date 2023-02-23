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
    gamma = .1
    N = np.array([20, 100, 300])
    N = 20
    Kc = 2 * gamma
    K = np.array([0.08,1.01, 2])*Kc
    dt = 1/100
    time_max = 50
    r = np.zeros((3,int(time_max/dt)))

    omega = cauchy.rvs(scale=0.1, size=N) * gamma / np.pi #TODO change this guy
    theta = np.random.uniform(low=-np.pi/2, high=np.pi/2, size=N)

    fig, axes = plt.subplots(1,3, constrained_layout=True, figsize=(10,3))
    for i,k in enumerate(K):
        ax = axes[i]
        for t in range(int(time_max/dt)):
            theta = update_theta(theta, k, N, omega, dt)
            r[i,t] = calculate_r(theta, N)
        ax.set_title(f"K={K[i]}")
        ax.plot(r[i, :])
    plt.show()


if __name__ == '__main__':
    main()
