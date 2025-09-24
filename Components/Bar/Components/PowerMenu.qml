import QtQuick
import QtQuick.Controls
import Quickshell.Io
import qs.Appearance


Row {
    anchors.verticalCenter: parent.verticalCenter
    spacing: 5

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
        onClicked: shutdown.running = true
    }

    PowerButton {
        content: " "
        color: Theme.yellow
        onClicked: reboot.running = true
    }

    component PowerButton: MouseArea {
        id: root

        property string content
        property color color 

        implicitHeight: 35
        implicitWidth: height

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
