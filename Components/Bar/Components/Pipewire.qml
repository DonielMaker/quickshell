import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.Appearance
import qs.Widgets
import qs.State


Row {
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
        textColor: Theme.blue5
        device: Pipewire.defaultAudioSink.audio
    }

    FancyText {
        text: " | "
        anchors.verticalCenter: parent.verticalCenter
    }

    PipewireButton {
        content: `${evenSrcVolume}% `
        textColor: srcMuted? Theme.red1 : Theme.blue 
        device: Pipewire.defaultAudioSource.audio
    }

    // Definiton
    component PipewireButton: Rectangle {
        id: root

        property string content
        property color textColor
        property PwNodeAudio device

        color: hoverHandler.hovered ? Theme.bg_highlight : "#002f334c"
        radius: height / 2.5

        implicitHeight: 30
        implicitWidth: 70
        anchors.verticalCenter: parent.verticalCenter

        FancyText {
            text: content
            color: root.textColor
            anchors.centerIn: parent
        }

        HoverHandler {
            id: hoverHandler
        }

        TapHandler {
            id: tapHandler
            onTapped: SystemState.showMixer = !SystemState.showMixer
        }

        WheelHandler {
            acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
            // Make Audio Louder/Quieter by scrolling on the Widget
            onWheel: (wheel) => {
                console.log("wheel")
                if (wheel.angleDelta.y > 0) {
                    root.device.volume += 0.01
                } else {
                    root.device.volume -= 0.01
                }
            }
        }

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
}
