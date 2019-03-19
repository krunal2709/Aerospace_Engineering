I_x= 1 %kg m^2
I_y= 0.5 %kg m^2
I_z= 0.7 %kg m^2

A=[zeros(3,3) eye(3);zeros(3,6)]

B=[zeros(3,3);diag([1/I_x 1/I_y 1/I_z])]

C= eye(6)

D=zeros(6,3)

phi_0=0
psi_0=0
theta_0=0
omega_x_0=0
omega_y_0=0
omega_z_0=0

x_0=[phi_0;
psi_0;
theta_0;
omega_x_0;
omega_y_0;
omega_z_0;]
