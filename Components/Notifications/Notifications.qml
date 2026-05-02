import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.Appearance
import qs.Widgets
import qs.State

Scope {
    id: root
    property ShellScreen screen: QsWindow.window?.screen
    property bool showNotifs: true

    LazyLoader {
        active: showNotifs

        PanelWindow {
            anchors {
                top: true
                bottom: true
                right: true
                left: true
            }

            color: 'transparent'

            // What do we need to achieve?
            // we would need a column (vertical) going up the full left side.
            // Then we need a Repeater with an array of current notifs running to create all
            // the Rectangles later on
            ListView {
                implicitWidth: 500
                layoutDirection: Qt.RightToLeft
                spacing: 5
                x: screen.width - 500
                y: screen.height - 800

                model: 3

                delegate: NotificationItem {}
            }


            // What does this Require
            component NotificationItem: Rectangle {
                property var notificationContent: modelData

                color: Theme.bg

                border.color: Theme.bg_highlight
                border.width: 2
                radius: 15

                implicitWidth: 500
                implicitHeight: 100
                // implicitHeight: 300
                // implicitHeight: Math.max(100, 300)
                
                Row {
                    anchors.fill: parent
                    spacing: 10

                    FancyText {
                        text: notificationContent
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Rectangle {
                        height: 50
                        width: 50
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Rectangle {
                        height: 50
                        width: 50
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
}
