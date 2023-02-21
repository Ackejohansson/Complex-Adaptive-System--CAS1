import numpy as np
import matplotlib.pyplot as plt


def ramp(u0, xi, xi_0, L, time_steps, dt):
    u = np.zeros((3, L, int(time_steps / dt)))
    u[0, :, 0] = u0[0] / (1 + np.exp(xi - xi_0[0]))
    u[1, :, 0] = u0[1] / (1 + np.exp(xi - xi_0[1]))
    u[2, :, 0] = u0[2] / (1 + np.exp(xi - xi_0[2]))
    return u


def simulation(q, u, dt, rho, time_steps):
    h = 3
    for t in range(int(time_steps / dt - 1)):
        u[:,0,t+1] = u[:,0,t] + dt * (
                rho*u[:,0,t] * (1-u[:,0,t]/q) - u[:,0,t]/(1+u[:,0,t]))

        u[:,-1,t+1] = u[:,-1,t] + dt * (
                rho*u[:,-1,t] * (1-u[:,-1,t]/q) - u[:,-1,t]/(1+u[:,-1,t]))

        u[:,h:-h,t+1] = u[:,h:-h,t] + dt * (
                rho*u[:,h:-h,t] * (1-u[:,h:-h,t]/q) - u[:,h:-h,t] / (1+u[:,h:-h,t]) +
                (u[:,:-h-1,t] + u[:,h+1:,t] - 2*u[:,h:-h,t])/h**2)
    return u


def draw_b(u, time_steps):
    plt.figure()
    plt.plot(u[0, :, :])
    plt.show()
    for i in np.linspace(0, time_steps - 1, 30):
        plt.plot(u[0, :, int(i)])


def main():
    rho = .5
    q = 8
    L = 100
    q = 8
    xi = np.arange(1, L + 1)
    xi_0 = np.array([20, 50, 50])
    u0 = np.array([(q-1)/2 + np.sqrt(((q-1)/2)**2 - q*(1-rho)/rho),
                   (q-1)/2 - np.sqrt(((q-1)/2)**2 - q*(1-rho)/rho),
                   1.1 * ((q-1)/2 - np.sqrt(((q-1)/2)**2 - q*(1-rho)/rho))])
    time_steps = 500
    dt = 1 / 100

    u = ramp(u0, xi, xi_0, L, time_steps, dt)
    u = simulation(q, u, dt, rho, time_steps)
    draw_b(u, time_steps)


if __name__ == '__main__':
    main()
