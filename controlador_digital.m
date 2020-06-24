%PASO 1
Ts=0.02;
s=tf('s');
G=2/(s^2+0.03*s+2.25);%planta
G1=s^2+0.79*s+0.45;%deseado
step(G)
step(feedback(G,1))
ts=0.5;%tiempo de muestreo ts<=tss/10
polos=[1 0.03 2.25];
pole=roots(polos);
polos2=[1 0.79 0.45];
pole2=roots(polos2);
num=2;
den=[1 0.03 2.25];
[a,b,c,d]=tf2ss(num,den);
contmat=ctrb(a,b);
obsermat=obsv(a,c);
det(contmat)
det(obsermat)
%controlador pid PASO 2
kd=2.375;
ki=0.64;
kp=0.625;
C=kp+kd*s+(ki/s);
step(feedback(C*G,1))
%PASO 4
c2d(G,0.1)
c2d(G,0.5)
z=tf('z',0.5);%operador z
PID=(0.2373*z+0.2371)/(z^2-1.452*z+0.9851);
PID1=0.625+(0.3225/(1-(z^-1)))+4.75*(1-(z^-1));
step(feedback(PID*PID1,1))
%Estabilidad en tiempo cotinuo, no garantiza estabilidad en tiempo discreto
step(G)
hold on
step(c2d(G,Ts))%por defecto usa metodo backward
hold on
step(c2d(G,Ts,'foh'))
hold on
step(d2d(c2d(G,Ts),Ts))