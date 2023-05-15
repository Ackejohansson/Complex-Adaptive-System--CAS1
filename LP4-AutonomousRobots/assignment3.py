import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import os
import numpy as np
from scipy.linalg import block_diag

M = 14.6
R = 0.27
r = 0.27
I = 0.36
alpha = 0.3
beta = 0.4

t1 = 10
t2 = 20
t3 = 30
t4 = 40
dt = 0.005


def read_data(file_name, v1, v2, v3):
    file_path = os.path.join(os.getcwd(), file_name)
    df = pd.read_csv(file_path)
    v1 = df[v1].to_numpy(dtype=np.float64)
    v2 = df[v2].to_numpy(dtype=np.float64)
    if v3 != None:
        v3 = df[v3].to_numpy(dtype=np.float64)
        return v1, v2, v3
    return v1, v2


def get_position(theta_dot, velocity):
    number_of_steps = len(theta_dot)
    x, y, theta = np.zeros((3, number_of_steps))
    for i in range(number_of_steps-1):
        theta[i+1] = theta[i] + theta_dot[i] * dt
        x[i+1] = x[i] + velocity[i+1] * np.cos(theta[i+1]) * dt
        y[i+1] = y[i] + velocity[i+1] * np.sin(theta[i+1]) * dt
    
    return x, y


def plot_motion(x, y, label):
    plt.plot(x,y, label=label)
    plt.legend(loc='upper right')
    plt.axis('equal')

def kalman_filter(vl, vr, gnss_x, gnss_y):
    # Create a kalman filter that merges odometry and gnss data
    pass
    

def main():
    vl, vr, _ = read_data('wheelspeeds-1.csv', 'vl', 'vr', 'time')
    gnss_x, gnss_y = read_data('gnss-1.csv', 'x', 'y', None)
    gt_x, gt_y, _ = read_data('groundtruth-1.csv', 'x', 'y', 'phi')
    
    theta_dot = (vr-vl)/(2*R)
    velocity = (vr+vl)/2
    x, y = get_position(theta_dot, velocity)

    kf_x, kf_y = kalman_filter(vl, vr, gnss_x, gnss_y)
    plot_motion(kf_x, kf_y, label='kalman filter')
    plot_motion(x, y, label='odometry')
    plot_motion(gnss_x, gnss_y, label='gnss')
    plot_motion(gt_x, gt_y, label='ground truth')
    plt.show()


if __name__== '__main__':
    main()

