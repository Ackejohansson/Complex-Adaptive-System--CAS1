import numpy as np
import matplotlib.pyplot as plt


def draw_b(u, time_steps, dt):
    for j in range(len(u)):
        plt.figure()
        plt.xlabel(r"$\xi$")
        plt.ylabel("Wave u")
        for i in np.linspace(0, time_steps / dt - 5, 30):
            plt.plot(u[j, :, int(i)])
    plt.show()


def draw_c(u, time_steps, dt):
    for j in range(len(u)):
        plt.figure()
        plt.xlabel(r"$\xi$")
        plt.ylabel("Wave u")
        for i in np.linspace(0, time_steps / dt * 0.2, 20):
            plt.plot(u[j, :, int(i)])
    plt.show()


def draw_traveling_wave(u):
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(10, 5), constrained_layout=True)
    ax1.plot(u[0, :, 30000])
    ax1.set_xlabel(r"$\xi$")
    ax1.set_ylabel("u")
    ax1.set_title('Travelling wave')

    v = np.diff(u[0, :, 30000])
    ax2.plot(v, u[0, :-1, 20000])
    ax2.set_xlabel(r"$\frac{du}{d\xi}$")
    ax2.set_ylabel("u")
    ax2.set_title('Phase plane')
    plt.show()


def ramp(u0, xi, xi_0, L, time_steps, dt):
    u = np.zeros((3, L, int(time_steps / dt)))
    u[:, :, 0] = u0 / (1 + np.exp(xi - xi_0[:, None]))
    return u


def ramp_c(uc0, xi, xic_0, time_steps, dt, L):
    uc = np.zeros((2, L, int(time_steps / dt)))
    uc[:, :, 0] = uc0[0] * np.exp(-(xi - xic_0[:, None]) ** 2)
    return uc


def growth_rate(u, q, rho):
    return rho * u * (1 - u / q)


def carrying_capacity(u):
    return u / (1 + u)


def diffusion(u, t):
    return u[:, :-2, t] + u[:, 2:, t] - 2 * u[:, 1:-1, t]


def simulation(q, u, dt, rho, time_steps):
    for t in range(int(time_steps / dt - 1)):
        u_start = u[:, 0, t]
        u[:, 0, t + 1] = u_start + dt * (growth_rate(u_start, q, rho) - carrying_capacity(u_start)+(u[:, 1, t]-u_start))

        u_end = u[:, -1, t]
        u[:, -1, t + 1] = u_end + dt * (growth_rate(u_end, q, rho) - carrying_capacity(u_end) - (u_end - u[:, -2, t]))

        u_t = u[:, 1:-1, t]
        u[:, 1:-1, t + 1] = u_t + dt * (growth_rate(u_t, q, rho) - carrying_capacity(u_t) + diffusion(u, t))
    return u


def wave_speed(u, dt):
    print(10 / ((np.argmax(u[0, 60, :] > 2) - np.argmax(u[0, 50, :] > 2)) * dt))
    print(10 / ((np.argmax(u[1, 30, :] < 0.5) - np.argmax(u[1, 20, :] < 0.5)) * dt))
    print(10 / ((np.argmax(u[2, 70, :] > 2) - np.argmax(u[2, 60, :] > 2)) * dt))


def main():
    rho = .5
    L = 100
    q = 8
    xi = np.arange(1, L + 1)
    xi_0 = np.array([20, 50, 50])
    u0 = np.array([[(q - 1) / 2 + np.sqrt(((q - 1) / 2) ** 2 - q * (1 - rho) / rho)],
                   [(q - 1) / 2 - np.sqrt(((q - 1) / 2) ** 2 - q * (1 - rho) / rho)],
                   [1.1 * ((q - 1) / 2 - np.sqrt(((q - 1) / 2) ** 2 - q * (1 - rho) / rho))]])
    time_steps = 300
    dt = 1 / 100

    u = ramp(u0, xi, xi_0, L, time_steps, dt)
    u = simulation(q, u, dt, rho, time_steps)
    draw_b(u, time_steps, dt)

    # Task c
    uc0 = np.array([[u0[0], u0[0] * 3]])
    xic_0 = np.array([50, 50])
    uc = ramp_c(uc0, xi, xic_0, time_steps, dt, L)
    uc = simulation(q, uc, dt, rho, time_steps)

    draw_c(uc, time_steps, dt)
    # draw_traveling_wave()
    wave_speed(u, dt)


if __name__ == '__main__':
    main()
