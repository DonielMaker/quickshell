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

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10

                    // Left side
                    Row {
                        spacing: 15

                        PowerMenu {}

                        Workspaces {}
                    }

                    Item { Layout.fillWidth: true } // Spacer

                    // Center (Only for Clock)
                    Text {
                        id: clock
                        font.pointSize: 10.5
                        color: "#c0caf5"
                        text: Time.time
                    }

                    Item { Layout.fillWidth: true } // Spacer

                    // Right side
                    Row {
                        Pipewire {}
                    }
                }
            }
        }
    }
}
