import QtQuick
import Quickshell
import Quickshell.Services.UPower

import "root:/Appearance"

Text {
    visible: UPower.displayDevice.isLaptopBattery
    text: `${UPower.displayDevice.percentage * 100}%` + (UPower.onBattery ? " 󰁹" : " 󰂄")
    color: Theme.green1
    font.pointSize: 10.5
}
