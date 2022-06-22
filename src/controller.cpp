// SPDX-FileCopyrightText: 2022 Felipe Kinoshita <kinofhek@gmail.com>
// SPDX-License-Identifier: LGPL-2.1-or-later

#include <QClipboard>
#include <QGuiApplication>
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkReply>
#include <QUrlQuery>

#include "controller.h"
#include "config.h"

Controller::Controller(QObject* parent)
    : QObject(parent)
{
}

void Controller::fetch()
{
    QUrl url = QString("https://loripsum.net/generate.php?p=%1&l=%2&d=%3&a=%4&co=%5&ul=%6&ol=%7&dl=%8&bq=%9&h=%10&ac=%11")
        .arg(Config::self()->paragraphs())
        .arg(Config::self()->paragraphLength())
        .arg(booleanToInt(Config::self()->boldAndItalic()))
        .arg(booleanToInt(Config::self()->links()))
        .arg(booleanToInt(Config::self()->code()))
        .arg(booleanToInt(Config::self()->unorderedLists()))
        .arg(booleanToInt(Config::self()->orderedLists()))
        .arg(booleanToInt(Config::self()->descriptionLists()))
        .arg(booleanToInt(Config::self()->blockquotes()))
        .arg(booleanToInt(Config::self()->headings()))
        .arg(booleanToInt(Config::self()->allCaps()));

    QNetworkRequest request = QNetworkRequest(url);

    QNetworkReply* reply = m_manager.get(request);

    // read data
    QObject::connect(reply, &QNetworkReply::finished, [this, reply]() {
        QString replyText = reply->readAll();

        Q_EMIT response(replyText.toUtf8());

        reply->deleteLater(); // make sure to clean up
    });
}

int Controller::booleanToInt(bool boolean)
{
    return boolean ? 1 : 0;
}
