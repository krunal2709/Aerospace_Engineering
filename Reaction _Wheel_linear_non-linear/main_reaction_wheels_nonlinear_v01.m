clear all
close all
clc
t_r_bar=30  %sec
zeta_bar= 0.4
t_s_bar= 100 %sec
I_x=1  %kg m^2
I_y=0.5 %kg m^2
I_z=0.7 %kg m^2

I_min=min([I_x I_y I_z])
I_max=max([I_x I_y I_z])
zeta_0_max=sqrt(I_min/I_max)
omega_n_0_min=3.5/t_r_bar %rad/sec
zeta_0_min=zeta_bar
zeta_0_omega_n_0_min=3.9/t_s_bar %rad/sec

figure
sgrid([zeta_0_min,zeta_0_max],omega_n_0_min)
axis([-1.5*omega_n_0_min 0 -1.5*omega_n_0_min 1.5*omega_n_0_min])
daspect([1 1 1])

% omega_n_0=0.12 %rad/sec
% zeta_0_min=0.4