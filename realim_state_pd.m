s=tf('s');
a=[0 1;0 -1];
b=[0; 10];
c=[1 0];
d=0;
ft=ss(a,b,c,d);
contr=ctrb(ft)
obsvr=obsv(ft)
rank = (contr)
rank = (obsvr)
G=10/(s^2+s);
G1=(s^2+4*s+8);%desempeño deseado
step(G)
r=[1 1 0];
roots(r)
r1=[1 4 8];
roots(r1)
step(feedback(G,1),'b')
kp=0.8;
kd=0.3*s;
step(feedback(G*(kp+kd),1),'r')
PD=kp+kd*s;
k=[0.8 0.3]
kder=0.3;
%ahora con los comandos nuevos
p=[-2+2*i,-2-2*i];
place(a,b,p)
acker(a,b,p)
%realimentacion de k1 y k2
aext=[a zeros(2,1);-c 0];
bext=[b;-d];
Aaux=cat(2, cat(1,a,-c),zeros(3,1));
Baux=cat(1,b,-d);
prem=[-2+2*i,-2-2*i,-60]%se usa el polo remanente -20 para que sea estable y este a una decada de la parte real
place(Aaux,Baux,prem)
acker(Aaux,Baux,prem)
k1=[8.8 2.3];
k2=16;
p=1;
q=1;
n=2;
k_prima=[8.8 2.3 -16];
k1_1=k_prima(p,1:n);
k2_2=k_prima(p,n+1:n+q);
p_corridos=[-100 -100];
%hay que modificar los polos corridos
p_corridos_2=[-10+10*i -10-10*i];
roots([1 20 200])
Ko=[199; 9801];
Ko_corr_2=[149; 4851];
place(a',c',p_corridos)'%problemas
place(a',c',p_corridos_2)'



