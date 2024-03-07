import numpy as np
import matplotlib.pyplot as plt

v0 = .5
t1 = 10
t2 = 5
t = np.linspace(0, 10, 1001)
vl = v0*(t/t1)
vr = v0*(t/t2)
R = .12
theta_dot = (vr-vl)/(2*R)

x, y, theta = np.zeros((3, len(t)))
dt = t[1] - t[0]

v = (vr+vl)/2

for i in range(len(t)-1):
    theta[i+1] = theta[i] + theta_dot[i] * dt
    x[i+1] = x[i] + v[i+1] * np.cos(theta[i+1]) * dt
    y[i+1] = y[i] + v[i+1] * np.sin(theta[i+1]) * dt

plt.plot(x,y)
plt.plot(x[0], y[0], 'go', label='Start position') 
plt.plot(x[-1], y[-1], 'ro', label='End position')
plt.legend(loc='upper right')
plt.show()
