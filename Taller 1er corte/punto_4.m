s=tf('s');
a=[0 1;0 0];
b=[0;1];
c=[1 0];
d=0;
G=(s^2+sqrt(2)*s+1);%desempeño deseado realim state
G1=(s+5);%desempeño deseado obsv minim
prealim=[-0.7071+0.7071*i,-0.7071-0.7071*i];
pobsv=-5;
Aaa=0;
Aab=1;
Aba=0;
Abb=0;
Ba=0;
Bb=1;
k=place(a,b,prealim);%cte de realim state
Ko=place(Abb',Aab',pobsv)'%cte obs minim
k1=1;
k2=sqrt(2);
p=1;
q=1;
n=3;
%orden minimo
Aaux=Abb-Ko*Aab;
Baux=Aaux*Ko+Aba+Ko*Aaa;
F=Bb-(Ko*Ba);
plot(simout3.time(:,1),simout3.Data(:,1),'r')