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

    PowerButton {
        content: " "
        color: Theme.red
    }

    PowerButton {
        content: " "
        color: Theme.yellow
    }

    component PowerButton: MouseArea {
        id: root

        property string content
        property color color 

        implicitHeight: 40
        implicitWidth: height

        onClicked: reboot.running = true

        hoverEnabled: true

        Rectangle {
            anchors.fill: parent
            color: parent.containsMouse ? Theme.bg_highlight : "#002f334c"
            radius: height / 2

            Text {
                text: content
                color: root.color
                anchors.centerIn: parent
                font.pointSize: 12
            }

            Behavior on color {
                ColorAnimation { duration: 200 }
            }
        }
    }
}
