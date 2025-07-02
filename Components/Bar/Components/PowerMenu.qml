import QtQuick
import QtQuick.Controls
import Quickshell.Io
import "root:Appearance"

Row {

    Process {
        id: shutdown
        command: ["shutdown", "now"]
    }

    Process {
        id: reboot 
        command: ["reboot"]
    }

    Button {
        background: Rectangle { color: "transparent"}
        contentItem: Text {
            text: " "
            color: Theme.red
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
        }
        implicitHeight: 40
        implicitWidth: height
        onClicked: shutdown.running = true
    }

    Button {
        background: Rectangle { color: "transparent"}
        contentItem: Text {
            text: " "
            color: Theme.yellow
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
        }
        implicitHeight: 40
        implicitWidth: height
        onClicked: reboot.running = true
    }

}
