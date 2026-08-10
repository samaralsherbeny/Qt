import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: loginPage

    background: Rectangle {
        color: "#F5F7FC"
    }


    Rectangle {
        id: card

        width: 400
        height: 500

        anchors.centerIn: parent

        radius: 25

        color: "white"

        border.color: "#22D3FF"
        border.width: 2


        Column {
            anchors.fill: parent

            anchors.margins: 35

            spacing: 18


            // =================================================
            // LOGO
            // =================================================

            Rectangle {
                width: 90
                height: 90

                radius: 20

                anchors.horizontalCenter:
                    parent.horizontalCenter

                color: "#F5F7FC"

                border.color: "#22D3FF"
                border.width: 2


                Image {
                    anchors.fill: parent

                    anchors.margins: 10

                    source:
                        "qrc:/pictures/logo.png"

                    fillMode:
                        Image.PreserveAspectFit

                    smooth: true
                }
            }


            // =================================================
            // TITLE
            // =================================================

            Column {
                anchors.horizontalCenter:
                    parent.horizontalCenter

                spacing: 4


                Text {
                    text:
                        qsTr("Smart Home")

                    color: "#0099FF"

                    font.pixelSize: 28

                    font.bold: true

                    anchors.horizontalCenter:
                        parent.horizontalCenter
                }


                Text {
                    text:
                        qsTr("Control your smart home")

                    color: "#6B7280"

                    font.pixelSize: 14

                    anchors.horizontalCenter:
                        parent.horizontalCenter
                }
            }


            // =================================================
            // USERNAME
            // =================================================

            TextField {
                id: usernameInput

                width: parent.width

                height: 50

                placeholderText:
                    qsTr("Username")

                color: "#1F2937"

                placeholderTextColor:
                    "#9CA3AF"

                font.pixelSize: 16

                verticalAlignment:
                    TextInput.AlignVCenter

                leftPadding: 15


                background: Rectangle {

                    radius: 12

                    color: "#FFFFFF"

                    border.color: "#22D3FF"

                    border.width: 1.5
                }
            }


            // =================================================
            // PASSWORD
            // =================================================

            TextField {
                id: passwordInput

                width: parent.width

                height: 50

                placeholderText:
                    qsTr("Password")

                echoMode:
                    TextInput.Password

                color: "#1F2937"

                placeholderTextColor:
                    "#9CA3AF"

                font.pixelSize: 16

                verticalAlignment:
                    TextInput.AlignVCenter

                leftPadding: 15


                background: Rectangle {

                    radius: 12

                    color: "#FFFFFF"

                    border.color: "#22D3FF"

                    border.width: 1.5
                }
            }


            // =================================================
            // ERROR
            // =================================================

            Text {
                id: errorText

                width: parent.width

                text: ""

                color: "#EF4444"

                font.pixelSize: 13

                horizontalAlignment:
                    Text.AlignHCenter
            }


            // =================================================
            // LOGIN BUTTON
            // =================================================

            Button {
                width: parent.width

                height: 50

                text:
                    qsTr("Login")


                background: Rectangle {

                    radius: 14

                    color: "#22D3FF"
                }


                contentItem: Text {

                    text:
                        parent.text

                    color: "white"

                    font.pixelSize: 18

                    font.bold: true

                    horizontalAlignment:
                        Text.AlignHCenter

                    verticalAlignment:
                        Text.AlignVCenter
                }


                onClicked: {

                    if (usernameInput.text === "" ||
                        passwordInput.text === "") {

                        errorText.text =
                            qsTr(
                                "Please fill all fields"
                            )

                        return
                    }


                    errorText.text = ""


                    stackView.push(
                        "DashboardPage.qml"
                    )
                }
            }
        }
    }
}
