// vim: et ts=4 sw=4:
import QtQuick 1.0

ScreensGrid {
    width: 800
    height: 480
    ScreensRow {
        ScreenItem {
            name: "1"
            background: "images/bg0.png"
        }
        ScreenItem {
            name: "2"
            background: "images/bg1.png"
        }
    }
    ScreensRow {
        ScreenItem {
            name: "3"
            background: "images/bg2.png"
        }
        ScreenItem {
            name: "4"
            background: "images/bg3.png"
        }
    }
}
