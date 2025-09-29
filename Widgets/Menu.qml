import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import qs.Appearance

Scope {
    PanelWindow {
        implicitHeight: 600
        implicitWidth: 500
        focusable: true
        visible: false
        color: 'transparent'

        Rectangle {
            id: rct
            color: Theme.bg
            anchors.fill: parent
            border.width: 2
            border.color: Theme.bg_highlight
            radius: 15


            ListView {
                id: lv
                implicitHeight: 40 * DesktopEntries.applications.values.filter(entry => !entry.noDisplay | !entry.runInTerminal).length + 120
                // implicitHeight: 2000
                implicitWidth: parent.width
                focus: true
                spacing: 20

                header: TextField {
                    height: 40
                    width: parent.width
                    background: Rectangle { color: 'transparent' }
                    placeholderText: "Search..."
                    placeholderTextColor: Theme.fg
                }

                keyNavigationEnabled: true

                highlightMoveDuration: 0
                highlightResizeDuration: 0
                highlightFollowsCurrentItem: true
                preferredHighlightBegin: (lv.height / 2) - 40
                preferredHighlightEnd:  (lv.height / 2) + 40
                highlight: Rectangle {
                    radius: 10
                    color: Theme.blue
                }

                model: ScriptModel {
                    values: DesktopEntries.applications.values.filter(entry => !entry.noDisplay | !entry.runInTerminal)
                } 

                delegate: Column {
                    padding: 5

                    HoverHandler {
                        id: hvr
                    }

                    Row {
                        spacing: 5

                        IconImage {
                            implicitSize: 30
                            source: Quickshell.iconPath(modelData.icon)
                        }

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: modelData.name
                            color: Theme.fg
                            font.pointSize: 16
                        }
                    }

                    Text {
                        text: modelData.comment? modelData.comment : modelData.genericName
                        color: Theme.fg
                    }

                    Rectangle {
                        implicitWidth: shell.width
                        implicitHeight: 10
                    }
                }
            }
        }
    }
}
