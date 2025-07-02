import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "Components"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
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
                color: "#24283b"
                border.color: "#2F334C"
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
                    color: "#c0caf5"
                    text: Time.time
                }

                // Right side
                RowLayout {
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    anchors.verticalCenter: parent.verticalCenter

                    Battery {}

                    Text {
                        text: " | "
                        color: "#c0caf5"
                        font.pointSize: 10.5
                    }

                    Pipewire {}
                }
            }
        }
    }
}
