# SPDX-FileCopyrightText: 2022 Felipe Kinoshita <kinofhek@gmail.com>
# SPDX-License-Identifier: BSD-2-Clause

add_executable(eloquens
    main.cpp
    about.cpp
    app.cpp
    controller.cpp
    resources.qrc)

target_link_libraries(eloquens
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::Quick
    Qt::QuickControls2
    Qt::Svg
    Qt::Widgets
    KF5::I18n
    KF5::CoreAddons
    KF5::ConfigCore
    KF5::ConfigGui
    KF5::DBusAddons)

kconfig_add_kcfg_files(eloquens GENERATE_MOC config.kcfgc)
install(TARGETS eloquens ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
