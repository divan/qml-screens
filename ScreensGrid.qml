// vim: et ts=4 sw=4:
import QtQuick 1.0

Column {
    id: grid
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

    function switchScreen(direction) {
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
        //console.log("Switch -> " + row + " / " + col + " = " + screenNum);
        if (row == 0 || col == 0 || row > rowsCount || col > colsCount)
            return;
        //console.log(currentScreen);
        var currentScreenObj = grid.children[getCurrentRow()-1].children[getCurrentCol()-1];
        var newScreenObj = grid.children[row-1].children[col-1];
        switchToScreen(screenNum);
        currentScreenObj.hide(direction);
        newScreenObj.show(direction);
    }

    function switchToNext() {
        var nextScreen = currentScreen + 1;
        if (nextScreen > 6) nextScreen = 1;
        //console.log("Switch to next screen: " + nextScreen);
        switchToScreen(nextScreen);
    }

    function switchToScreen(screen) {
        currentScreen = screen;
        for (var i = 0; i < grid.children.length; ++i)
        {
            var row = grid.children[i];

            for (var j = 0; j < row.children.length; ++j)
            {
                var screenObj = row.children[j];
                var screenNum = i * colsCount + j + 1;

                if (screenNum != screen)
                {
                    //console.log(" " + screenNum + " != " + screen + " - Hiding Screen");
                    screenObj.state = "HIDDEN";
                }
                else
                {
                    //console.log(" " + screenNum + " == " + screen + " - Showing Screen");
                    screenObj.state = "SHOWN";
                }
            }
            // check whether row should be hidden
            //console.log(screen + " >= " + (i*colsCount+1) + " && " + screen + " <= " + (i+1)*colsCount)
            if ((screen >= (i*colsCount+1)) && (screen <= (i+1)*colsCount))
            {
                //console.log("Showing row");
                row.state = "SHOWN";
            }
            else
            {
                //console.log("Hiding row");
                row.state = "HIDDEN";
            }
        }
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

    Component.onCompleted: {
        rowsCount = grid.children.length;
        colsCount = grid.children[0].children.length;
        totalScreens = rowsCount * colsCount;
    }
}
