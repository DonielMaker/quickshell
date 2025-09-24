import Quickshell
import Quickshell.Hyprland
import QtQuick
import qs.Appearance

Rectangle {
    implicitHeight: 40
    implicitWidth: (4 + 8) * 10 + 10 // (Spacing + Width) * Amount + Margins
    color: 'transparent'

    Row {
        anchors.fill: parent
        spacing: -3

        Repeater {
            model: 10

            MouseArea {
                anchors.verticalCenter: parent.verticalCenter
                id: workspace
                implicitWidth: 16
                implicitHeight: 16
                hoverEnabled: true

                property real dotSize: 8
                property bool activeWs: Hyprland.focusedWorkspace?.id == modelData + 1 

                onEntered: dotSize = 16

                onExited: dotSize = 8

                onClicked: Hyprland.dispatch("workspace " + (modelData + 1))

                Rectangle {
                    anchors.centerIn: parent
                    width: dotSize
                    height: dotSize
                    radius: height / 2
                    opacity: activeWs ? 1 : 0.2
                    // color: activeWs ? Theme.fg : Theme.bg_highlight
                    color: Theme.fg

                    Behavior on width {
                        NumberAnimation { duration: 100 }
                    }
                    Behavior on height {
                        NumberAnimation { duration: 100 }
                    }
                }
            }
        }
    }
}
