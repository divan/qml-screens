// vim: et ts=4 sw=4:
import QtQuick 1.0

Column {
    id: grid
    anchors.fill: parent
    property int currentScreen: 1
    property int rowsCount: 0
    property int colsCount: 0
    property int totalScreens: 0
    focus: true;
    Keys.onPressed: {
        if (event.key == Qt.Key_Up)
        {
            switchScreen(1);
        }
        else if (event.key == Qt.Key_Down)
        {
            switchScreen(2);
        }
        else if (event.key == Qt.Key_Right)
        {
            switchScreen(3);
        }
        else if (event.key == Qt.Key_Left)
        {
            switchScreen(4);
        }
    }

    signal switched (int direction)
    onSwitched: {
        switchScreen(direction);
    }
    /*
    MouseArea {
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
    */

    function switchScreen(direction) {
        console.log("Switching...");
        switch(direction) {
        case 1:
            var row = getCurrentRow() - 1;
            var col = getCurrentCol();
            break;
        case 2:
            var row = getCurrentRow() + 1;
            var col = getCurrentCol();
            break;
        case 3:
            var row = getCurrentRow();
            var col = getCurrentCol() + 1;
            break;
        case 4:
            var row = getCurrentRow();
            var col = getCurrentCol() - 1;
            break;
        default:
        }
        var screenNum = (row-1)*colsCount + col;
        console.log("Switch -> " + row + "/" + col + " = " + currentScreen + "->" + screenNum);
        if (row == 0 || col == 0 || row > rowsCount || col > colsCount)
            return;
        switchToScreen(screenNum);
    }

    function switchToNext() {
        var nextScreen = currentScreen + 1;
        if (nextScreen > 6) nextScreen = 1;
        //console.log("Switch to next screen: " + nextScreen);
        switchToScreen(nextScreen);
    }

    function switchToScreen(screen) {
        currentScreen = screen;
        var newX = -((screen - 1) % colsCount) * grid.width;
        var newY = -(Math.floor((currentScreen-1) / colsCount)) * grid.height;
        //console.log("newXY-> " + newX + ", " + newY);
        grid.x = newX;
        grid.y = newY;
    }

    // Return row of currentScreen
    function getCurrentRow() {
        //console.log("DDD ROW: " + (Math.floor((currentScreen-1) / rowsCount) + 1));
        return Math.floor((currentScreen-1) / colsCount) + 1;
    }

    // Return col of currentScreen
    function getCurrentCol() {
        //console.log("DDD COL: " + ((currentScreen - 1) % colsCount + 1));
        return (currentScreen - 1) % colsCount + 1;
    }

    Behavior on y {
        NumberAnimation { duration: 300; easing.type: Easing.OutBack }
    }
    Behavior on x {
        NumberAnimation { duration: 300; easing.type: Easing.OutBack }
    }

    Component.onCompleted: {
        rowsCount = grid.children.length;
        colsCount = grid.children[0].children.length;
        totalScreens = rowsCount * colsCount;
        console.log("INIT: rows: " + rowsCount + ", cols: " + colsCount + ", total: " + totalScreens);
    }
}
