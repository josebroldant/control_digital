%ejemplo 1
x=1;
z=tf('z',0.1);
k=1;
k1=2.39;
P=(0.368*z+0.264)/(z^2-1.368*z+0.368);%planta
figure(1)
step(feedback(k*P,1))
figure(2)
step(feedback(k1*P,1))
step(P)

%ejemplo 2

z=tf('z',0.1);
p=[1 -0.9 0.2];
roots(p)

s=tf('s');
a=[0 1;0 0];
b=[0;1];
c=[1 0];
d=0;

az=[1 0.1;0 1];
bz=[(0.1^2)/2; 0.1];

[B,A]=ss2tf(az,bz,c,d);
eig(a)%numero de polos segun la matriz a 
G=1/s^2;
step(G)
c2d(G,0.1)
p1=[1 -2 1];
roots(p1)
s_v=ss(az,bz,c,d);

s_t_d=c2d(s_v,0.1);

[fii,gamma,h,m]=ssdata(s_t_d);
polos=[0.8+0.25*j 0.8-0.25*j];
place(fii,gamma,polos)