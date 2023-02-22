import numpy as np
import matplotlib.pyplot as plt


def update_u(u, b, v, a):
    u += a -(b+1)*u + u**2 @ v
    
def update_v(b, u, v):
    v += b*u- u**2 @ v

def main():
    L = 128
    Dv = np.array([2.3, 3, 5, 9])
    a = 3
    b = 8
    steady_u = a
    steady_v = b / a
    grid = np.zeros((L,L))
    u = np.random.uniform(low=0.9 * steady_u, high=1.1 * steady_u, size=(L, L))
    v = np.random.uniform(low=0.9 * steady_v, high=1.1 * steady_v, size=(L, L))

    for t in
        du = a-(b+1)*u + u**2 * v
        dv = b*u -u**2 *v



if __name__ == '__main__':
    main()
