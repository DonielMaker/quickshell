import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "root:/Appearance"

RowLayout {
    Process {
        id: pavu
        command: ["pavucontrol"]
    }

    // Bind the Pipewire service to receive content
    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    property bool muted: Pipewire.defaultAudioSource?.audio.muted

    // The Widget
    Button {
        id: sink
        background: Rectangle { color: "transparent"}
        contentItem: Text {
            text: `${Math.floor(Pipewire.defaultAudioSink?.audio.volume * 100)}%  `
            color: Theme.blue5
            font.pointSize: 10.5
        }
        onClicked: pavu.running ? pavu.running = false : pavu.running = true
    }

    Text {
        text: " | "
        color: "#c0caf5"
        font.pointSize: 10.5
    }

    Button {
        background: Rectangle { color: "transparent"}
        contentItem: Text {
            text: `${Math.floor(Pipewire.defaultAudioSource?.audio.volume * 100)}% `
            color: muted? Theme.red1 : Theme.blue 
            font.pointSize: 10.5
        }
        onClicked: pavu.running ? pavu.running = false : pavu.running = true    
    }
}
