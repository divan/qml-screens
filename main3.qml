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
        }
        ScreenItem {
            name: "4"
        }
    }
    ScreensRow {
        ScreenItem {
            name: "5"
        }
        ScreenItem {
            name: "6"
        }
    }
}
