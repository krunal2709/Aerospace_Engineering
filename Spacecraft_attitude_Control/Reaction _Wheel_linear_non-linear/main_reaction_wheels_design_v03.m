clear all
close all
clc


I_x=1  %kg m^2
I_y=0.5 %kg m^2
I_z=0.7 %kg m^2

phi_0=0.1
theta_0=-0.3
psi_0=0.2

omega_x_0=0;
omega_y_0=0;
omega_z_0=0;

omega_n=0.12
zeta=0.4

k_p_x=omega_n^2*I_x
k_d_x=2*zeta*omega_n*I_x

k_p_y=omega_n^2*I_y
k_d_y=2*zeta*omega_n*I_y

k_p_z=omega_n^2*I_z
k_d_z=2*zeta*omega_n*I_z

stop_time=150 

sim('reaction_wheels_design_v03')
%%pitch channel
figure
plot(tout,phi)
xlabel('time(sec)')
ylabel('\phi(rad)')
grid on

s=tf('s')
T= omega_n^2/(s^2+2*zeta*omega_n*s+omega_n^2)

[y_temp,t]=step(T,stop_time);
y=y_temp*phi_0;
hold on
plot(t,-(y-phi_0*ones(size(y))),'*')
%%
figure
plot(tout,theta)
xlabel('time(sec)')
ylabel('\theta(rad)')
grid on

s=tf('s')
T= omega_n^2/(s^2+2*zeta*omega_n*s+omega_n^2)

[y_temp,t]=step(T,stop_time);
y=y_temp*theta_0;
hold on
plot(t,-(y-theta_0*ones(size(y))),'*')

%%yaw channel
figure
plot(tout,psi)
xlabel('time(sec)')
ylabel('\psi(rad)')
grid on

s=tf('s')
T= omega_n^2/(s^2+2*zeta*omega_n*s+omega_n^2)

[y_temp,t]=step(T,stop_time);
y=y_temp*psi_0;
hold on
plot(t,-(y-psi_0*ones(size(y))),'*')