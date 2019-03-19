clear all
close all
clc

omega_n=0.12
zeta=0.4
s=tf('s')
T= omega_n^2/(s^2+2*zeta*omega_n*s+omega_n^2)

damp(T)

step(T)
I_x=1  %kg m^2
I_y=0.5 %kg m^2
I_z=0.7 %kg m^2

k_p_x=omega_n^2*I_x
k_d_x=2*zeta*omega_n*I_x

k_p_y=omega_n^2*I_y
k_d_y=2*zeta*omega_n*I_y

k_p_z=omega_n^2*I_z
k_d_z=2*zeta*omega_n*I_z