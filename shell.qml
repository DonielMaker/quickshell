import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls

Scope {
    id: root

    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData
            screen: modelData

            anchors.top: true
            color: "transparent"

            implicitHeight: 45
            implicitWidth: screen.width * 0.9

            Process {
                id: shutdown
                command: ["shutdown", "now"]
            }

            Process {
                id: reboot 
                command: ["reboot", "now"]
            }

            Rectangle {
                anchors.fill: parent
                radius: 15
                color: "#24283b"
                border.color: "#2F334C"
                border.width: 2

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 10

                    Button {
                        anchors.verticalCenter: parent.verticalCenter
                        background: Rectangle { color: "transparent"}
                        icon.name: "system-shutdown-panel"
                        icon.color: Theme.red
                        icon.height: 40
                        icon.width: 40
                        implicitHeight: 32
                        implicitWidth: height
                        onClicked: shutdown.running = true
                    }

                    Button {
                        background: Rectangle { color: "transparent"}
                        anchors.verticalCenter: parent.verticalCenter
                        icon.name: "system-reboot"
                        icon.color: Theme.yellow
                        icon.height: 40
                        icon.width: 40
                        implicitHeight: 30
                        implicitWidth: height
                        onClicked: reboot.running = true
                    }

                    Workspaces {}
                }

                Text {
                    id: clock
                    anchors.centerIn: parent
                    font.pointSize: 10.5
                    color: "#c0caf5"
                    text: Time.time
                }

                Rectangle {
                    implicitHeight: 45
                    implicitWidth: 150
                    color: "transparent"
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }

                    Row {
                        anchors.verticalCenter: parent.verticalCenter
                        Text {
                            text: `${Math.floor(Pipewire.defaultAudioSink?.audio.volume * 100)}%  `
                            anchors.verticalCenter: parent.verticalCenter
                            color: Theme.blue5
                            font.pointSize: 10.5
                        }

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "  |  "
                            color: "#c0caf5"
                            font.pointSize: 10.5
                        }

                        Text {
                            property bool muted: Pipewire.defaultAudioSource?.audio.muted
                            text: `${Math.floor(Pipewire.defaultAudioSource?.audio.volume * 100)}% `
                            anchors.verticalCenter: parent.verticalCenter
                            color: muted? Theme.red1 : Theme.blue 
                            font.pointSize: 10.5
                        }
                    }
                }
            }
        }
    }


}
