import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick.Effects
import qs.Appearance
import qs.Widgets

Scope {
	id: root

	// Bind the pipewire node so its volume will be tracked
	PwObjectTracker {
		objects: [ Pipewire.defaultAudioSource ]
	}

	Connections {
		target: Pipewire.defaultAudioSource?.audio

        function onMutedChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }
	}

	property bool shouldShowOsd: false
    property bool muted: Pipewire.defaultAudioSource?.audio.muted

	Timer {
		id: hideTimer
		interval: 500
		onTriggered: root.shouldShowOsd = false
	}

	// The OSD window will be created and destroyed based on shouldShowOsd.
	// PanelWindow.visible could be set instead of using a loader, but using
	// a loader will reduce the memory overhead when the window isn't open.
	LazyLoader {
		active: root.shouldShowOsd

		PanelWindow {
            WlrLayershell.layer: WlrLayer.Overlay
            exclusiveZone: 0
			// Since the panel's screen is unset, it will be picked by the compositor
			// when the window is created. Most compositors pick the current active monitor.

            anchors.bottom: true
            margins.bottom: screen.height / 20

			implicitHeight: 50
			implicitWidth: height

			color: "transparent"

			// An empty click mask prevents the window from blocking mouse events.
			mask: Region {}

			Rectangle {
				anchors.fill: parent
				radius: 25
				color: "#24283b"
                border.color: "#2f334c"
                border.width: 2

                Text {
                    anchors.centerIn: parent
                    text: ""
                    color: muted ? Theme.red : Theme.blue
                    font.pointSize: 20
                }
			}
		}
	}
}

