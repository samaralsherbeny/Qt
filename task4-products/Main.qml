import QtQuick 2.15
import QtQuick.Controls 2.15

Window {
    id: window
    width: 700
    height: 800
    visible: true
    title: qsTr("ShopEase")

    // 1. Shared Cart Model
    ListModel {
        id: cartModel
    }

    // 2. Helper function to handle adding items
    function addToCart(itemTitle, itemPrice, itemImage) {
        // Check if item already exists in cart to increment quantity
        var found = false;
        for (var i = 0; i < cartModel.count; i++) {
            if (cartModel.get(i).title === itemTitle) {
                cartModel.setProperty(i, "quantity", cartModel.get(i).quantity + 1);
                found = true;
                break;
            }
        }

        // If not found, add a new item entry
        if (!found) {
            cartModel.append({
                "title": itemTitle,
                "price": itemPrice,
                "image": itemImage,
                "quantity": 1
            });
        }
    }

    // StackView / Page Loader
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "LoginPage.qml" // <-- Fixed: Changed from ProductsPage.qml to LoginPage.qml
    }
}
