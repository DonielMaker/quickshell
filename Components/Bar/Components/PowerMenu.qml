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
        textColor: Theme.red
        onClicked: shutdown.running = true
    }

    PowerButton {
        content: " "
        textColor: Theme.yellow
        onClicked: reboot.running = true
    }

    component PowerButton: Rectangle {
        id: root

        property string content
        property color textColor 
        signal clicked()

        implicitHeight: 35
        implicitWidth: height

        color: hoverHandler.hovered ? Theme.bg_highlight : "#002f334c"
        radius: height / 2

        Text {
            text: content
            color: root.textColor
            anchors.centerIn: parent
            font.pointSize: 12
        }

        TapHandler {
            onTapped: root.clicked()
        }

        HoverHandler {
            id: hoverHandler
        }

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
}
