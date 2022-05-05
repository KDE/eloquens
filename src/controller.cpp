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
        .arg(Config::self()->boldAndItalic())
        .arg(Config::self()->links())
        .arg(Config::self()->code())
        .arg(Config::self()->unorderedLists())
        .arg(Config::self()->orderedLists())
        .arg(Config::self()->descriptionLists())
        .arg(Config::self()->blockquotes())
        .arg(Config::self()->headings())
        .arg(Config::self()->allCaps());

    QNetworkRequest request = QNetworkRequest(url);

    QNetworkReply* reply;

    reply = m_manager.get(request);

    // read data
    QObject::connect(reply, &QNetworkReply::finished, [this, reply]() {
        QString replyText = reply->readAll();

        Q_EMIT response(replyText.toUtf8());

        reply->deleteLater(); // make sure to clean up
    });
}
