import Quickshell
import Quickshell.Hyprland
import QtQuick
import "root:/Appearance"

Rectangle {
    implicitHeight: 40
    implicitWidth: (4 + 8) * 10 // (Spacing + Width) * Amount
    color: "transparent"

    Row {
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        Repeater {
            model: 10

            Rectangle {
                property bool activeWs: Hyprland.focusedWorkspace?.id == modelData + 1 

                implicitHeight: 8
                implicitWidth: 8 
                radius: height / 2
                color: activeWs ? Theme.fg : Theme.bg_highlight
            }
        }
    }
}
