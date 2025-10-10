import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import qs.Appearance
import qs.Widgets
import qs.Services

Scope {
    id: root

    property var applications: DesktopEntries.applications.values.filter(entry => !entry.noDisplay && !entry.runInTerminal)

    PanelWindow {
        id: window
        focusable: true
        visible: false
        WlrLayershell.keyboardFocus: visible ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None


        implicitHeight: 600
        implicitWidth: 500

        color: 'transparent'

        Rectangle {
            anchors.fill: parent
            color: Theme.bg
            border.width: 2
            border.color: Theme.bg_highlight
            radius: 15

            Column {
                id: shell
                anchors.fill: parent

                    TextField {
                        implicitHeight: 40
                        implicitWidth: shell.width
                        placeholderText: "Search..."
                        background: Rectangle {
                            radius: 5
                            color: Theme.bg
                            border.width: 2
                            border.color: parent.hovered ? Theme.blue : Theme.bg_highlight
                        }
                        onTextEdited: {
                            root.applications = AppLaunchService.search(text)
                        }

                        // Component.onCompleted: forceActiveFocus()

                    }
                ListView {
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Return) {
                            root.applications[AppLaunchService.index].execute()
                            window.visible = false
                            event.accepted = true
                        }
                        if (event.key === Qt.Key_Escape) {
                            window.visible = false
                            event.accepted = true
                        }
                    }
                    anchors.margins: 10
                    height: shell.height - 40
                    width: shell.width
                    highlight: Rectangle {
                        width: shell.width
                        height: 40
                        color: Theme.blue
                    }
                    model: root.applications
                    highlightFollowsCurrentItem: true
                    Component.onCompleted: forceActiveFocus()

                    delegate: MouseArea {
                        implicitHeight: 60
                        implicitWidth: shell.width
                        hoverEnabled: true
                        onClicked: (event) => {
                            if (event.button == Qt.LeftButton) {
                                modelData.execute()
                                window.visible = false
                            }
                        }

                        Rectangle {
                            id: item
                            anchors.fill: parent
                            radius: 10
                            color: 'transparent'


                            Column {
                                anchors.margins: 5
                                anchors.fill: parent
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: 3

                                Row {
                                    spacing: 10
                                    IconImage {
                                        id: icon

                                        implicitSize: 30
                                        anchors.verticalCenter: parent.verticalCenter
                                        source: Quickshell.iconPath(modelData.icon)
                                    }


                                    StyledText {
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.pointSize: 14
                                        text: modelData.name
                                    }

                                }

                                StyledText {
                                    text: modelData.comment
                                }
                            }

                            Rectangle {
                                height: 2
                                width: shell.width
                                color: Theme.bg_highlight
                                anchors.bottom: parent.bottom
                            }
                        }
                    }
                }
            }
        }
    }
}
