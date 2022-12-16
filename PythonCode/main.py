import numpy as np
import matplotlib.pyplot as plt


def henon_map(x, y, a, b):
    x_next = y + 1 - a * x**2
    y_next = b*x
    return [x_next, y_next]


def main_loop(nr_init_conditions, nr_iterations, x0, y0, x, y, a, b):
    transient = 10
    x_list = np.zeros((nr_init_conditions, nr_iterations-transient))
    y_list = np.zeros((nr_init_conditions, nr_iterations-transient))
    for i in range(nr_init_conditions):
        x[0] = x0[i]
        y[0] = y0[i]
        for j in range(nr_iterations-1):
            x[j+1], y[j+1] = henon_map(x[-1], y[-1], a, b)

        x_list[i] = x[transient:]
        y_list[i] = y[transient:]

    return np.array(x_list), np.array(y_list)


def plot_map(x_list, y_list):
    fig, ax = plt.subplots(1, 1, figsize=(10, 10))
    ax.plot(x_list, y_list, '.')
    plt.title("Fractal attractor of Héiman map")
    plt.xlabel("x")
    plt.ylabel("y")
    plt.show()


def boxcounting(x_list, y_list):
    bin_size = 10**(-2)
    x_min = np.min(x_list)
    y_min = np.min(y_list)
    array_like = np.arange(x_min, y_min, bin_size).tolist()
    print(x_min)
    np.shape(y_min)
    np.shape(array_like)

    print(array_like)
    np.histogram2d(np.array(x_list), np.array(y_list), [array_like, array_like])


def main():
    # Parameters
    a = 1.4
    b = 0.3
    nr_init_conditions = 1000
    nr_iterations = 100
    x0 = np.linspace(-0.1, 0.1, nr_init_conditions)
    y0 = np.linspace(-0.1, 0.1, nr_init_conditions)
    x = np.zeros(nr_iterations)
    y = np.zeros(nr_iterations)

    x_list, y_list = main_loop(nr_init_conditions, nr_iterations, x0, y0, x, y, a, b)
    plot_map(x_list, y_list)

    #boxcounting(x_list, y_list)
    x_min = np.min(x_list)
    x_max = np.max(x)
    y_min = np.min(y_list)
    y_max = np.max(y_list)
    x_bins = np.linspace(x_min, x_max, 1000)
    y_bins = np.linspace(y_min, y_max, 1000)

    fig, ax = plt.subplots(figsize=(10, 7))

    # Creating plot
    a = x_list.flatten()
    b = x_list.flatten()
    [H, xEdge, yEdge] = np.histogram2d(a, b, bins=[x_bins, y_bins])
    extent = [xEdge[0], xEdge[-1], yEdge[0], yEdge[-1]]
    plt.clf()
    plt.imshow(H.T, extent=extent, origin='lower')
    plt.show()
    # print(H)
    #ax.imshow(H)

    plt.hist2d(a, b, bins=[x_bins, y_bins])
    plt.title("Changing the bin scale")

    plt.tight_layout()
    plt.show()

if __name__ == '__main__':
    main()


