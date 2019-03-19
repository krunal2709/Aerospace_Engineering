clear all
close all
clc

omega_n_0=0.12
zeta_0=0.4

I_x=1  %kg m^2
I_y=0.5 %kg m^2
I_z=0.7 %kg m^2
I_max=max([I_x I_y I_z])

k_p=2*omega_n_0^2*I_max
k_d=2*zeta_0*omega_n_0*I_max
s=tf('s')
%%T_1
T_1=k_p/(2*I_x)/(s^2+k_d/I_x*s+k_p/(2*I_x))
figure
step(T_1)
damp(T_1)
%%T_2
T_2=(k_p/2*I_y)/(s^2+(k_d/I_y)*s+(k_p/(2*I_y)))
figure
step(T_2)
damp(T_2)
%%T_3
T_3=(k_p/2*I_z)/(s^2+(k_d/I_z)*s+(k_p/(2*I_z)))
figure
step(T_3)
damp(T_3)