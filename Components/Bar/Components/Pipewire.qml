import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "root:/Appearance"
import "root:/Widgets"


Row {
    id: root

    anchors.verticalCenter: parent.verticalCenter

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
    PipewireButton {
        content: `${evenSinkVolume}%  ` 
        color: Theme.blue5
    }

    StyledText {
        text: " | "
        anchors.verticalCenter: parent.verticalCenter
    }

    PipewireButton {
        content: `${evenSrcVolume}% `
        color: srcMuted? Theme.red1 : Theme.blue 
    }

    // Definiton
    component PipewireButton: MouseArea {
        id: root

        property string content
        property color color

        hoverEnabled: true
        implicitHeight: 30
        implicitWidth: 60
        anchors.verticalCenter: parent.verticalCenter

        onClicked: pavu.running = !pavu.running

        // Make Audio Louder/Quieter by scrolling on the Widget
        onWheel: (wheel) => {
            if (wheel.angleDelta.y > 0) {
                Pipewire.defaultAudioSource.audio.volume += 0.01
            } else {
                Pipewire.defaultAudioSource.audio.volume -= 0.01
            }
        }

        Rectangle {
            anchors.fill: parent
            color: parent.containsMouse ? Theme.bg_highlight : "#002f334c"
            radius: height / 2.5

            StyledText {
                text: content
                color: root.color
                anchors.centerIn: parent
            }

            Behavior on color {
                ColorAnimation { duration: 200 }
            }
        }
    }
}
