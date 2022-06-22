// SPDX-FileCopyrightText: 2022 Felipe Kinoshita <kinofhek@gmail.com>
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.19 as Kirigami

import org.kde.eloquens 1.0

Kirigami.Page {
    id: settingsPage

    title: i18n("Settings")

    Kirigami.FormLayout {
        anchors.fill: parent

        RowLayout {
            QQC2.Label {
                text: i18n("Paragraphs:")
            }
            QQC2.SpinBox {
                from: 1
                to: 100
                value: Config.paragraphs

                onValueModified: {
                    Config.paragraphs = value
                    Config.save()
                    Controller.fetch()
                }
            }
        }

        RowLayout {
            QQC2.Label {
                text: i18n("Paragraph Length:")
            }
            QQC2.ComboBox {
                model: ["short", "medium", "long"]

                currentIndex: {
                    if (Config.paragraphLength == "small") {
                        return 0;
                    } else if (Config.paragraphLength == "medium") {
                        return 1;
                    } else if (Config.paragraphLength == "long") {
                        return 2;
                    }
                }
                onCurrentIndexChanged: {
                    if (currentIndex == 0) {
                        Config.paragraphLength = "small"
                    } else if (currentIndex == 1) {
                        Config.paragraphLength = "medium"
                    } else if (currentIndex == 2) {
                        Config.paragraphLength = "long"
                    }

                    Config.save()
                    Controller.fetch()
                }
            }
        }

        QQC2.CheckBox {
            text: i18n("Show Bold and Italic text")
            checked: Config.boldAndItalic
            onCheckedChanged: {
                Config.boldAndItalic = checked
                Config.save()
                Controller.fetch()
            }
        }

        QQC2.CheckBox {
            text: i18n("Show Links")
            checked: Config.links
            onCheckedChanged: {
                Config.links = checked
                Config.save()
                Controller.fetch()
            }
        }

        QQC2.CheckBox {
            text: i18n("Show Code blocks")
            checked: Config.code
            onCheckedChanged: {
                Config.code = checked
                Config.save()
                Controller.fetch()
            }
        }

        QQC2.CheckBox {
            text: i18n("Show Unordered Lists")
            checked: Config.unorderedLists
            onCheckedChanged: {
                Config.unorderedLists = checked
                Config.save()
                Controller.fetch()
            }
        }

        QQC2.CheckBox {
            text: i18n("Show Ordered Lists")
            checked: Config.orderedLists
            onCheckedChanged: {
                Config.orderedLists = checked
                Config.save()
            }
        }

        QQC2.CheckBox {
            text: i18n("Show Description Lists")
            checked: Config.descriptionLists
            onCheckedChanged: {
                Config.descriptionLists = checked
                Config.save()
                Controller.fetch()
            }
        }

        QQC2.CheckBox {
            text: i18n("Show Blockquotes")
            checked: Config.blockquotes
            onCheckedChanged: {
                Config.blockquotes = checked
                Config.save()
                Controller.fetch()
            }
        }

        QQC2.CheckBox {
            text: i18n("Show headings")
            checked: Config.headings
            onCheckedChanged: {
                Config.headings = checked
                Config.save()
                Controller.fetch()
            }
        }

        QQC2.CheckBox {
            text: i18n("All Caps")
            checked: Config.allCaps
            onCheckedChanged: {
                Config.allCaps = checked
                Config.save()
                Controller.fetch()
            }
        }
    }
}
