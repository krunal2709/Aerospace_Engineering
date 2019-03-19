clear all
clc

I_x= 1 %kg m^2
I_y= 0.5 %kg m^2
I_z= 0.7 %kg m^2

B_quaternion=[zeros(4,3);diag([1/I_x 1/I_y 1/I_z])]

epsilon_0=zeros(3,1)
eta_0=1
omega_x_0=0
omega_y_0=0
omega_z_0=0

x_0=[epsilon_0;
     eta_0;
omega_x_0;
omega_y_0;
omega_z_0;]

stop_time=1