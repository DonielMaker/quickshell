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

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar

            property var modelData
            screen: modelData

            WlrLayershell.layer: WlrLayer.Top
            exclusiveZone: 40

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
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 15

                    PowerMenu {}

                    Workspaces {}
                }

                // Center (Only for Clock)
                Text {
                    anchors.centerIn: parent
                    anchors.verticalCenter: parent.verticalCenter
                    id: clock
                    font.pointSize: 10.5
                    color: Theme.fg
                    text: Time.time
                }

                // Right side
                Row {
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    anchors.verticalCenter: parent.verticalCenter

                    Battery {}

                    Text {
                        visible: UPower.displayDevice.isLaptopBattery
                        text: " | "
                        color: Theme.fg
                        font.pointSize: 10.5
                    }

                    Pipewire {}
                }
            }
        }
    }
}
