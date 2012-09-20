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
        property int gridX
        property int gridY
        property int dragDirection
        property bool success: false
        onPressed: {
            console.log("(DD) Mouse pressed");
            if (mouse.button == Qt.LeftButton || mouse.wasHeld)
            {
               startX = mouse.x;
               startY = mouse.y;
               gridX = screen.parent.parent.x;
               gridY = screen.parent.parent.y;
            }
            dragDirection = 0;
            success = false;
        }
        onPositionChanged: {
            if (success)
                return; 
            var swipeX = mouse.x - startX;
            var swipeY = mouse.y - startY;
            //console.log("Mouse(" + mouse.x + "," + mouse.y + ") -> " + swipeX + ", " + swipeY);

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
                screen.parent.parent.x = gridX + swipeX;
            else if (dragDirection == 2)
                screen.parent.parent.y = gridY + swipeY;

            if (Math.abs(swipeX) < 50 && swipeY > 100)
            {
                // swipe up
                //console.log("SWIPE UP DETECTED");
                screen.parent.parent.switched(1);
                success = true;
                dragDirection = 0;
            }
            else
            if (Math.abs(swipeX) < 50 && swipeY < -100)
            {
                // swipe down
                //console.log("SWIPE DOWN DETECTED");
                screen.parent.parent.switched(2);
                success = true;
                dragDirection = 0;
            }
            else
            if (swipeX < -100 && Math.abs(swipeY) < 50)
            {
                // swipe right
                //console.log("SWIPE RIGHT DETECTED");
                screen.parent.parent.switched(3);
                success = true;
                dragDirection = 0;
            }
            else
            if (swipeX > 100 && Math.abs(swipeY) < 50)
            {
                // swipe left
                //console.log("SWIPE LEFT DETECTED");
                screen.parent.parent.switched(4);
                success = true;
                dragDirection = 0;
            }
        }
        onReleased: {
            console.log("(DD) Mouse released");
            dragDirection = 0;
            if (success == false)
            {
                console.log(">> Restoring coordinates");
                screen.parent.parent.x = gridX;
                screen.parent.parent.y = gridY;
            }
        }
    }
}
