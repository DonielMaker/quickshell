import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import qs.Appearance

Scope {
    LazyLoader {
        id: root
        active: true

        PanelWindow {
            implicitHeight: 600
            implicitWidth: 500
            focusable: true
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
                    anchors.fill: parent
                    spacing: 10

                    header: TextField {
                        id: txtfld
                        height: 60
                        width: lv.width
                        background: Rectangle { color: 'transparent' }
                        placeholderText: "Search..."
                        placeholderTextColor: Theme.fg
                        color: Theme.fg
                        Keys.forwardTo: [txtfld]
                        focus: true
                        Component.onCompleted: forceActiveFocus()
                    }

                    Keys.onPressed: (event) => {
                        if (event.key == Qt.Key_Return) {
                            model.values[currentIndex].execute()
                            root.active = false
                            event.accepted = true
                        }
                        if (event.key == Qt.Key_Escape) {
                            root.active = false
                            event.accepted = true
                        }
                    }

                    keyNavigationEnabled: true

                    highlightMoveDuration: 0
                    highlightResizeDuration: 0
                    highlightFollowsCurrentItem: true
                    highlight: Rectangle {
                        radius: 10
                        color: Theme.blue
                    }

                    model: ScriptModel {
                        values: DesktopEntries.applications.values.filter(entry => !entry.noDisplay | !entry.runInTerminal)
                    } 

                    delegate: Column {
                        width: lv.width
                        padding: 10

                        HoverHandler {
                            id: hvr
                        }

                        TapHandler {
                            id: tap
                            onTapped: {
                                modelData.execute()
                                root.active = false
                            }
                        }

                        Row {
                            spacing: 5

                            IconImage {
                                implicitSize: 30
                                source: Quickshell.iconPath(modelData.icon, modelData.name.toLowerCase())
                                // if (modelData.icon == undefined) {
                                //     Quickshell.iconPath(modelData.name.toLowerCase(), "application-all-symbolic") 
                                // } else {
                                //     Quickshell.iconPath(modelData.icon, "application-all-symbolic")
                                // }

                            }

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: modelData.name
                                color: Theme.fg
                                font.pointSize: 16
                            }
                        }

                        Text {
                            text: modelData.comment ? modelData.comment : modelData.genericName
                            color: Theme.fg
                        }

                        Rectangle {
                            height: 3
                            width: lv.width - 20
                            color: Theme.bg_highlight
                        }
                    }
                }
            }
        }
    }
}
