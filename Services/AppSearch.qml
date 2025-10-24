pragma Singleton

import Quickshell

Singleton {

    property var applications: DesktopEntries.applications.values.filter(entry => !entry.noDisplay && !entry.runInTerminal)

    property int index: 0

    function search(query) {

        if (!query || query.length == 0) {
            return applications
        }

        const queryLower = query.toLowerCase().trim()

        const foundApps = applications.filter(entry => entry.name.toLowerCase().includes(queryLower))

        index = 0

        return foundApps
    }
}
