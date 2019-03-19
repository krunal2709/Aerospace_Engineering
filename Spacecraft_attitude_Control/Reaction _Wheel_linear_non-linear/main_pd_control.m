clear all
close all
clc

I=1 %kg m^2
k_p=2
k_d=0.5

theta_0=2
omega_0=0

stop_time=30
sim('pd_control')
plot(tout,theta)
hold on
k_p=9
k_d=4
sim('pd_control')
plot(tout,theta)