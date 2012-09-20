// vim: et ts=4 sw=4:
import QtQuick 1.0

ScreensGrid {
    width: 700
    height: 400
    ScreensRow {
        ScreenItem {
            name: "1"
            state: "SHOWN"
        }
        ScreenItem {
            name: "2"
        }
    }
    ScreensRow {
        ScreenItem {
            name: "3"
            Rectangle {
                width: 100
                height: 100
                x: 100
                y: 100
                color: "red"
                radius: 5
                MouseArea {
                    anchors.fill: parent
                    onClicked: { parent.color = "blue"; }
                }
            }
        }
        ScreenItem {
            name: "4"
        }
    }
}
