import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs.Appearance
import qs.Widgets

Row {
    visible: UPower.displayDevice.isLaptopBattery
    anchors.verticalCenter: parent.verticalCenter
    property int batteryPercentage: Math.floor(UPower.displayDevice.percentage * 100)
    spacing: 5
    leftPadding: 10

    FancyText {
        visible: UPower.displayDevice.isLaptopBattery
        text: `${batteryPercentage}%` + (UPower.onBattery ? " 󰁹" : " 󰂄")
        color: Theme.green1
    }

    FancyText {
        text: " | "
    }
}
