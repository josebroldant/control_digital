s=tf('s');
a=[0 1 0;0 0 1;-1.244 -0.3956 -3.145];
b=[0;0;1.244];
c=[1 0 0];
d=0;
G=(s^2+10*s+100);%desempeño deseado
%orden minimo
Aaa=0;
Aab=[1 0];
Aba=[0;1.244];
Abb=[0 1;0.3956  -3.145];
Ba=0;
Bb=[0;1.244];
p=[-5+5*sqrt(3)*i,-5-5*sqrt(3)*i];
p1=[-5+5*sqrt(3)*i,-5-5*sqrt(3)*i,-10];
Ko=place(Abb',Aab',p)'%cte obs minim
k=place(a,b,p1);%cte realim state
Aaux=Abb-Ko*Aab;
Baux=Aaux*Ko+Aba+Ko*Aaa;
F=Bb-(Ko*Ba);
p=1;
q=1;
n=3;
plot(simout2.time(:,1),simout2.Data(:,1),'r')