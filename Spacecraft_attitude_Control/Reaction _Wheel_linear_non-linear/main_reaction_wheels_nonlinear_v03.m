 clear all
close all
clc

I_x= 1 %kg m^2
I_y= 0.5 %kg m^2
I_z= 0.7 %kg m^2

B_quaternion=[zeros(4,3);diag([1/I_x 1/I_y 1/I_z])]
%initial condition
phi_0_deg=40
theta_0_deg=-40
psi_0_deg=-60
omega_x_0=0.1
omega_y_0=0.3
omega_z_0=-0.2
phi_0=phi_0_deg*pi/180
theta_0=theta_0_deg*pi/180
psi_0=psi_0_deg*pi/180

q_0=angle2quat(psi_0,theta_0,phi_0)

epsilon_0=q_0(2:4)'
eta_0=q_0(1)
omega_x_0=0
omega_y_0=0
omega_z_0=0

x_0=[epsilon_0;
     eta_0;
omega_x_0;
omega_y_0;
omega_z_0]

omega_n_0=0.12
zeta_0=0.4

I_max=max([I_x I_y I_z])

k_p=2*omega_n_0^2*I_max
k_d=2*zeta_0*omega_n_0*I_max
stop_time=150