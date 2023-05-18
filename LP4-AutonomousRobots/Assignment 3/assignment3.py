import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import os
import numpy as np

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
    df = pd.read_csv(os.path.join('data', file_name))
    v1 = df[v1].to_numpy(dtype=np.float64)
    v2 = df[v2].to_numpy(dtype=np.float64)
    if v3 != None:
        v3 = df[v3].to_numpy(dtype=np.float64)
        return v1, v2, v3
    return v1, v2


def get_position(theta_dot, velocity):
    num_steps = len(theta_dot)
    x, y, theta = np.zeros((3, num_steps))
    for i in range(num_steps - 1):
        theta[i+1] = theta[i] + theta_dot[i] * dt
        x[i+1] = x[i] + velocity[i+1] * np.cos(theta[i+1]) * dt
        y[i+1] = y[i] + velocity[i+1] * np.sin(theta[i+1]) * dt
    return x, y, theta


def plot_motion(x_list, y_list, labels):
    [plt.plot(x, y, label=label) for x, y, label in zip(x_list, y_list, labels)]
    plt.legend(loc='upper right')
    plt.axis('equal')
    if len(x_list) == 3:
        filename = 'odometry_gnss_gt.png'
    if len(x_list) == 4:
       filename = 'kalman.png'
    plt.savefig(os.path.join('figures', filename))
    plt.show()


def kalman_filter(vl, vr, gnns_dict, time, theta, v, x, y, theta_dot):
    # initialize matricies
    state = np.zeros((len(time), 2))
    u = np.array([np.zeros([len(theta_dot)]), theta_dot, x, y])*dt

    F = np.array([[1, 0, 0, 0],
                  [0, 1, 0, 0],
                  [dt*np.cos(theta), v*np.sin(theta)*dt, 1, 0],
                  [dt*np.sin(theta), -v*np.cos(theta)*dt, 0, 1]])
    H = np.eye(4)
    H[:2, :2] = 0
    Q = np.eye(4)*0.01   
    R = np.eye(4)*0.01
    P = np.eye(4)

    # initialize state
    xhat = np.array([v[0], theta[0], x[0], y[0]])
    for index, t in enumerate(time):
        xhat = xhat + u[:,index]
        P = F @ P @ F.T + Q
        if t in gnns_dict:
            G = P @ H.T @ np.linalg.pinv(H @ P @ H.T + R)
            xhat = xhat + G @ (gnns_dict[t] - xhat)
            P = (np.eye(4) - G @ H) @ P
        state[index] = xhat[:2]
    return state[0], state[1]
            
    

def main():
    time, vl, vr = read_data('wheelspeeds-1.csv', 'time', 'vl', 'vr')
    t, gnss_x, gnss_y = read_data('gnss-1.csv', 't', 'x', 'y')
    gnss_dict = {t[i]: (gnss_x[i], gnss_y[i]) for i in range(len(t))}
    # save dict with t as key and gnss_x, gnss_y as values
    
    gt_x, gt_y, _ = read_data('groundtruth-1.csv', 'x', 'y', 'phi')
    
    theta_dot = (vr-vl)/(2*R)
    velocity = (vr+vl)/2
    x, y, theta = get_position(theta_dot, velocity)

    kf_x, kf_y = kalman_filter(vl, vr, gnss_dict, time, theta, velocity, x, y, theta_dot)

    plot_motion([x, gnss_x, gt_x, kf_x], [y, gnss_y, gt_y, kf_y], ['odometry', 'gnss', 'ground truth', 'kalman'])



if __name__== '__main__':
    main()


