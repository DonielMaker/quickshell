import QtQuick
import QtQuick.Controls
import Quickshell.Io
import "root:Appearance"

Row {
    Process {
        id: reboot 
        command: ["reboot"]
    }

    Process {
        id: shutdown
        command: ["shutdown", "now"]
    }

    MouseArea {
        implicitHeight: 40
        implicitWidth: height

        onClicked: shutdown.running = true

        hoverEnabled: true

        Rectangle {
            anchors.fill: parent
            color: parent.containsMouse ? Theme.bg_highlight : "#002f334c"
            radius: height / 2

            Text {
                text: " "
                color: Theme.red
                anchors.centerIn: parent
                font.pointSize: 12
            }

            Behavior on color {
                ColorAnimation { duration: 200 }
            }
        }
    }

    MouseArea {
        implicitHeight: 40
        implicitWidth: height

        onClicked: reboot.running = true

        hoverEnabled: true

        Rectangle {
            anchors.fill: parent
            color: parent.containsMouse ? Theme.bg_highlight : "#002f334c"
            radius: height / 2

            Text {
                text: " "
                color: Theme.yellow
                anchors.centerIn: parent
                font.pointSize: 12
            }

            Behavior on color {
                ColorAnimation { duration: 200 }
            }
        }
    }
}
