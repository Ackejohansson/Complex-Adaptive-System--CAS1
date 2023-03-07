import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import cauchy


gamma = .1
N = np.array([20, 100, 300])
N = 20
K = np.array([0.1, 0.23, 1])
dt = 1 / 10
time_max = 100
r = np.zeros((3, int(time_max / dt)))


def compute_theta_difference(theta):
    return np.angle(np.exp(1j * theta[:, np.newaxis]) - np.exp(1j * theta[np.newaxis, :]))


def update_theta(theta, k, N, omega, dt):
    diff = compute_theta_difference(theta)
    theta += dt * (omega + k/N * (np.sin(diff)).sum(axis=0))
    return theta


def calculate_r(theta, N):
    return np.absolute(np.sum(np.exp(1j * theta)))/N


def run_simulation(i, k, axes):
    omega = cauchy.rvs(loc=0, scale=gamma, size=N)
    theta = np.random.uniform(low=-np.pi / 2, high=np.pi / 2, size=N)
    for t in range(int(time_max / dt)):
        theta = update_theta(theta, k, N, omega, dt)
        r[i, t] = calculate_r(theta, N)
        ax = axes[i]
        ax.set_title(f"K={K[i]}, N={N}")
        ax.plot(np.array(range(len(r[i, :]))) * dt, r[i, :])
        ax.set_xlabel("Time (t)")
        ax.set_ylabel("Order parameter (r)")


def main():
    fig, axes = plt.subplots(1, 3, constrained_layout=True, figsize=(10, 3))
    for i, k in enumerate(K):
        run_simulation(i, k, axes)

    plt.show()


if __name__ == '__main__':
    main()
