// SPDX-FileCopyrightText: 2022 Felipe Kinoshita <kinofhek@gmail.com>
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

import org.kde.eloquens

RowLayout {
    id: pageHeader

    Layout.fillWidth: true
    spacing: 0

    QQC2.ToolButton {
        action: Kirigami.Action {
            text: i18n("Generate Text")
            icon.name: "xml-text-new"
            shortcut: StandardKey.New
            onTriggered: Controller.fetch()
        }
    }

    Item {
        Layout.fillWidth: true
    }

    QQC2.ToolButton {
        display: QQC2.AbstractButton.IconOnly
        action: Kirigami.Action {
            text: i18n("Copy to Clipboard")
            icon.name: "edit-copy"
            shortcut: StandardKey.Copy
            onTriggered: {
                textArea.selectAll()
                textArea.copy()
                textArea.moveCursorSelection(0, TextEdit.SelectCharacters)
                textArea.deselect()
            }
        }

        QQC2.ToolTip.visible: hovered
        QQC2.ToolTip.text: text
        QQC2.ToolTip.delay: Kirigami.Units.toolTipDelay
    }

    QQC2.ToolButton {
        display: QQC2.AbstractButton.IconOnly
        action: Kirigami.Action {
            text: i18n("Configure Eloquens")
            icon.name: "settings-configure"
            shortcut: "Ctrl+Shift+,"
            onTriggered: pageStack.layers.push("Settings.qml")
            enabled: pageStack.layers.depth <= 1
        }

        QQC2.ToolTip.visible: hovered
        QQC2.ToolTip.text: text
        QQC2.ToolTip.delay: Kirigami.Units.toolTipDelay
    }

    QQC2.ToolButton {
        display: QQC2.AbstractButton.IconOnly
        action: Kirigami.Action {
            text: i18n("About Eloquens")
            icon.name: "help-about"
            shortcut: StandardKey.HelpContents
            onTriggered: pageStack.layers.push("About.qml")
            enabled: pageStack.layers.depth <= 1
        }

        QQC2.ToolTip.visible: hovered
        QQC2.ToolTip.text: text
        QQC2.ToolTip.delay: Kirigami.Units.toolTipDelay
    }
}
