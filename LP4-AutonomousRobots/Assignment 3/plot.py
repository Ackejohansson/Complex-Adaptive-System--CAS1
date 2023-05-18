from matplotlib import pyplot as plt
import numpy as np
import os

def plot_mse(increments, mse_values):
    plt.plot(increments, mse_values, marker='o')
    plt.xlabel('Increments')
    plt.ylabel('Mean Square Error (MSE)')
    plt.title('MSE between Estimate and Ground Truth')
    plt.grid(True)
    plt.savefig(os.path.join('figures', 'mse.png'))
    plt.show()

def plot_covariance(cov_history, time):
    plt.figure()
    for i in range(4):
        cov_i = [cov[i, i] for cov in cov_history]
        plt.plot(time, cov_i, label=f'Var {i+1}')
    plt.xlabel('Time')
    plt.ylabel('Covariance')
    plt.title('Covariance Evolution')
    plt.legend()
    plt.savefig(os.path.join('figures', 'covariance.png'))
    plt.show()

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