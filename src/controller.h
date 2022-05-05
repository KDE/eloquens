// SPDX-FileCopyrightText: 2022 Felipe Kinoshita <kinofhek@gmail.com>
// SPDX-License-Identifier: LGPL-2.1-or-later

#pragma once

#include <QObject>
#include <QJsonObject>
#include <QNetworkAccessManager>

class Controller : public QObject
{
    Q_OBJECT

public:
    explicit Controller(QObject* parent = nullptr);

    Q_INVOKABLE void fetch();

    Q_SIGNAL void response(QString);

private:
    QNetworkAccessManager m_manager;
};
