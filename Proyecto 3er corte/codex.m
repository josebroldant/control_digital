figure(1)
plot(prueba1v10ms2(:,2),prueba1v10ms2(:,1)/1023)
figure(2)
plot(prueba1v10ms(:,2),prueba1v10ms(:,1)*(1/0.01)*(60000/20)*(360/60))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1v 10ms
%pulsos
prueba1v10ms(1,2)=0;
for i=1:length(prueba1v10ms)-1
   prueba1v10ms(i+1,2)=prueba1v10ms(i,2)+0.01;
end
plot(prueba1v10ms(:,2),prueba1v10ms(:,1)*(1/0.01)*(60000/20)*(360/60))
%voltaje
prueba1v10ms2(1,2)=0;
for i=1:length(prueba1v10ms2)-1
   prueba1v10ms2(i+1,2)=prueba1v10ms2(i,2)+0.01;
end
plot(prueba1v10ms2(:,2),prueba1v10ms2(:,1)/1023)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1v 20ms
%pulsos
prueba1v20ms(1,2)=0;
for i=1:length(prueba1v20ms)-1
   prueba1v20ms(i+1,2)=prueba1v20ms(i,2)+0.02;
end
plot(prueba1v20ms(:,2),prueba1v20ms(:,1)*(1/0.02)*(60000/20)*(360/60))
%voltaje
prueba1v20ms2(1,2)=0;
for i=1:length(prueba1v20ms2)-1
   prueba1v20ms2(i+1,2)=prueba1v20ms2(i,2)+0.02;
end
plot(prueba1v20ms2(:,2),prueba1v20ms2(:,1)/1023)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1v 30ms
%pulsos
prueba1v30ms(1,2)=0;
for i=1:length(prueba1v30ms)-1
   prueba1v30ms(i+1,2)=prueba1v30ms(i,2)+0.03;
end
plot(prueba1v30ms(:,2),prueba1v30ms(:,1)*(1/0.03)*(60000/20)*(360/60))
%voltaje
prueba1v30ms2(1,2)=0;
for i=1:length(prueba1v30ms2)-1
   prueba1v30ms2(i+1,2)=prueba1v30ms2(i,2)+0.03;
end
plot(prueba1v30ms2(:,2),prueba1v30ms2(:,1)/1023)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1v 40ms
%pulsos
prueba1v40ms(1,2)=0;
for i=1:length(prueba1v40ms)-1
   prueba1v40ms(i+1,2)=prueba1v40ms(i,2)+0.04;
end
plot(prueba1v40ms(:,2),prueba1v40ms(:,1)*(1/0.04)*(60000/20)*(360/60))
%voltaje
prueba1v40ms2(1,2)=0;
for i=1:length(prueba1v40ms2)-1
   prueba1v40ms2(i+1,2)=prueba1v40ms2(i,2)+0.04;
end
plot(prueba1v40ms2(:,2),prueba1v40ms2(:,1)/1023)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1v 50ms
%pulsos
prueba1v50ms(1,2)=0;
for i=1:length(prueba1v50ms)-1
   prueba1v50ms(i+1,2)=prueba1v50ms(i,2)+0.05;
end
plot(prueba1v50ms(:,2),prueba1v50ms(:,1)*(1/0.05)*(60000/20)*(360/60))
%voltaje
prueba1v50ms2(1,2)=0;
for i=1:length(prueba1v50ms2)-1
   prueba1v50ms2(i+1,2)=prueba1v50ms2(i,2)+0.05;
end
plot(prueba1v50ms2(:,2),prueba1v50ms2(:,1)/1023)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% planta

s=tf('s');

% % % % % % % % % 
G1=((4.474*10^6)*(exp(-s*0.05)))/(0.2*(s) + 1);
Kp=3.7721*10^-7;
Ki=2.2902*10^-6;
Kd=0;
C=Kp+(Ki/s);
feedback(C*G1,1)
figure(1)
step(G1)
hold on
step(feedback(C*G1,1))
figure(2)
plot(prueba1v50ms(:,2),prueba1v50ms(:,1)*(1/0.05)*(60000/20)*(360/60))

%%%%%%%DISCRETIZACION

%planta
z=tf('z',0.01);%operador z
Ts=0.01;
Gback=c2d(G1,Ts);
step(c2d(G1,Ts))%por defecto usa metodo backward
hold on
Gfor=c2d(G1,Ts,'forward');
step(c2d(G1,Ts,'forward'))
hold on
Gtus=(c2d(G1,Ts,'tustin'));
step(c2d(G1,Ts,'tustin'))

%controlador
step(c2d(C,Ts))%por defecto usa metodo backward
hold on
step(c2d(C,Ts,'forward'))
hold on
step(c2d(C,Ts,'tustin'))

%sistema en malla cerrada
step(c2d(feedback(C*G1,1),Ts))%por defecto usa metodo backward
hold on
step(c2d(feedback(C*G1,1),Ts,'forward'))
hold on
step(c2d(feedback(C*G1,1),Ts,'tustin'))

%Criterio de jury

s=tf('s');
G1=((4.474*10^6)*(exp(-s*0.05)))/(0.2*(s) + 1);
c2d(G1,0.01)
p1=[0.2 1];
roots(p1)
num=[(4.474*10^6)*(exp(-0.05))];
den=[0.2 1];
pzmap(num,den)


[fii,gamma,h,m]=ssdata(G1);
polos=[-5];
place(fii,gamma,polos)

