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

    MouseArea {
        anchors.fill: parent
        property int startX
        property int startY
        property int dragDirection
        onPressed: {
            if (mouse.button == Qt.LeftButton)
            {
               startX = mouse.x;
               startY = mouse.y;
            }
            dragDirection = 0;
        }
        onPositionChanged: {
            var swipeX = mouse.x - startX;
            var swipeY = mouse.y - startY;
            console.log("Mouse -> " + swipeX + ", " + swipeY);

            var absX = Math.abs(swipeX);
            var absY = Math.abs(swipeY);
            if (dragDirection == 0 && (absX > 10 || absY > 10))
            {
                if (absX > absY)
                    dragDirection = 1;
                else 
                    dragDirection = 2;
            }

            if (dragDirection == 1)
                screen.x = swipeX;
            else if (dragDirection == 2)
                screen.y = swipeY;

            if (Math.abs(swipeX) < 50 && swipeY > 100)
            {
                // swipe up
                //console.log("SWIPE UP DETECTED");
                screen.parent.parent.switched(1);
            }
            else
            if (Math.abs(swipeX) < 50 && swipeY < -100)
            {
                // swipe down
                //console.log("SWIPE DOWN DETECTED");
                screen.parent.parent.switched(2);
            }
            else
            if (swipeX < -100 && Math.abs(swipeY) < 50)
            {
                // swipe right
                //console.log("SWIPE RIGHT DETECTED");
                screen.parent.parent.switched(3);
            }
            else
            if (swipeX > 100 && Math.abs(swipeY) < 50)
            {
                // swipe left
                //console.log("SWIPE LEFT DETECTED");
                screen.parent.parent.switched(4);
            }
        }
        onReleased: {
            screen.x = 0;
            screen.y = 0;
            dragDirection = 0;
        }
    }

    states: [
        State {
            name: "SHOWN"
                PropertyChanges { target: screen; visible: true }
                PropertyChanges { target: screen; x: 0 }
                PropertyChanges { target: screen; y: 0 }
        },
        State {
            name: "HIDDEN"
                PropertyChanges { target: screen; visible: false }
                PropertyChanges { target: screen; height: 0 }
                PropertyChanges { target: screen; width: 0 }
        }
    ] 

    NumberAnimation {
        id: hideAnimationDown;
        target: screen;
        property: "y";
        from: 0
        to: -screen.height;
        duration: 500
        easing.type: Easing.InBack;
    }
    NumberAnimation {
        id: showAnimationDown;
        target: screen;
        property: "y";
        from: screen.height;
        to: 0;
        duration: 500
        easing.type: Easing.OutBack;
    }
    NumberAnimation {
        id: hideAnimationUp;
        target: screen;
        property: "y";
        from: 0;
        to: screen.height;
        duration: 500
        easing.type: Easing.InBack;
    }
    NumberAnimation {
        id: showAnimationUp;
        target: screen;
        property: "y";
        from: -screen.height;
        to: 0
        duration: 500
        easing.type: Easing.OutBack;
    }
    NumberAnimation {
        id: hideAnimationRight;
        target: screen;
        property: "x";
        from: 0
        to: -screen.width;
        duration: 500
        easing.type: Easing.InBack;
    }
    NumberAnimation {
        id: showAnimationRight;
        target: screen;
        property: "x";
        from: screen.width;
        to: 0;
        duration: 500
        easing.type: Easing.OutBack;
    }
    NumberAnimation {
        id: hideAnimationLeft;
        target: screen;
        property: "x";
        from: 0;
        to: screen.width;
        duration: 500
        easing.type: Easing.InBack;
    }
    NumberAnimation {
        id: showAnimationLeft;
        target: screen;
        property: "x";
        from: -screen.width;
        to: 0
        duration: 500
        easing.type: Easing.OutBack;
    }

    function hide(direction) {
        switch (direction) {
        case 1:
            hideAnimationUp.restart();
            break;
        case 2:
            hideAnimationDown.restart();
            break;
        case 3:
            hideAnimationRight.restart();
            break;
        case 4:
            hideAnimationLeft.restart();
            break;
        default:
        }
    }

    function show(direction) {
        switch (direction) {
        case 1:
            showAnimationUp.restart();
            break;
        case 2:
            showAnimationDown.restart();
            break;
        case 3:
            showAnimationRight.restart();
            break;
        case 4:
            showAnimationLeft.restart();
            break;
        default:
        }
    }
}
