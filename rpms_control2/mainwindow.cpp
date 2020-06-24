#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>
#include <QMessageBox>
#include <Qfile>
#include <QString>
#include <QTextStream>
#include <QSerialPort>
#include <QTimer>
#include <QFileDialog>


QSerialPort *mipuerto;//for serial comunication
QTimer *timoutpuerto;//timer puerto
QTimer *timcomunicacion;//timer rx y tx
QFile file;
unsigned char mtrecepcion[9]; //byte recibido
char mtenvio[21];//envio lcd
int conexion,flagpeticion;
int estado,timout,contador,cantidad;
int estadoarchivo;
int valorproporcional,valorintegral;
int numeropulsos;
int estadoproceso;
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    mipuerto = new QSerialPort(this);
    timoutpuerto= new QTimer(this);
    timcomunicacion= new QTimer(this);
    connect(mipuerto,SIGNAL(readyRead()),this,SLOT(recibedatos()));//recepcion rx
    conexion=0;
    estado=0; // estado de recibimiento de datos
    timout=0; // maneja el tiempo maximo para completar la recepcion de la trama
    cantidad=0; // num bytes
    contador=0;
    connect(timoutpuerto, SIGNAL(timeout()), this, SLOT(temporizar()));//salto de estados
    timoutpuerto->start(1);
    connect(timcomunicacion, SIGNAL(timeout()), this, SLOT(peticiones()));//inicio de cambio de tiempo o mensaje lcd
    timcomunicacion->start(300);
    for(int u=0;u<9;u++){
        mtrecepcion[u]=0; //tamaño del byte
    }
    for(int u=0;u<21;u++){
        mtenvio[u]=0; //mensaje lcd
    }
    estadoarchivo=0;
    estadoproceso=0;
}

    MainWindow::~MainWindow(){
        if(mipuerto->isOpen()){
            mipuerto->close();
        }
        timoutpuerto->stop();
        timcomunicacion->stop();
        delete ui;
    }

void MainWindow::on_pushButton_clicked(){

    QString Nombre = ui->txtnombre->text();
    if(Nombre.isEmpty()){
       mensaje("Favor complete el nombre del archivo");
       return;
    }
    QString carpeta=ui->lbruta->text();
    if(carpeta.isEmpty()){
       mensaje("Favor seleccione la ruta");
       return;
    }
    if(conexion==0){
       mensaje("Favor abrir el puerto de comunicaciones");
       return;
    }
    if(estadoproceso==2){ // proceso del controlador
        mensaje("Favor hacer click en 'detener' para poder continuar");
        return;
    }
    if(file.isOpen()){
        file.close();
    }
    ui->recopilador->clear();
    file.setFileName(carpeta+"/"+Nombre+".txt");
    if(file.open(QIODevice::WriteOnly | QIODevice::Text)){
           estadoarchivo=1;
    }
    flagpeticion=1;
    estadoproceso=1;
}


void MainWindow::on_pushButton_2_clicked()
{
    if(estadoproceso==1){
        if(file.isOpen()){
           file.close();
        }
        estadoarchivo=0;
        estadoproceso=0;
        if(conexion==1){
            flagpeticion=2;
        }
    }
}


void MainWindow::on_btpuerto_clicked()
{
    if(mipuerto->isOpen()){
        mipuerto->close();
    }
    if(conexion==0){
        if(mipuerto->isOpen()){
            mipuerto->close();
        }
        configurapuerto(ui->nombrepuerto->text()); //label
        mipuerto->open(QSerialPort::ReadWrite);//lectura del serial
        mipuerto->waitForReadyRead(1000);//funciones de leido y escribir
        mipuerto->waitForBytesWritten(1000);
        conexion=1;
        ui->btpuerto->setText("Desconectar");//cambio para inhabilitar
    }else{
        conexion=0;
        ui->btpuerto->setText("Conectar");
    }
}

/// funcion de configuracion de puerto
void configurapuerto(QString nombre){

   mipuerto->setPortName(nombre);
   mipuerto->setBaudRate(QSerialPort::Baud9600);
   mipuerto->setDataBits(QSerialPort::Data8);
   mipuerto->setParity(QSerialPort::NoParity);
   mipuerto->setStopBits(QSerialPort::OneStop);
   mipuerto->setFlowControl(QSerialPort::NoFlowControl);

}

