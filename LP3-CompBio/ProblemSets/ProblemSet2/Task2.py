import numpy as np
import matplotlib.pyplot as plt


def laplace(grid):
    return np.roll(grid,1,axis=0) + np.roll(grid,-1,axis=0) + np.roll(grid,1,axis=1) + np.roll(grid,-1,axis=1) - 4*grid


def update_grid(u, b, v, a):
    u += a - (b + 1) * u + u ** 2 @ v + laplace(u)
    v += b * u - u ** 2 @ v + laplace(v)


def main():
    L = 128
    Du = 1
    Dv = np.array([2.3, 3, 5, 9])
    a = 3
    b = 8
    steady_u = a
    steady_v = b / a
    grid = np.zeros((L, L))
    u = np.random.uniform(low=0.9 * steady_u, high=1.1 * steady_u, size=(L, L))
    v = np.random.uniform(low=0.9 * steady_v, high=1.1 * steady_v, size=(L, L))


if __name__ == '__main__':
    main()
