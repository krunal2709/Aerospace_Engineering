clear all
close all
clc

I_y=0.5 %kg m^2
Q_0=0.1
theta_0=2
omega_y_0=0

omega_n=0.12
zeta=0.4

k_p_y=omega_n^2*I_y
k_d_y=2*zeta*omega_n*I_y

tau_y=k_d_y/k_p_y

alpha_0_deg=1
alpha_1_deg=3
alpha_0=alpha_0_deg*pi/180
alpha_1=alpha_1_deg*pi/180

stop_time=300

sim('on_off_thruster')
figure
plot(tout,theta*180/pi)
grid on
xlabel('time(sec)')
ylabel('\theta(deg)')

figure
plot(tout,Q_y)
grid on
xlabel('time(sec)')
ylabel('Q_y (N m)')

figure
plot(theta*180/pi,theta_dot*180/pi)
grid on
xlabel('\theta(deg)')
ylabel('\theta_dot(deg/sec)')
hold on
theta_deg_range=[-1.2*abs(theta_0_deg) 1.2*abs(theta_0_deg)]
alpha_1_line