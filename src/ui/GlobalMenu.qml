// SPDX-FileCopyrightText: 2022 Felipe Kinoshita <kinofhek@gmail.com>
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.15
import Qt.labs.platform 1.1 as Labs
import org.kde.kirigami 2.19 as Kirigami

import org.kde.eloquens

Labs.MenuBar {
    id: menuBar

    Labs.Menu {
        title: i18nc("@menu", "File")

        Labs.MenuItem {
            text: i18nc("@menu-action", "Generate Text")
            icon.name: "xml-text-new"
            onTriggered: Controller.fetch()
        }

        Labs.MenuItem {
            text: i18nc("@menu-action", "Quit")
            icon.name: "application-exit"
            onTriggered: Qt.quit()
        }
    }

    Labs.Menu {
        title: i18nc("@menu", "Edit")

        Labs.MenuItem {
            text: i18nc("@menu-action", "Copy to Clipboard")
            icon.name: "edit-copy"
            onTriggered: {
                textArea.selectAll()
                textArea.copy()
                textArea.moveCursorSelection(0, TextEdit.SelectCharacters)
                textArea.deselect()
            }
        }
    }

    Labs.Menu {
        title: i18nc("@menu", "Help")

        Labs.MenuItem {
            text: i18nc("@menu-action", "Report Bug…")
            icon.name: "tools-report-bug"
            onTriggered: Qt.openUrlExternally(AboutType.aboutData.bugAddress);
        }

        Labs.MenuItem {
            text: i18nc("@menu-action", "About Eloquens")
            icon.name: "help-about"
            onTriggered: pageStack.layers.push("About.qml")
            enabled: pageStack.layers.depth <= 1
        }
    }
}
