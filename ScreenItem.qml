// vim: et ts=4 sw=4:
import QtQuick 1.0

Rectangle {
    id: screen
    property alias name: label.text
    property alias background: image.source
    width: parent.width
    height: parent.height
    color: "white"
    radius: 15
    border.width: 1
    border.color: "black"

    Image {
        anchors.fill: parent
        id: image
    }
    Text {
        id: label
        font.pointSize: 25
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
