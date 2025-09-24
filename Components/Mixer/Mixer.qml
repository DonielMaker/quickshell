import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import qs.Appearance
import qs.Widgets
import qs.Cache

Scope {
    id: root
    property QsWindow window

    PwObjectTracker {
        objects: Pipewire.nodes.values
    }

    LazyLoader {
        active: Cache.mixerEnabled

        PanelWindow {
            visible: true

            anchors {
                top: true
                bottom: true
                right: true
                left: true
            }

            color: 'transparent'

            Rectangle {
                x: 1920 - (1920 * 0.05) - width
                y: 20
                color: Theme.bg
                border.color: Theme.bg_highlight
                border.width: 2
                radius: 15
                implicitWidth: 600
                implicitHeight: 400

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onExited: Cache.mixerEnabled = !Cache.mixerEnabled

                    ScrollView {
                        id: shell
                        anchors.margins: 10
                        anchors.fill: parent
                        Column {
                            spacing: 5

                            Repeater {
                                model: ScriptModel {
                                    values: Pipewire.nodes.values.filter(node => node.isStream && node.isSink)
                                }

                                // This is an individual Item
                                Item {
                                    implicitHeight: 40 + description.height
                                    implicitWidth: shell.width

                                    Column {
                                        anchors.fill: parent
                                        spacing: 5

                                        Row {
                                            width: parent.width
                                            padding: 5
                                            spacing: 5

                                            IconImage {
                                                id: icon

                                                implicitSize: 20
                                                anchors.verticalCenter: parent.verticalCenter
                                                source: {
                                                    if (modelData.properties["application.icon-name"] == undefined) {
                                                        Quickshell.iconPath(modelData.name.toLowerCase(), "audio-volume-high") 
                                                    } else {
                                                        Quickshell.iconPath(modelData.properties["application.icon-name"], "audio-volume-high")
                                                    }
                                                }
                                            }

                                            StyledText {
                                                id: name

                                                anchors.verticalCenter: parent.verticalCenter
                                                text: modelData.name
                                            }

                                            StyledText {
                                                id: volume

                                                anchors.verticalCenter: parent.verticalCenter
                                                text: Math.floor(modelData.audio.volume * 100)
                                                width: this.font.pointSize * 3
                                            }

                                            Slider {
                                                anchors.verticalCenter: parent.verticalCenter
                                                width: (parent.width - x) * 0.95
                                                value: modelData.audio.volume

                                                onMoved: {
                                                    modelData.audio.volume = value
                                                }
                                            }
                                        }

                                        StyledText {
                                            id: description
                                            width: shell.width
                                            text: modelData.properties["media.name"]
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
    }
}
