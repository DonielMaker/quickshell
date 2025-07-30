import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "root:/Appearance"

Row {
    spacing: 10

    Process {
        id: pavu
        command: ["pavucontrol"]
    }

    // Bind the Pipewire service to receive content
    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    property int evenSinkVolume: Math.floor(Pipewire.defaultAudioSink?.audio.volume * 100)
    property bool srcMuted: Pipewire.defaultAudioSource?.audio.muted

    property int evenSrcVolume: Math.floor(Pipewire.defaultAudioSource?.audio.volume * 100)

    // The Widget
    MouseArea {
        implicitHeight: 40
        implicitWidth: 40 * 1.5

        hoverEnabled: true

        Rectangle {
            anchors.fill: parent
            color: parent.containsMouse ? Theme.bg_highlight : "#002f334c"
            radius: height / 2.5

            Text {
                text: `${evenSinkVolume}%  `
                color: Theme.blue5
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 10.5
            }

            Behavior on color {
                ColorAnimation { duration: 200 }
            }
        }
        onClicked: pavu.running = !pavu.running
        onWheel: (wheel) => {
            if (wheel.angleDelta.y > 0) {
                Pipewire.defaultAudioSink.audio.volume += 0.01
            } else {
                Pipewire.defaultAudioSink.audio.volume -= 0.01
            }
        }
    }

    Text {
        text: " | "
        color: Theme.fg
        font.pointSize: 10.5
        anchors.verticalCenter: parent.verticalCenter
    }

    MouseArea {
        implicitHeight: 40
        implicitWidth: 40 * 1.5

        hoverEnabled: true

        Rectangle {
            anchors.fill: parent
            color: parent.containsMouse ? Theme.bg_highlight : "#002f334c"
            radius: height / 2.5

            Text {
                text: `${evenSrcVolume}% `
                color: srcMuted? Theme.red1 : Theme.blue 
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 10.5
            }

            Behavior on color {
                ColorAnimation { duration: 200 }
            }
        }
        onClicked: pavu.running = !pavu.running
        onWheel: (wheel) => {
            if (wheel.angleDelta.y > 0) {
                Pipewire.defaultAudioSource.audio.volume += 0.01
            } else {
                Pipewire.defaultAudioSource.audio.volume -= 0.01
            }
        }
    }

}
