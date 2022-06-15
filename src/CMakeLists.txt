# SPDX-FileCopyrightText: 2022 Felipe Kinoshita <kinofhek@gmail.com>
# SPDX-License-Identifier: BSD-2-Clause

add_executable(eloquens
    main.cpp
    about.cpp
    app.cpp
    controller.cpp
    resources.qrc)

target_link_libraries(eloquens
    Qt5::Core
    Qt5::Gui
    Qt5::Qml
    Qt5::Quick
    Qt5::QuickControls2
    Qt5::Svg
    KF5::I18n
    KF5::CoreAddons
    KF5::ConfigCore
    KF5::ConfigGui
    KF5::DBusAddons)

kconfig_add_kcfg_files(eloquens GENERATE_MOC config.kcfgc)
install(TARGETS eloquens ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
