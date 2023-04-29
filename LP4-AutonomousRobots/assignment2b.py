import numpy as np
import matplotlib.pyplot as plt

v0 = .5
t1 = 3
t2 = 10
dt = .01
vehicle_radius = .12

time = np.linspace(0, t2, int(t2/dt)+1)
vl, vr = np.zeros((2, len(time)))
x, y, theta = np.zeros((3, len(time)))

def get_wheel_speed():
    for idx, t in enumerate(time):
        if t <= t1:
            vl[idx] = 0
            vr[idx] = v0/t1 * t
        if t1 <= t and t <= t2:
            vl[idx] = v0/t2 *(t-t1)
            vr[idx] = v0
        if t1 <= t and t2 <= t:
            vl[idx] = 0
            vr[idx] = 0

    return vl, vr

def get_position(theta_dot, v):
    for i, t in enumerate(time[:-1]):
        theta[i+1] = theta[i] + theta_dot[i] * dt
        x[i+1] = x[i] + v[i+1] * np.cos(theta[i+1]) * dt
        y[i+1] = y[i] + v[i+1] * np.sin(theta[i+1]) * dt
    
    return x, y

def plot_motion(x, y):
    plt.plot(x,y)
    plt.plot(x[0], y[0], 'go', label='Start position') 
    plt.plot(x[-1], y[-1], 'ro', label='End position')
    plt.legend(loc='upper right')
    plt.show()


def main():
    vl, vr = get_wheel_speed()
    theta_dot = (vr-vl)/(2*vehicle_radius)
    v = (vr+vl)/2
    x, y = get_position(theta_dot, v)
    plot_motion(x, y)

if __name__== '__main__':
    main()


