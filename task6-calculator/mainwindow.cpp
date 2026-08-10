#include "mainwindow.h"
#include <cmath>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent) {
    setupUI();
    resize(360, 480);
    setWindowTitle("Watercolor Calculator");
}

void MainWindow::setupUI() {
    auto *centralWidget = new QWidget(this);
    setCentralWidget(centralWidget);

    centralWidget->setStyleSheet("background-color: #EBF4F6;");

    auto *mainLayout = new QVBoxLayout(centralWidget);
    mainLayout->setContentsMargins(18, 18, 18, 18);
    mainLayout->setSpacing(12);

    // --- DISPLAY SCREEN ---
    displayLineEdit = new QLineEdit("0", this);
    displayLineEdit->setReadOnly(true);
    displayLineEdit->setAlignment(Qt::AlignRight);
    displayLineEdit->setStyleSheet(
        "QLineEdit {"
        "   background-color: #3B7A57;"
        "   color: #FFFFFF;"
        "   font-size: 26pt;"
        "   font-weight: bold;"
        "   padding: 12px;"
        "   border: none;"
        "   border-radius: 12px;"
        "}"
        );
    mainLayout->addWidget(displayLineEdit);

    // --- BUTTON GRID ---
    auto *gridLayout = new QGridLayout();
    gridLayout->setSpacing(10);

    const QString buttonLabels[5][4] = {
        {"C",   "±",   "%",   "/"},
        {"7",   "8",   "9",   "*"},
        {"4",   "5",   "6",   "-"},
        {"1",   "2",   "3",   "+"},
        {"0",   ".",   "^",   "="}
    };

    // Watercolor Styles
    QString numStyle =
        "QPushButton {"
        "   background-color: #A2C4C9; color: #1F3A3D; font-size: 16pt; font-weight: bold;"
        "   border-radius: 10px; border: none;"
        "}"
        "QPushButton:hover { background-color: #B5D5DA; }"
        "QPushButton:pressed { background-color: #8EB3B8; }";

    QString opStyle =
        "QPushButton {"
        "   background-color: #F8C8A3; color: #4A2B11; font-size: 18pt; font-weight: bold;"
        "   border-radius: 10px; border: none;"
        "}"
        "QPushButton:hover { background-color: #FDD8B8; }"
        "QPushButton:pressed { background-color: #E3B38D; }";

    QString clearStyle =
        "QPushButton {"
        "   background-color: #F2A2B8; color: #4A1325; font-size: 16pt; font-weight: bold;"
        "   border-radius: 10px; border: none;"
        "}"
        "QPushButton:hover { background-color: #F8B8C9; }"
        "QPushButton:pressed { background-color: #DC8C9E; }";

    QString equalStyle =
        "QPushButton {"
        "   background-color: #92B99B; color: #16361C; font-size: 18pt; font-weight: bold;"
        "   border-radius: 10px; border: none;"
        "}"
        "QPushButton:hover { background-color: #A6CBAF; }"
        "QPushButton:pressed { background-color: #7EA787; }";

    for (int row = 0; row < 5; ++row) {
        for (int col = 0; col < 4; ++col) {
            QString text = buttonLabels[row][col];

            auto *btn = new QPushButton(text, this);
            btn->setMinimumSize(58, 58);

            if (text == "C") {
                btn->setStyleSheet(clearStyle);
                connect(btn, &QPushButton::clicked, this, &MainWindow::onClearClicked);
            } else if (text == "=") {
                btn->setStyleSheet(equalStyle);
                connect(btn, &QPushButton::clicked, this, &MainWindow::onEqualClicked);
            } else if (text == "+" || text == "-" || text == "*" || text == "/" || text == "^") {
                btn->setStyleSheet(opStyle);
                connect(btn, &QPushButton::clicked, this, &MainWindow::onOperatorClicked);
            } else if (text == "%" || text == "±") {
                btn->setStyleSheet(opStyle);
                connect(btn, &QPushButton::clicked, this, &MainWindow::onDigitClicked);
            } else {
                btn->setStyleSheet(numStyle);
                connect(btn, &QPushButton::clicked, this, &MainWindow::onDigitClicked);
            }

            gridLayout->addWidget(btn, row, col);
        }
    }

    mainLayout->addLayout(gridLayout);
}

static double extractCurrentValue(const QString &text) {
    if (text.contains('=')) {
        QStringList parts = text.split('=');
        return parts.last().trimmed().toDouble();
    }
    return text.toDouble();
}

void MainWindow::onDigitClicked() {
    auto *clickedButton = qobject_cast<QPushButton*>(sender());
    if (!clickedButton) return;

    QString buttonText = clickedButton->text();
    double currentVal = extractCurrentValue(displayLineEdit->text());

    // Instantly divide by 100 when % is clicked
    if (buttonText == "%") {
        displayLineEdit->setText(QString::number(currentVal / 100.0));
        waitingForNewNumber = true;
    } else if (buttonText == "±") {
        displayLineEdit->setText(QString::number(-currentVal));
    } else {
        if (waitingForNewNumber || displayLineEdit->text().contains('=')) {
            displayLineEdit->clear();
            waitingForNewNumber = false;
        }
        displayLineEdit->setText(displayLineEdit->text() + buttonText);
    }
}

void MainWindow::onOperatorClicked() {
    auto *clickedButton = qobject_cast<QPushButton*>(sender());
    if (!clickedButton) return;

    QString clickedOperator = clickedButton->text();
    double currentValue = extractCurrentValue(displayLineEdit->text());

    if (!pendingOperator.isEmpty() && !waitingForNewNumber) {
        leftOperand = calculateResult(leftOperand, currentValue, pendingOperator);
        displayLineEdit->setText(QString::number(leftOperand));
    } else {
        leftOperand = currentValue;
    }

    pendingOperator = clickedOperator;
    waitingForNewNumber = true;
}

void MainWindow::onEqualClicked() {
    if (pendingOperator.isEmpty()) return;

    double rightOperand = extractCurrentValue(displayLineEdit->text());
    double result = calculateResult(leftOperand, rightOperand, pendingOperator);

    displayLineEdit->setText(QString("%1 %2 %3 = %4")
                                 .arg(leftOperand)
                                 .arg(pendingOperator)
                                 .arg(rightOperand)
                                 .arg(result));

    pendingOperator.clear();
    waitingForNewNumber = true;
}

void MainWindow::onClearClicked() {
    leftOperand = 0.0;
    pendingOperator.clear();
    waitingForNewNumber = true;
    displayLineEdit->setText("0");
}

double MainWindow::calculateResult(double op1, double op2, const QString &op) {
    if (op == "+") return op1 + op2;
    if (op == "-") return op1 - op2;
    if (op == "*") return op1 * op2;
    if (op == "/") return (op2 != 0.0) ? (op1 / op2) : 0.0;
    if (op == "^") return std::pow(op1, op2);
    return op2;
}
