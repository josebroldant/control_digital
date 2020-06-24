p1=[1 3.148 1.975 1.47];
roots(p1)

p=[1 0.6348 0.4761];
roots(p)
s=tf('s');
pid=0.049+(0.151/s)+0.331*s;
G=10/(s^2+0.5*s+2);
step(G)
step(feedback(pid*G,1))

z=tf('z',0.0844);
Ts=0.0844;
Gz=c2d(G,Ts);

%punto 3
%forward
plot(simout.time(:,1),simout.Data(:,1),'r')
hold on
plot(simout.time(:,1),simout.Data(:,2),'b')
%backward
plot(simout1.time(:,1),simout1.Data(:,1),'r')
hold on
plot(simout1.time(:,1),simout1.Data(:,2),'b')
%tustin
plot(simout2.time(:,1),simout2.Data(:,1),'r')
hold on
plot(simout2.time(:,1),simout2.Data(:,2),'b')

%punto 6
%polos forward
numfor=[3.31 -6.13 4.82];
denfor=[1 0.81 -2.13 1.83];
pzmap(numfor,denfor)
figure(1)
zplane(numfor,denfor)
%polos backward
numbac=[5.31 -6.62 2.82 0];
denbac=[8.81 -13.11 6.81 -1];
pzmap(numbac,denbac)
figure(1)
zplane(numbac,denbac)
%polos tustin
numtus=[15.73 -7.73 -9.69 13.77];
dentus=[29.73 -29.73 8.31 3.77];
pzmap(numtus,dentus)
figure(1)
zplane(numtus,dentus)

%punto 7
%forward
Gt=(3.31*s^2 + 0.49*s +1.51)/(s^3 + 3.81*s^2 + 2.49*s +1.51);
Gzfor=(3.31*z^2 -6.62*z + 4.82)/(z^3 + 0.81*z^2 - 2.13*z + 1.83);
step(Gt)
hold on
step(Gzfor)
%backward
Gzbac=(5.31*z^3 - 6.62*z^2 + 2.82*z)/(8.81*z^3 - 13.11*z^2 + 6.81*z - 1);
step(Gt)
hold on
step(Gzbac)
%tustin
Gztus=(15.73*z^3 - 7.73*z^2 - 9.69*z + 13.77)/(29.73*z^3 - 29.73*z^2 + 8.31*z + 3.77);
step(Gt)
hold on
step(Gztus)