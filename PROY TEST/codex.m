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
G=(5.04*10^6)/(0.2*(s) + 1);
figure(1)
step(G)
figure(2)
plot(prueba1v10ms(:,2),prueba1v10ms(:,1)*(1/0.01)*(60000/20)*(360/60))

% % % % % % % % % 
G1=(4.7*10^6)/(0.15*(s) + 1);
figure(1)
step(G1)
figure(2)
plot(prueba1v50ms(:,2),prueba1v50ms(:,1)*(1/0.05)*(60000/20)*(360/60))
