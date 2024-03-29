// SPDX-FileCopyrightText: 2022 Felipe Kinoshita <kinofhek@gmail.com>
// SPDX-License-Identifier: LGPL-2.1-or-later

#include <QApplication>
#include <QCommandLineParser>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QUrl>
#include <QtQml>
#include <QQuickWindow>

#include "about.h"
#include "version-eloquens.h"
#include <KAboutData>
#include <KLocalizedContext>
#include <KLocalizedString>
#include <KDBusService>

constexpr auto APPLICATION_ID = "org.kde.eloquens";

#include "config.h"
#include "app.h"
#include "controller.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);
    QCoreApplication::setOrganizationName(QStringLiteral("KDE"));

    KAboutData aboutData(
                         // The program name used internally.
                         QStringLiteral("eloquens"),
                         // A displayable program name string.
                         i18nc("@title", "Eloquens"),
                         // The program version string.
                         QStringLiteral(ELOQUENS_VERSION_STRING),
                         // Short description of what the app does.
                         i18n("Generate lorem ipsum text"),
                         // The license this code is released under.
                         KAboutLicense::GPL,
                         // Copyright Statement.
                         i18n("© 2022"));
    aboutData.addAuthor(i18nc("@info:credit", "Felipe Kinoshita"), i18nc("@info:credit", "Author"), QStringLiteral("kinofhek@gmail.com"), QStringLiteral("https://fhek.gitlab.io"));
    aboutData.setBugAddress("https://bugs.kde.org/buglist.cgi?component=General&amp;product=Eloquens");
    KAboutData::setApplicationData(aboutData);
    QGuiApplication::setWindowIcon(QIcon::fromTheme(QStringLiteral("org.kde.eloquens")));

    QQmlApplicationEngine engine;

    auto config = Config::self();
    qmlRegisterSingletonInstance(APPLICATION_ID, 1, 0, "Config", config);

    AboutType about;
    qmlRegisterSingletonInstance(APPLICATION_ID, 1, 0, "AboutType", &about);

    App application;
    qmlRegisterSingletonInstance(APPLICATION_ID, 1, 0, "App", &application);

    Controller controller;
    qmlRegisterSingletonInstance(APPLICATION_ID, 1, 0, "Controller", &controller);

    QCommandLineParser parser;

    aboutData.setupCommandLine(&parser);
    parser.process(app);
    aboutData.processCommandLine(&parser);

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    KLocalizedString::setApplicationDomain("eloquens");
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    KDBusService service(KDBusService::Unique);

    // Restore window size and position
    const auto rootObjects = engine.rootObjects();
    for (auto obj : rootObjects) {
        auto view = qobject_cast<QQuickWindow *>(obj);
        if (view) {
            if (view->isVisible()) {
                application.restoreWindowGeometry(view);
            }
            break;
        }
    }

    return app.exec();
}
