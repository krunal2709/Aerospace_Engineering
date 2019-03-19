clear all
close all
clc

I_x= 1 %kg m^2
I_y= 0.5  %kg m^2
I_z= 0.7 %kg m^2

%geomagetic field parameter

m_E=7.77e15 % A m^2 
theta_m=169.7/180*pi
omega_e=360.99/180*pi/(24*60*60) %ra/sec
alpha_0= 5.1191%random number
 
%earth Parameter
R_E=6371e3 % m
G=6.67e-11 %earth gravitational const
M_E=5.972e24 %kg

%orbital Parameter
h=450e3 %m
R=R_E+h % m
n=sqrt(G*M_E/R^3)
phi=5.6913 %random
i= 87*180/pi %deg
Omega=0;
T_orbit=2*pi/n


A= [0 0 0 1 0 0;
    0 0 0 0 1 0;
    0 0 0 0 0 1;
    0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0]

B_quaternion= [zeros(4,3);diag([1/I_x 1/I_y 1/I_z])]
%initial condition
epsilon_0=zeros(3,1)
eta_0=1
omega_x_0=0.02
omega_y_0=-0.03
omega_z_0=0.03

X_0=[epsilon_0;
     eta_0;
     omega_x_0;
     omega_y_0;
     omega_z_0]
 
 stop_time=3*T_orbit %sec