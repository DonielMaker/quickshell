import Quickshell
import Quickshell.Hyprland
import QtQuick

Rectangle {
    implicitHeight: 40
    implicitWidth: (4 + 8) * 10
    color: "transparent"

    Row {
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        Repeater {
            model: 10

            Rectangle {
                property bool activeWs: Hyprland.focusedWorkspace?.id === modelData + 1 

                implicitHeight: 8
                implicitWidth: height
                radius: height / 2
                color: activeWs ? "#c0caf5" : "#2f334c"
            }
            // Canvas {
            //     property HyprlandWorkspace ws: modelData
            //     property bool currWs: Hyprland.focusedWorkspace?.id === ws.id
            //     id: workspaceBall
            //     width: 7
            //     height: 7
            //     onPaint: {
            //         var ctx = getContext("2d");
            //         ctx.clearRect(0, 0, width, height);
            //         ctx.beginPath();
            //         ctx.arc(width / 2, height / 2, width / 2, 0, 2 * Math.PI);
            //         ctx.fillStyle = currWs ? "#2f334c" : "#c0caf5";// or any color
            //         ctx.fill();
            //     }
            // }
        }
    }
}
