import numpy as np
import matplotlib.pyplot as plt

bd_vals = [
    (0.1, 0.2),
    (1, 2),
    (10, 5)]
n_0 = 10  # ??
dt = 1e-2
iterations = int(1e3)
b_t = np.zeros((3, iterations))
d_t = np.zeros((3, iterations))


def time_to_event(a):
    t = 0
    while True:
        r = np.random.rand()
        if r < a * dt: break
        t += dt
    return t


def simulation(b, d, index):
    for n in range(iterations):
        b_t[index, n] = time_to_event(b)
        d_t[index, n] = time_to_event(d)


def main():
    for index in range(3):
        b, d = bd_vals[index]
        simulation(b, d, index)
    print("KLAR")


if __name__ == '__main__':
    main()
