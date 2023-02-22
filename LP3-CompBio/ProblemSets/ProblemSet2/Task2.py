import numpy as np
import matplotlib.pyplot as plt
from numpy.linalg import matrix_power


def laplace(grid):
    return np.roll(grid,1,axis=0) + np.roll(grid,-1,axis=0) + np.roll(grid,1,axis=1) + np.roll(grid,-1,axis=1) - 4*grid


def update_u(u, b, v, a, dt):
    return (a - (b+1)*u + (u**2)*v + laplace(u))*dt


def update_v(u, b, v, Dv, dt):
    return (b*u - u**2*v + Dv[0]*laplace(v))*dt


def main():
    time_steps = 5000
    dt = 1/100
    L = 128
    Du = 1
    Dv = np.array([2.3, 3, 5, 9])
    a = 3
    b = 8
    steady_u = a
    steady_v = b/a
    u = np.random.uniform(low=0.9 * steady_u, high=1.1 * steady_u, size=(L, L))
    v = np.random.uniform(low=0.9 * steady_v, high=1.1 * steady_v, size=(L, L))

    for t in range(time_steps):
        u_tmp = update_u(u, b, v, a, dt)
        v_tmp = update_v(u, b, v, Dv, dt)
        u += u_tmp
        v += v_tmp

    plt.figure()
    plt.imshow(u, plt.cm.winter)
    plt.show()
    plt.imshow(v, plt.cm.winter)
    plt.show()


if __name__ == '__main__':
    main()
