import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: loginPage

    // Background Image
    background: Image {
        source: "qrc:/icons/shop.png" // Change this to your preferred background image path
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent

        // Overlay to soften the image and make text readable
        Rectangle {
            anchors.fill: parent
            color: "#f5f7fb"
            opacity: 0.85
        }
    }

    ColumnLayout {
        width: Math.min(parent.width - 40, 360)
        anchors.centerIn: parent
        spacing: 15

        // App Logo / Title
        Text {
            text: "ShopEase"
            font.pixelSize: 32
            font.bold: true
            color: "#1976d2"
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: qsTr("Welcome Back")
            font.pixelSize: 22
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: qsTr("Login to continue shopping")
            color: "#666666"
            font.pixelSize: 14
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.preferredHeight: 10 }

        // Username / Email Input
        TextField {
            id: usernameField
            placeholderText: qsTr("Username or Email")
            Layout.fillWidth: true
            implicitHeight: 45
        }

        // Password Input
        TextField {
            id: passwordField
            placeholderText: qsTr("Password")
            echoMode: TextInput.Password
            Layout.fillWidth: true
            implicitHeight: 45
        }

        // Error Message
        Text {
            id: errorLabel
            text: qsTr("Please enter username and password.")
            color: "#d32f2f"
            font.pixelSize: 12
            visible: false
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.preferredHeight: 5 }

        // Login Button
        Button {
            id: loginBtn
            text: qsTr("Login")
            Layout.fillWidth: true
            implicitHeight: 48

            background: Rectangle {
                color: parent.down ? "#115293" : "#1976d2"
                radius: 8
            }

            contentItem: Text {
                text: loginBtn.text
                color: "white"
                font.bold: true
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            onClicked: {
                if (usernameField.text.trim() === "" || passwordField.text.trim() === "") {
                    errorLabel.visible = true
                } else {
                    errorLabel.visible = false

                    if (typeof stackView !== "undefined" && stackView !== null) {
                        stackView.replace(Qt.resolvedUrl("HomePage.qml"))
                    }
                }
            }
        }

        // Guest / Skip Button
        Button {
            text: qsTr("Continue as Guest")
            flat: true
            Layout.alignment: Qt.AlignHCenter

            onClicked: {
                if (typeof stackView !== "undefined" && stackView !== null) {
                    stackView.replace(Qt.resolvedUrl("HomePage.qml"))
                }
            }
        }
    }
}
