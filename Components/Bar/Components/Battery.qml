import QtQuick
import Quickshell
import Quickshell.Services.UPower

import "root:/Appearance"
import "root:/Widgets"

Row {
    anchors.verticalCenter: parent.verticalCenter
    spacing: 5

    StyledText {
        visible: UPower.displayDevice.isLaptopBattery
        text: `${UPower.displayDevice.percentage * 100}%` + (UPower.onBattery ? " 󰁹" : " 󰂄")
        color: Theme.green1
    }

    StyledText {
        visible: UPower.displayDevice.isLaptopBattery
        text: " | "
    }
}
