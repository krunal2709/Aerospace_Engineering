clear all
close all
clc

I_x= 1 %kg m^2
I_y= 0.5 %kg m^2
I_z= 0.7 %kg m^2

A=[zeros(3,3) eye(3);zeros(3,6)]

B=[zeros(3,3);diag([1/I_x 1/I_y 1/I_z])]

C= eye(6)

D=zeros(6,3)

phi_0_deg=4 %deg
psi_0_deg=-4 %deg
theta_0_deg=-6 %deg
omega_x_0=0
omega_y_0=0
omega_z_0=0

phi_0=phi_0_deg*pi/180
theta_0=theta_0_deg*pi/180
psi_0=psi_0_deg*pi/180

x_0=[phi_0;
psi_0;
theta_0;
omega_x_0;
omega_y_0;
omega_z_0;]
omega_n=0.12
zeta=0.4

k_p_x=omega_n^2*I_x
k_d_x=2*zeta*omega_n*I_x

k_p_y=omega_n^2*I_y
k_d_y=2*zeta*omega_n*I_y

k_p_z=omega_n^2*I_z
k_d_z=2*zeta*omega_n*I_z

k_p_matrix=diag([k_p_x k_p_y k_p_z])
k_d_matrix=diag([k_d_x k_d_y k_d_z])

stop_time=150 
