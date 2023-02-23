import numpy as np
import matplotlib.pyplot as plt


def ramp(u0, xi, xi_0, L, time_steps, dt):
    u = np.zeros((3, L, int(time_steps / dt)))
    u[0, :, 0] = u0[0] / (1 + np.exp(xi - xi_0[0]))
    u[1, :, 0] = u0[1] / (1 + np.exp(xi - xi_0[1]))
    u[2, :, 0] = u0[2] / (1 + np.exp(xi - xi_0[2]))
    return u


def ramp_c(uc0, xi, xic_0, time_steps, dt, L):
    uc = np.zeros((2, L, int(time_steps / dt)))
    uc[0, :, 0] = uc0[0] * np.exp(-(xi - xic_0[0]) ** 2)
    uc[1, :, 0] = uc0[1] * np.exp(-(xi - xic_0[1]) ** 2)
    return uc


def simulation(q, u, dt, rho, time_steps):
    for t in range(int(time_steps / dt - 1)):
        u[:, 0, t + 1] = u[:, 0, t] + dt * (
                rho * u[:, 0, t] * (1 - u[:, 0, t] / q) - u[:, 0, t] / (1 + u[:, 0, t]) + (u[:, 1, t] - u[:, 0, t]).T)

        u[:, -1, t + 1] = u[:, -1, t] + dt * (
                rho * u[:, -1, t] * (1 - u[:, -1, t] / q) - u[:, -1, t] / (1 + u[:, -1, t]) - (
                u[:, -1, t] - u[:, -2, t]))

        u[:, 1:-1, t + 1] = u[:, 1:-1, t] + dt * (
                rho * u[:, 1:-1, t] * (1 - u[:, 1:-1, t] / q) - u[:, 1:-1, t] / (1 + u[:, 1:-1, t]) +
                (u[:, :-2, t] + u[:, 2:, t] - 2 * u[:, 1:-1, t]))
    return u


def draw_b(u, time_steps, dt):
    for j in range(len(u)):
        plt.figure()
        plt.xlabel(r"$\xi$")
        plt.ylabel("Wave u")
        for i in np.linspace(0, time_steps/dt-1, 30):
            plt.plot(u[j, :, int(i)])

    plt.legend()
    plt.show()


def wave_speed(u, dt):
    print(np.argmax(u[0, 60, :] > 2))
    print(np.argmax(u[0, 50, :] > 2))
    print(10 / ((np.argmax(u[0, 60, :] > 2) - np.argmax(u[0, 50, :] > 2)) * dt))


def main():
    rho = .5
    L = 100
    q = 8
    xi = np.arange(1, L + 1)
    xi_0 = np.array([20, 50, 50])
    u0 = np.array([(q - 1) / 2 + np.sqrt(((q - 1) / 2) ** 2 - q * (1 - rho) / rho),
                   (q - 1) / 2 - np.sqrt(((q - 1) / 2) ** 2 - q * (1 - rho) / rho),
                   1.1 * ((q - 1) / 2 - np.sqrt(((q - 1) / 2) ** 2 - q * (1 - rho) / rho))])
    time_steps = 500
    dt = 1/100
    u = ramp(u0, xi, xi_0, L, time_steps, dt)
    u = simulation(q, u, dt, rho, time_steps)
    draw_b(u, time_steps, dt)

    uc0 = np.array([u0[0], u0[0]*3])
    xic_0 = np.array([50, 50])
    #uc = ramp_c(uc0, xi, xic_0, time_steps, dt, L)
    #uc = simulation(q, uc, dt, rho, time_steps)
    #draw_b(uc, time_steps, dt)

    wave_speed(u, dt)

if __name__ == '__main__':
    main()
