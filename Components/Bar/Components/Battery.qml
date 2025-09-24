import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs.Appearance
import qs.Widgets

Row {
    anchors.verticalCenter: parent.verticalCenter
    property int batteryPercentage: Math.floor(UPower.displayDevice.percentage * 100)
    spacing: 5

    StyledText {
        visible: UPower.displayDevice.isLaptopBattery
        text: `${batteryPercentage}%` + (UPower.onBattery ? " 󰁹" : " 󰂄")
        color: Theme.green1
    }

    StyledText {
        visible: UPower.displayDevice.isLaptopBattery
        text: " | "
    }
}
