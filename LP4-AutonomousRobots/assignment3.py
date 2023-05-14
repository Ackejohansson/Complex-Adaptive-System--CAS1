import numpy as np
import matplotlib.pyplot as plt


M = 14.6
R = 0.27
r = 0.27
I = 0.36
alpha = 0.3
beta = 0.4

v0 = .5
t1 = 10
t2 = 20
t3 = 30
t4 = 40

dt = .01
vehicle_radius = .12
times = np.arange(0, t4+dt, dt)
x, y, theta = np.zeros((3, len(time)))

def set_wheel_torque(time, t1, t2, t3, t4):
    if time < 0:
        raise ValueError("Time value must be non-negative")
    
    torque_dict = {
        (0, t1): (0.2, 0.2),
        (t1, t2): (0, 0),
        (t2, t3): (0.14, 0),
        (t3, t4): (-0.05, -0.05),
        (t4, float('inf')): (0, 0)
    }
    
    # Find the torque values for the given time
    for time_range, torque_values in torque_dict.items():
        if time_range[0] <= time < time_range[1]:
            return torque_values
    
    return float('nan'), float('nan')


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
    for time in range(0, t4+dt, dt):
        tl, tr = set_wheel_torque()


        theta_dot = (vr-vl)/(2*vehicle_radius)
        v = (vr+vl)/2
        x, y = get_position(theta_dot, v)
        plot_motion(x, y)

if __name__== '__main__':
    main()


