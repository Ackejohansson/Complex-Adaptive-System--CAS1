import numpy as np
import pandas as pd
import os
import numpy as np
import plot

# Constants
car_radius = 0.27
r = 0.27
t1, t2, t3, t4 = 10, 20, 30, 40
dt = 0.005

# Parameters
straight_parameters = {
    'Q': np.eye(4) * 0.001, # How much we trust our GNSS
    'R': np.eye(4) * 0.55}  # How much we trust our Kinematic model
turning_parameters = {
    'Q': np.eye(4) * 0.4, 
    'R': np.eye(4) * 0.001}
Q = straight_parameters['Q'] 
R = straight_parameters['R']
is_turning = False

def read_data(file_name, *variables):
    try:
        df = pd.read_csv(os.path.join('data', file_name))
        data = []
        for var in variables:
            if var in df.columns:
                var_data = df[var].to_numpy(dtype=np.float64)
                data.append(var_data)
            else:
                print(f"Variable '{var}' not found in the CSV file.")
        return tuple(data)
    
    except FileNotFoundError:
        print(f"File '{file_name}' not found.")
    except Exception as e:
        print("An error occurred during data processing:", str(e))

def get_position(theta_dot, velocity):
    num_steps = len(theta_dot)
    x, y, theta = np.zeros((3, num_steps))
    for i in range(num_steps - 1):
        theta[i+1] = theta[i] + theta_dot[i] * dt
        x[i+1] = x[i] + velocity[i+1] * np.cos(theta[i+1]) * dt
        y[i+1] = y[i] + velocity[i+1] * np.sin(theta[i+1]) * dt
    return x, y, theta

def compute_mse(kf_x, kf_y, gt_x, gt_y):
    mse_values = []
    for i in range(len(gt_x)):
        mse_values.append(
            np.mean((np.array(gt_x[:i + 1]) - np.array(kf_x[:i + 1])) ** 2) +
            np.mean((np.array(gt_y[:i + 1]) - np.array(kf_y[:i + 1])) ** 2)
        )
    increments = np.arange(1, len(gt_x) + 1)
    return increments, mse_values

def switch_state(turn):
    global current_parameters, is_turning
    if turn and not is_turning:
        Q = turning_parameters['Q']
        R = turning_parameters['R']
        is_turning = True
        print("Switched to turning parameters.")
    elif not turn and is_turning:
        Q = straight_parameters['Q']
        R = straight_parameters['R']
        is_turning = False
        print("Switched to still parameters.")

def update_turning(t):
    if t > t2-2 and t < t3:
        switch_state(turn=True)
    elif t > t3+5:
        switch_state(turn=False)

def get_xhat(xhat, index, theta_dot, v):
    xhat[0] = v[index]
    u = np.array([0, theta_dot[index], xhat[0]*np.cos(xhat[1]), xhat[0]*np.sin(xhat[1])])*dt
    return xhat + u

def get_F(xhat):
    return np.array([[1, 0, 0, 0],
                     [0, 1, 0, 0],
                     [(np.cos(xhat[1]))*dt, (-xhat[0]*np.sin(xhat[1]))*dt, 1, 0],
                     [(np.sin(xhat[1]))*dt, (xhat[0]*np.cos(xhat[1]))*dt, 0, 1]])

def kalman_filter(gnns_dict, time, theta, v, x, y, theta_dot):
    state = np.zeros((len(time), 4))
    cov_history = []
    P = np.eye(4)
    H = np.eye(4)
    H[:2, :2] = 0

    xhat = np.array([v[0], theta[0], x[0], y[0]])
    for index, t in enumerate(time):
        update_turning(t)
        xhat = get_xhat(xhat, index, theta_dot, v)
        F = get_F(xhat)    
        P = F @ P @ F.T + Q
        if t in gnns_dict:
            G = P @ H.T @ np.linalg.pinv(H @ P @ H.T + R)
            xhat += G @ (np.array([0, 0, gnns_dict[t][0], gnns_dict[t][1]]) - xhat)
            P = (np.eye(4) - G @ H) @ P
        state[index] = xhat
        cov_history.append(P.copy())
    return state[:,2], state[:,3], cov_history
    

def main():
    time, vl, vr = read_data('wheelspeeds-1.csv', 'time', 'vl', 'vr')
    t, gnss_x, gnss_y = read_data('gnss-1.csv', 't', 'x', 'y')
    gnss_dict = {t[i]: (gnss_x[i], gnss_y[i]) for i in range(len(t))}
    gt_x, gt_y, _ = read_data('groundtruth-1.csv', 'x', 'y', 'phi')
    
    theta_dot = (vr-vl)/(2*car_radius)
    velocity = (vr+vl)/2
    x, y, theta = get_position(theta_dot, velocity)

    kf_x, kf_y, cov_history = kalman_filter(gnss_dict, time, theta, velocity, x, y, theta_dot)
    
    increments, mse_values = compute_mse(kf_x, kf_y, gt_x, gt_y)
    print('MSE: ', sum(mse_values))
    plot.plot_mse(increments, mse_values)
    plot.plot_covariance(cov_history, time)
    plot.plot_motion([x, gnss_x, gt_x, kf_x], [y, gnss_y, gt_y, kf_y], ['Odometry', 'GNSS', 'Ground Truth', 'Kalman'])


if __name__== '__main__':
    main()


