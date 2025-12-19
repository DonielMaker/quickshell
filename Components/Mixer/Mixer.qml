import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import qs.Appearance
import qs.Widgets
import qs.State

Scope {
    id: root
    property ShellScreen screen: QsWindow.window?.screen

    PwObjectTracker {
        objects: Pipewire.nodes.values
    }

    LazyLoader {
        active: SystemState.showMixer

        PanelWindow {
            anchors {
                top: true
                bottom: true
                right: true
                left: true
            }
                
            color: 'transparent'

            Rectangle {
                x: screen.width - (screen.width * 0.05) - width
                y: 20
                color: Theme.bg
                border.color: Theme.bg_highlight
                border.width: 2
                radius: 15
                implicitWidth: 500
                implicitHeight: Math.min(content.height + 20, 330)

                HoverHandler {
                    onHoveredChanged: if (!hovered) SystemState.showMixer = !SystemState.showMixer
                }

                ScrollView {
                    id: shell
                    anchors.margins: 10
                    anchors.fill: parent

                    Column {
                        id: content
                        spacing: 5

                        MixerItem {
                            itemContent: Pipewire.defaultAudioSource
                            iconSource: Quickshell.iconPath("mic-ready")
                        }

                        MixerItem {
                            itemContent: Pipewire.defaultAudioSink
                        }

                        Repeater {
                            model: ScriptModel {
                                values: Pipewire.nodes.values.filter(node => node.isStream && node.isSink)
                            }

                            MixerItem {}
                        }

                        component MixerItem: Item {
                                property var itemContent: modelData
                                property string iconSource: ""
                                implicitHeight: 40 + description.height
                                implicitWidth: shell.width

                                Column {
                                    anchors.fill: parent
                                    spacing: 5

                                    Row {
                                        width: shell.width
                                        padding: 5
                                        spacing: 5

                                        IconImage {
                                            id: icon

                                            implicitSize: 20
                                            anchors.verticalCenter: parent.verticalCenter
                                            source: iconSource !== "" 
                                                ? iconSource
                                                : Quickshell.iconPath(itemContent.properties["application.icon-name"], "audio-volume-high")
                                        }

                                        FancyText {
                                            id: name

                                            anchors.verticalCenter: parent.verticalCenter
                                            text: (itemContent.name.length >= 40) ? itemContent.nickname : itemContent.name
                                        }

                                        FancyText {
                                            id: volume

                                            anchors.verticalCenter: parent.verticalCenter
                                            text: Math.floor(itemContent.audio.volume * 100)
                                            width: this.font.pointSize * 3
                                        }

                                        Slider {
                                            anchors.verticalCenter: parent.verticalCenter
                                            width: (parent.width - x) * 0.95
                                            value: itemContent.audio.volume

                                            onMoved: {
                                                itemContent.audio.volume = value
                                            }
                                        }
                                    }

                                    FancyText {
                                        id: description
                                        width: shell.width
                                        text: itemContent.properties["media.name"]
                                        elide: Text.ElideLeft
                                        wrapMode: Text.WordWrap
                                    }
                                }

                                Rectangle {
                                    anchors.top: parent.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    implicitHeight: 1
                                    implicitWidth: shell.width
                                    opacity: 0.3
                                    color: Theme.fg
                                }
                            }
                    }
                }
            }
        }
    }
}
