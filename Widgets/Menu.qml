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

            }
        }
    }
}
