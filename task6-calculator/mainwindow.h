#include <QMainWindow>
#include <QLineEdit>
#include <QPushButton>
#include <QGridLayout>
#include <QVBoxLayout>
#include <QString>

class MainWindow : public QMainWindow {
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = nullptr);
    ~MainWindow() override = default;

private slots:
    void onDigitClicked();
    void onOperatorClicked();
    void onEqualClicked();
    void onClearClicked();

private:
    void setupUI();
    double calculateResult(double operand1, double operand2, const QString &op);

    QLineEdit *displayLineEdit;

    double leftOperand = 0.0;
    QString pendingOperator = "";
    bool waitingForNewNumber = true;
};

#endif // MAINWINDOW_H
