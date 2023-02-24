import numpy as np
import matplotlib.pyplot as plt


def laplace(grid):
    return np.roll(grid, 1, axis=0) + np.roll(grid, -1, axis=0) + np.roll(grid, 1, axis=1) + np.roll(grid, -1,
                                                                                                     axis=1) - 4 * grid


def update_u(u, b, v, a, dt):
    return (a - (b + 1) * u + (u ** 2) * v + laplace(u)) * dt


def update_v(u, b, v, Dv, dt):
    return (b * u - u ** 2 * v + Dv[3] * laplace(v)) * dt


def draw(u, u1000):
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(10, 5), constrained_layout=True)
    im1 = ax1.imshow(u1000, cmap=plt.cm.winter, vmin=0, vmax=12, extent=[0, 128, 0, 128])
    im2 = ax2.imshow(u, cmap=plt.cm.winter, vmin=0, vmax=12, extent=[0, 128, 0, 128])
    fig.suptitle(f"Dv")
    fig.colorbar(im2, ax=ax2, shrink=0.85)
    plt.show()


def main():
    time_steps = 5000
    dt = 1 / 100
    L = 128
    Dv = np.array([2.3, 3, 5, 9])
    a = 3
    b = 8
    steady_u = a
    steady_v = b / a
    u1000 = []
    u = np.random.uniform(low=0.9 * steady_u, high=1.1 * steady_u, size=(L, L))
    v = np.random.uniform(low=0.9 * steady_v, high=1.1 * steady_v, size=(L, L))

    for t in range(int(time_steps / dt)):
        u_tmp = update_u(u, b, v, a, dt)
        v_tmp = update_v(u, b, v, Dv, dt)
        u += u_tmp
        v += v_tmp
        if t == 1000 / dt:
            u1000 = u
    draw(u, u1000)


if __name__ == '__main__':
    main()
