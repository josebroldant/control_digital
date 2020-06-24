s=tf('s');
a=[-6 -11 -6;1 0 0;0 1 0];
b=[1;0;0];
c=[0 0 10];
d=0;
G=(s^3+14*s^2+56*s+160);%desempeño deseado
p=[-2+2*sqrt(3)*i,-2-2*sqrt(3)*i,-10];
k=place(a,b,p);%cte de realim state
plot(simout.time(:,1),simout.Data(:,1),'r')
hold on
plot(simout.time(:,1),simout.Data(:,2),'b')
