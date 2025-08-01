import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Services.UPower
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "Components"
import "root:/Appearance"
import "root:/Widgets"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar

            property var modelData
            screen: modelData

            WlrLayershell.layer: WlrLayer.Top

            margins.top: 10
            anchors.top: true
            color: "transparent"

            implicitHeight: 45
            implicitWidth: screen.width * 0.9

            Rectangle {
                anchors.fill: parent
                radius: 15
                color: Theme.bg
                border.color: Theme.bg_highlight
                border.width: 2

                // Left side
                Row {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 10
                    spacing: 15

                    PowerMenu {}

                    Workspaces {}
                }

                // Center (Only for Clock)
                StyledText {
                    id: clock
                    text: Time.time
                    anchors.centerIn: parent
                }

                // Right side
                Row {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 15

                    Battery {}

                    Pipewire {}

                }
            }
        }
    }
}
