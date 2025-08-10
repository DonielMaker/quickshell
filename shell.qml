//@ pragma UseQApplication
// @ pragma IconTheme Papirus
import Quickshell
import QtQuick
import "Components/Bar"
import "Components/Osd"
import "Components/Mixer"

ShellRoot {
    id: root
    signal toggleMixer
    property bool mixerEnabled: false

    onToggleMixer: mixerEnabled = !mixerEnabled

    Bar {onToggleMixer: root.toggleMixer()}
    Osd {}
    Mixer {mixerEnabled: root.mixerEnabled}
}
