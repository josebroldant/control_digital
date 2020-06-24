s=tf('s');
a=[0 1;0 -1];
b=[0; 10];
c=[1 0];
d=0;
G=10/(s^2+s);
G1=(s^2+4*s+8);%desempeño deseado
kp=0.8;
kd=0.3*s;
k=[0.8 0.3]
kder=0.3;
%ahora con los comandos nuevos
p=[-10+10*i -10-10*i];%polos
place(a,b,p)
acker(a,b,p)
k1=[8.8 2.3];
k2=16;
p=1;
q=1;
n=2;
%orden minimo
Aaa=0;
Aab=1;
Aba=0;
Abb=-1;
Ba=0;
Bb=10;
%solo usar un polo para evitar ´probelmas en las dimensiones
polos=-20;
Ko=place(Abb',Aab',polos)'
Aaux=Abb-Ko*Aab;
Baux=Aaux*Ko+Aba+Ko*Aaa;
F=Bb-Ko*Ba;



