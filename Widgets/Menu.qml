import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import qs.Appearance
import qs.Services

Scope {
    property var menuItems: AppSearch.applications

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
                    spacing: 5

                    header: TextField {
                        id: txtfld
                        height: 60
                        font.pointSize: 16
                        width: lv.width
                        background: Rectangle { color: 'transparent' }
                        placeholderText: activeFocus ? "Search..." : "No Focus"
                        placeholderTextColor: Theme.fg
                        color: Theme.fg
                        focus: True
                        Component.onCompleted: forceActiveFocus()
                        onTextEdited: {
                            menuItems = AppSearch.search(txtfld.text)
                        }
                    }

                    Keys.onPressed: (event) => {
                        if (event.key == Qt.Key_Return) {
                            menuItems[lv.currentIndex].execute()
                            root.active = false
                            event.accepted = true
                        }
                        if (event.key == Qt.Key_Escape) {
                            root.active = false
                            event.accepted = true
                        }
                        if (event.key == Qt.Key_Up) {
                            if (currentIndex > 0) {
                                lv.currentIndex--
                            }
                            event.accepted = true
                        }
                        if (event.key == Qt.Key_Down) {
                            if (currentIndex < lv.count - 1) {
                                lv.currentIndex++
                            }
                            event.accepted = true
                        }
                    }

                    keyNavigationEnabled: false

                    highlightMoveDuration: 0
                    highlightResizeDuration: 0
                    highlightFollowsCurrentItem: true
                    highlight: Rectangle {
                        radius: 10
                        color: Theme.blue
                    }

                    model: menuItems

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
                    }
                }
            }
        }
    }
}
