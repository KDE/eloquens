// SPDX-FileCopyrightText: 2022 Felipe Kinoshita <kinofhek@gmail.com>
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.19 as Kirigami

import org.kde.eloquens 1.0

Kirigami.ApplicationWindow {
    id: root

    title: i18n("Eloquens")

    width: Kirigami.Units.gridUnit * 35
    height: Kirigami.Units.gridUnit * 28
    minimumWidth: Kirigami.Units.gridUnit * 20
    minimumHeight: Kirigami.Units.gridUnit * 25

    Loader {
        active: !Kirigami.Settings.isMobile
        sourceComponent: GlobalMenu {}
    }

    pageStack.initialPage: Kirigami.Page {
        id: page

        padding: 0
        titleDelegate: PageHeader {}

        QQC2.ScrollView {
            anchors.fill: parent

            QQC2.TextArea {
                id: textArea

                text: Config.previousText
                textFormat: TextEdit.RichText
                textMargin: 0
                readOnly: true

                font.family: "Liberation Serif";
                font.pixelSize: Kirigami.Units.gridUnit

                background: Rectangle {
                    Kirigami.Theme.colorSet: Kirigami.Theme.View
                    Kirigami.Theme.inherit: false
                    color: Kirigami.Theme.backgroundColor

                    Kirigami.PlaceholderMessage {
                        visible: textArea.text.length <= 0
                        anchors.centerIn: parent
                        width: parent.width - (Kirigami.Units.smallSpacing * 4)
                        text: i18n("Click 'Generate' to get started!")
                    }
                }

                Connections {
                    target: Controller

                    function onResponse(response) {
                        textArea.text = response
                        Config.previousText = response
                    }
                }
            }
        }
    }

    Component.onCompleted: Controller.fetch()
}
