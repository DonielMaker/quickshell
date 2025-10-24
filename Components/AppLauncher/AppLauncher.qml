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

    Menu {
        menuItems: AppSearch.applications
    }
}
