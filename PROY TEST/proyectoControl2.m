cuentas(1,2)=0;
for i=1:length(cuentas)-1
    cuentas(i+1,2)=cuentas(i,2)+0.01;
end
plot(cuentas(:,2),cuentas(:,1)*(1/0.01)*(60000/20))
cuentas10ms=cuentas;
% 
cuentas1ms(1,2)=0;
cuentas5ms(1,2)=0;
for i=1:length(cuentas5ms)-1
    cuentas5ms(i+1,2)=cuentas5ms(i,2)+0.005;
end
plot(cuentas(:,2),cuentas(:,1)*(1/0.01)*(60000/20))
hold on
plot(cuentas5ms(:,2),cuentas5ms(:,1)*(1/0.005)*(60000/20))


cuentas5V5ms(1,2)=0;
for i=1:length(cuentas5V5ms)-1
    cuentas5V5ms(i+1,2)=cuentas5V5ms(i,2)+0.005;
end
plot(cuentas5V5ms(:,2),cuentas5V5ms(:,1)*(1/0.005)*(60000/20))
% 
pruebas3v10m(1,2)=0;
for i=1:length(pruebas3v10m)-1
    pruebas3v10m(i+1,2)=pruebas3v10m(i,2)+0.01;
end
plot(pruebas3v10m(:,2),pruebas3v10m(:,1)*(1/0.01)*(60000/20))
% 
prueba7v100m(1,2)=0;
for i=1:length(prueba7v100m)-1
    prueba7v100m(i+1,2)=prueba7v100m(i,2)+0.1;
end
plot(prueba7v100m(:,2),prueba7v100m(:,1)*(1/0.1)*(60000/20))


% 
prueba6v25(1,2)=0;
for i=1:length(prueba6v25)-1
    prueba6v25(i+1,2)=prueba6v25(i,2)+0.025;
end
plot(prueba6v25(:,2),prueba6v25(:,1)*(1/0.025)*(60000/20))









