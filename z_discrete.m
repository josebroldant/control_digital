z=tf('z',2);%operador z
PID=(1.135*(z+0.523))/((z-1)*(z-0.135));
num=[1.135 0.593605];
den=[1 -1.135 0.135];
printsys(num,den,'z')
pzmap(num,den)
figure(1)
zplane(num,den)
nyquistplot(PID)
nyquist(PID)
pzmap(PID)