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


def get_position(theta_dot, v):
    x, y, theta = np.zeros((3, len(theta_dot)))
    for i, t in enumerate(theta_dot[:-1]):
        theta[i+1] = theta[i] + theta_dot[i] * dt
        x[i+1] = x[i] + v[i+1] * np.cos(theta[i+1]) * dt
        y[i+1] = y[i] + v[i+1] * np.sin(theta[i+1]) * dt
    
    return x, y

def plot_motion(x, y, label):
    plt.plot(x,y, label=label)
    plt.legend(loc='upper right')
    plt.axis('equal')
    

def main():
    #vl, vr, time = read_data('wheelspeeds-1.csv', 'vl', 'vr', 'time')
    #dt = time[1] - time[0]
    #gnss_x, gnss_y = read_data('gnss-1.csv', 'x', 'y', None)
    gt_x, gt_y, _ = read_data('groundtruth-1.csv', 'x', 'y', 'phi')
    
    df = pd.read_csv('gnss-1.csv')
    # Define the state transition matrix
    dt = 0.1
    F = np.array([[1, dt, 0],
                [0, 1, dt],
                [0, 0, 1]])

    # Define the observation matrix
    H = np.array([[1, 0, 0],
                [0, 1, 0]])

    # Define the process noise covariance matrix
    q = 0.1
    Q = q * np.array([[dt**3/3, dt**2/2, 0],
                    [dt**2/2, dt, 0],
                    [0, 0, 1]])

    # Define the measurement noise covariance matrix
    r = 0.1
    R = r * np.eye(2)

    # Initialize the state vector and error covariance matrix
    x0 = np.array([df.iloc[0]['x'], df.iloc[0]['y'], 0])
    P0 = block_diag(np.var(df['x']), np.var(df['y']), 1)

    # Iterate over the rows of the DataFrame and apply the Kalman filter
    x = [x0]
    P = [P0]
    for i in range(1, len(df)):
        # Predict step
        x_pred = F @ x[-1]
        P_pred = F @ P[-1] @ F.T + Q
        
        # Update step
        y = np.array([df.iloc[i]['x'], df.iloc[i]['y']]) - H @ x_pred
        S = H @ P_pred @ H.T + R
        K = P_pred @ H.T @ np.linalg.inv(S)
        x_upd = x_pred + K @ y
        P_upd = (np.eye(3) - K @ H) @ P_pred

        # Update the innovation vector y with the current measurement
        y = np.array([df.iloc[i]['x'], df.iloc[i]['y']]) - H @ x_upd
        
        x.append(x_upd)
        P.append(P_upd)

    # Convert the filtered state to a DataFrame
    df_filt = pd.DataFrame(x, columns=['x', 'y', 'v'], index=df.index)
    plt.plot(df['x'], df['y'], label='GNSS', marker='o', markersize=3)
    plt.plot(filtered_states[:, 0], filtered_states[:, 1], label='Kalman Filter', marker='.', markersize=2)
    plt.xlabel('x')
    plt.ylabel('y')
    plt.legend()
    plt.show()
    
    #theta_dot = (vr-vl)/(2*R)
    #v = (vr+vl)/2
    #x, y = get_position(theta_dot, v)
    #plot_motion(x, y, label='odometry')
    #plot_motion(gnss_x, gnss_y, label='gnss')
    #plot_motion(gt_x, gt_y, label='ground truth')




    plt.show()


if __name__== '__main__':
    main()

