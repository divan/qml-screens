// vim: et ts=4 sw=4:
import QtQuick 1.0

Row {
    id: row
    width: parent.width
    height: parent.height

    states: [
            State {
                name: "SHOWN"
                    PropertyChanges { target: row; visible: true }
            },
            State {
                name: "HIDDEN"
                    PropertyChanges { target: row; visible: false }
            }
       ]
}
