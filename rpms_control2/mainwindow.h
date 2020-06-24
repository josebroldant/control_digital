#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QSerialPort>
#include <QByteArray>
#include <QTimer>
#include <QtGui>
#include <QVector>
#include <Qfile>
#include <QString>
#include <QTextStream>

namespace Ui {

    class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
    void mensaje(QString men);
private slots:
    void on_pushButton_clicked();

    void on_pushButton_2_clicked();

    void on_btpuerto_clicked();

    void recibedatos();

    void temporizar();

    void peticiones();

    void on_btguardar_2_clicked();

    void on_ciclopwm_valueChanged(int value);

    void on_bt100_clicked();

    void on_bt0_clicked();

private:
    Ui::MainWindow *ui;
};

#endif // MAINWINDOW_H
void configurapuerto(QString nombre);
unsigned char armacehksum(char *mtx,int cantidad);
