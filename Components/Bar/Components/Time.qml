pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string time: Qt.formatDateTime(clock.date, "ddd dd MMM, hh:mm:ss")

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
