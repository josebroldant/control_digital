s=tf('s');
a=[0 1 0;0 0 1;-5 -6 0];
b=[0;0;1];
c=[1 0 0];
d=0;
G=(s^3+35*s^2+400*s+1500);%desempeño deseado
p=[-10,-10,-15];
k=acker(a,b,p);
Ko=acker(a',c',p)';%cte obsv comp
plot(simout1.time(:,1),simout1.Data(:,2),'b')