void MainWindow::recibedatos()//rx config
{
    while (!mipuerto->atEnd()) {


        QByteArray data = mipuerto->readAll();//leer byte del protocolo
        for(int x=0;x<data.length();x++){
            unsigned char valorx=data.at(x);
            timout=0;

            switch (estado) {
            case 0: // se espera la recepcion de el caracter de inicio
                if(valorx==1){
                  estado=1; // recepcion del tamaño
                  contador=0;
                  mtrecepcion[contador]=valorx;
                  contador++;
                }
                break;
            case 1:
                estado=2;// se pasa a la recepcion del comando
                mtrecepcion[contador]=valorx;
                contador++;
                cantidad=valorx+1; // los datos mas el checksum
                break;
            case 2:
                if(valorx==1){ // recepcion del comando que en este caso es siempre 1
                   estado=3;  // recepcion de los datos
                   mtrecepcion[contador]=valorx;
                   contador++;
                }
                break;
            case 3:
                mtrecepcion[contador]=valorx;
                contador++;
                cantidad--;
                if(cantidad<=0){ // llegaron todos los datos
                    estado=4; // recepcion del caracter final
                }
                break;
            case 4:
                if(valorx==3){
                    mtrecepcion[contador]=valorx;
                    contador++;//recepcion de pulsos
                    double rpmMotor;
                    rpmMotor=(600.0*(mtrecepcion[3]*256+mtrecepcion[4]));
                    rpmMotor/=20;
                    QString valorstr=QString::number(rpmMotor, 'f', 1);
                    if(estadoarchivo==1){
                        QTextStream textox(&file);
                        textox<<valorstr<<endl;
                    }
                    ui->recopilador->appendPlainText(valorstr);
                    ui->progressBar->setValue(rpmMotor);
                    ui->lcdNumber->display(valorstr);
                    estado=0;
                }
                break;
            default:
                break;
            }
        }
        //ui->recopilador->appendPlainText(datostest);
        //ui->lbtest->setText(datostest);
    }
}

void MainWindow::temporizar()//control de tiempo de los estados
{
    if(estado!=0){
       timout++;
       if(timout>5000){
           timout=0;
           estado=0;
       }
    }
}


void MainWindow::on_btguardar_2_clicked()
{
    QString dir = QFileDialog::getExistingDirectory(this, tr("Open Directory"),
                                                    "C:/Users",
                                                    QFileDialog::ShowDirsOnly
                                                    | QFileDialog::DontResolveSymlinks);
    ui->lbruta->setText(dir);
}
void MainWindow::mensaje(QString men){
    QMessageBox msgBox;
    msgBox.setText(men);
    msgBox.exec();
}

unsigned char armacehksum(char *mtx,int cantidad){//funcion de la checksum
    int8_t suma=0;
    for (int y=0;y<cantidad;y++)
    {
       suma+=*(mtx+y+1);
    }
    return (char)suma;
}

void MainWindow::peticiones()//acciones 0 rx tx 1 modif tiempo 2 mens lcd
{
    if(conexion==1){
            QString temptimepo;
            int tamenvio=0;
            mtenvio[0]=1;
            if(flagpeticion==1){ // envio start
                mtenvio[1]=1; // cantidad de datos
                mtenvio[2]=1; // comando peticion de datos
                mtenvio[3]=ui->ciclopwm->value();
                mtenvio[4]=armacehksum(mtenvio,3);
                mtenvio[5]=3;
                tamenvio=6;
                flagpeticion=0;//reiniciar la bandera para que transifera normal
            }else if (flagpeticion==2) { // stop
                mtenvio[1]=1; // cantidad de datos
                mtenvio[2]=2; // comando peticion de datos
                mtenvio[3]=128;
                mtenvio[4]=armacehksum(mtenvio,3);
                mtenvio[5]=3;
                tamenvio=6;
                flagpeticion=0;//reiniciar la bandera para que transifera normal
            }else if (flagpeticion==3) { // cambio de ciclo util
                mtenvio[1]=1; // cantidad de datos
                mtenvio[2]=3; // comando peticion de datos
                mtenvio[3]=ui->ciclopwm->value();
                mtenvio[4]=armacehksum(mtenvio,3);
                mtenvio[5]=3;
                tamenvio=6;
                flagpeticion=0;//reiniciar la bandera para que transifera normal

            }
            mipuerto->write(mtenvio,tamenvio);//envio de la info
        }
}

void MainWindow::on_ciclopwm_valueChanged(int value)
{

    double varciclox=(value/255.0)*100.0;
    ui->label->setText(QString::number(varciclox, 'f', 0));
    if(conexion==1){
       flagpeticion=3;
    }

}

void MainWindow::on_bt100_clicked()
{

    ui->label->setText(QString::number(100, 'f', 0));//CAMBIAR 50 POR 100
    ui->ciclopwm->setValue(254);//OJO CAMBIAR POR 254
    if(conexion==1){
       flagpeticion=3;
    }

}

void MainWindow::on_bt0_clicked()
{
    ui->label->setText(QString::number(128, 'f', 0));
    ui->ciclopwm->setValue(128);
    if(conexion==1){
       flagpeticion=3;
    }
}




