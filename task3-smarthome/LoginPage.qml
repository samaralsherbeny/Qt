import QtQuick
import QtQuick.Controls

Page {
    id: loginPage

    background: Rectangle {
        color: "#F5F7FC"
    }

    Rectangle {
        id: card
        width: 360
        height: 440
        anchors.centerIn: parent

        radius: 20
        color: "white"

        border.color: "#22D3FF"
        border.width: 2

        Column {
            anchors.fill: parent
            anchors.margins: 25
            spacing: 16

            // Profile Icon Frame
            Rectangle {
                width: 90
                height: 90
                radius: 20
                color: "#F5F7FC"
                border.color: "#22D3FF"
                border.width: 2
                anchors.horizontalCenter: parent.horizontalCenter

                Image {
                    anchors.fill: parent
                    anchors.margins: 10
                    source: "qrc:/qt/qml/task3qt/images/logo.png"
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }
            }

            // Title & Subtitle
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 4

                Text {
                    text: "Smart Home"
                    color: "#0099FF"
                    font.pixelSize: 26
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Control your smart home"
                    color: "#6B7280"
                    font.pixelSize: 14
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            // USERNAME TEXTFIELD
            TextField {
                id: usernameInput
                width: parent.width
                height: 50
                placeholderText: "Username"
                font.pixelSize: 16
                color: "#1F2937"
                verticalAlignment: TextInput.AlignVCenter
                leftPadding: 15

                background: Rectangle {
                    radius: 12
                    color: "#FFFFFF"
                    border.color: "#22D3FF"
                    border.width: 1.5
                }
            }

            // PASSWORD TEXTFIELD
            TextField {
                id: passwordInput
                width: parent.width
                height: 50
                placeholderText: "Password"
                echoMode: TextInput.Password
                font.pixelSize: 16
                color: "#1F2937"
                verticalAlignment: TextInput.AlignVCenter
                leftPadding: 15

                background: Rectangle {
                    radius: 12
                    color: "#FFFFFF"
                    border.color: "#22D3FF"
                    border.width: 1.5
                }
            }

            // Login Button
            Button {
                width: parent.width
                height: 50

                background: Rectangle {
                    radius: 14
                    color: "#22D3FF"
                }

                contentItem: Text {
                    text: "Login"
                    color: "white"
                    font.pixelSize: 18
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    if (typeof stackView !== "undefined") {
                        stackView.push("DashboardPage.qml")
                    } else if (StackView.view) {
                        StackView.view.push("DashboardPage.qml")
                    }
                }
            }
        }
    }
}
