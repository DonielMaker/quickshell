import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Services.Pipewire

Scope {
    id: root

    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    PanelWindow {    }
}
