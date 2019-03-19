clc
clear all
close all

%almanac=urlwrite('http://www.navcen.uscg.gov/?pageName=currentAlmanac&format=yuma-txt','current.txt')
almanac1 = importfile('Yuma.txt', 1, 434);
mu=398601;      %km^3/s^2
for z=0:30
    sat(z+1,1)=getfield(almanac1(2+14*z,2),'VarName2');          %satellite number
    sat(z+1,2)=getfield(almanac1(4+14*z,2),'VarName2');          %eccentricity
    sat(z+1,3)=getfield(almanac1(5+14*z,2),'VarName2');          %time of applicability
    sat(z+1,4)=getfield(almanac1(6+14*z,2),'VarName2');          %orbital inclination
    sat(z+1,5)=1e-3*getfield(almanac1(8+14*z,2),'VarName2')^2;   %semi major axis (Km)
    sat(z+1,6)=getfield(almanac1(9+14*z,2),'VarName2');          %RAAN
    sat(z+1,7)=getfield(almanac1(10+14*z,2),'VarName2');         %argument of perigee
    sat(z+1,8)=getfield(almanac1(11+14*z,2),'VarName2');         %mean anomaly
    sat(z+1,9)=sqrt(mu/sat(z+1,5)^3);                            %mean motion
    sat(z+1,10)=getfield(almanac1(7+14*z,2),'VarName2');         %RAAN rate
end

T_earth = 86400;
T_k=[0:600:86400]; %time period
n_iter = length(T_k);
W_earth = 2*pi/T_earth; %frequency

for z=0:30
    M_k(z+1,:)=sat(z+1,8)+sat(z+1,9)*T_k; %% propagated mean anomaly
end

syms Ek

for z=0:30
 for k=1:n_iter
  Ecc(z+1,k) = vpasolve(M_k(z+1,k)==Ek-sat(z+1,2)*sin(Ek),Ek); %eccentric anomaly
  E(z+1,k) = double(Ecc(z+1,k));
 end
end


for z=0:30
    for k=1:n_iter
        sinV_k(z+1,k)= (sqrt(1-sat(z+1,2)^2)*sin(E(z+1,k)))/(1-sat(z+1,2)*cos(E(z+1,k)));    %true anomaly
        cosV_k(z+1,k)= (cos(E(z+1,k))-sat(z+1,2))/(1-sat(z+1,2)*cos(E(z+1,k)));
        V_k(1+z,k)=atan2(sinV_k(1+z,k),cosV_k(1+z,k));
        phi(z+1,k)= V_k(z+1,k)+sat(z+1,7);                                 %argument of latitude
        R_k(z+1,k)= sat(z+1,5)*(1-sat(z+1,2)*cos(E(z+1,k)));               %correction of radius
        ik(z+1,k)= sat(z+1,4);                                             %correction of inclination
        omega(z+1,k)= sat(z+1,6)+(sat(z+1,10)-W_earth)*T_k(k);             %RAAN
        X_p(z+1,k)= R_k(z+1,k)*cos(phi(z+1,k));                            %X position
        Y_p(z+1,k)= R_k(z+1,k)*sin(phi(z+1,k));                            %Y position
        X_s(z+1,k)= X_p(z+1,k)*cos(omega(z+1,k))- Y_p(z+1,k)*cos(ik(z+1,1))*sin(omega(z+1,k)); %ECEF coordinate system
        Y_s(z+1,k)= X_p(z+1,k)*sin(omega(z+1,k))+ Y_p(z+1,k)*cos(ik(z+1,k))*cos(omega(z+1,k));%ECEF coordinate system
        Z_s(z+1,k)= Y_p(z+1,k)*sin(ik(z+1,k)); %ECEF coordinate system
    end
end
% %%
%plotting
Re=6378; %%km
figure(1)
load('topo.mat'); 
clf
[xe ye ze]=sphere(50);
s=surface(xe*Re,ye*Re,ze*Re);

s.CData=topo;
s.FaceColor= 'texturemap';
s.EdgeColor= 'none';
s.FaceLighting= 'gouraud';
s.SpecularStrength= 0.4;
light('position',[-1 0 1])

axis square off
view([-30,30])

hold on

for z = 0:30
plot3 (X_s(z+1,:),Y_s(z+1,:),Z_s(z+1,:));
hold on
end

%%
figure(2);

 
topo2=zeros(size(topo));

for i_topo=1:180
    topo2(:,i_topo) = topo(:,180+i_topo);
    topo2(:,180+i_topo) = topo(:,i_topo);
end

hold on
image(-180:179 , -89:90 , topo2, 'CDatamap', 'scaled');

colormap(topomap1)
axis([-180 180 -90 90])

for  z = 0:30
  for  k=1:n_iter
    lla(k,:) = ecef2lla([1e3*X_s(z+1,k),1e3*Y_s(z+1,k),1e3*Z_s(z+1,k)],'WGS84');
  end
  lla(:,2) = control_long(lla(:,2));
  plot(lla(:,2),lla(:,1),'k');
  hold on
end

%% gdop

U_T(1,:) = [9.2321e3 2.0467e3 8.4561e3];              % xu yu zu is the distance of rome from earth center
U_T(2,:) = [1.269e4 0 0];              % Equator
U_T(3,:) = [0 0 1.2674e4];              % South pole

for     U_N = 1:3
for     H_k= 1:length(T_k)
    V_Sat = [];
       for n = 1:29  
                D_U=[X_s(n,H_k) Y_s(n,H_k) Z_s(n,H_k)];  % user distance
                d_s = (D_U-U_T(U_N,:)); % sat  distance
                teta(n) = atan2(norm(cross(d_s, U_T(U_N,:))/(norm(U_T(U_N,:))*norm(d_s))),dot(d_s, U_T(U_N,:))./(norm(U_T(U_N,:))*norm(d_s)));
                teta_deg(n)=teta(n)*180/pi;
                if teta_deg(n) >= 0 && teta_deg(n) <= 90 
                    V_Sat = [V_Sat n];    %no. of vissible satellites                
                end
       end
           
    for n = 1:size(V_Sat,2)
        rho = norm([X_s(V_Sat(n),H_k) Y_s(V_Sat(n),H_k) Z_s(V_Sat(n),H_k)]-U_T(U_N)); %UERE (user equivalent range error)
        DH(n,:) = [(X_s(V_Sat(n),H_k)-U_T(U_N,1))/rho (Y_s(V_Sat(n),H_k)-U_T(U_N,2))/rho (Z_s(V_Sat(n),H_k)-U_T(U_N,3))/rho   -1]; 
    end
       DSV=inv(DH.'*DH);
       GDOP(H_k) = sqrt(trace(DSV));
end
end
figure (3)
plot(T_k,GDOP)
title('GDOP-geometric dilution of precision')
xlabel('time in minutes')
ylabel('Ratio of position error to range error')
grid on




