clear all
close all
clc
t_r_bar=30  %sec
zeta_bar= 0.4
t_s_bar= 100 %sec

omega_n_min=3.5/t_r_bar %rad/sec
zeta_min=zeta_bar
zeta_omega_n_min=3.9/t_s_bar %rad/sec

figure
sgrid(zeta_min,omega_n_min)
axis([-1.5*omega_n_min 0 -1.5*omega_n_min 1.5*omega_n_min])
daspect([1 1 1])