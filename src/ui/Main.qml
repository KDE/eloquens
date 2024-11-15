// SPDX-FileCopyrightText: 2022 Felipe Kinoshita <kinofhek@gmail.com>
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.config as KConfig

import org.kde.eloquens

Kirigami.ApplicationWindow {
    id: root

    title: i18n("Eloquens")

    width: Kirigami.Units.gridUnit * 35
    height: Kirigami.Units.gridUnit * 28
    minimumWidth: Kirigami.Units.gridUnit * 20
    minimumHeight: Kirigami.Units.gridUnit * 25

    KConfig.WindowStateSaver {
        configGroupName: "Main"
    }

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

            QQC2.ScrollBar.horizontal.policy: QQC2.ScrollBar.AlwaysOff

            QQC2.TextArea {
                id: textArea

                text: Config.previousText
                textFormat: TextEdit.RichText
                textMargin: 0
                readOnly: true
                wrapMode: TextEdit.WordWrap

                font.family: "serif";
                font.pixelSize: Kirigami.Units.gridUnit

                background: Rectangle {
                    Kirigami.Theme.colorSet: Kirigami.Theme.View
                    Kirigami.Theme.inherit: false
                    color: Kirigami.Theme.backgroundColor

                    Kirigami.PlaceholderMessage {
                        visible: textArea.text.length <= 0
                        anchors.centerIn: parent
                        width: parent.width - (Kirigami.Units.smallSpacing * 4)
                        text: i18n("Click 'Generate Text' to get started!")
                    }
                }

                Connections {
                    target: Controller

                    function onResponse(response) {
                        textArea.text = response
                        Config.previousText = response
                        Config.save()
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        if (Config.previousText == "") {
            Controller.fetch()
        }
    }
}
