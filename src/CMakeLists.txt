# SPDX-FileCopyrightText: 2022 Felipe Kinoshita <kinofhek@gmail.com>
# SPDX-License-Identifier: BSD-2-Clause

add_executable(eloquens
    main.cpp
    controller.cpp)

ecm_add_qml_module(eloquens URI "org.kde.eloquens")

ecm_target_qml_sources(eloquens SOURCES
    ui/About.qml
    ui/GlobalMenu.qml
    ui/Main.qml
    ui/PageHeader.qml
    ui/Settings.qml)

target_link_libraries(eloquens PRIVATE
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::Quick
    Qt::QuickControls2
    Qt::Svg
    Qt::Widgets
    KF6::I18n
    KF6::CoreAddons
    KF6::ConfigCore
    KF6::ConfigGui
    KF6::DBusAddons)

kconfig_target_kcfg_file(eloquens
        FILE config.kcfg
        CLASS_NAME Config
        MUTATORS
        DEFAULT_VALUE_GETTERS
        GENERATE_PROPERTIES
        SINGLETON
        PARENT_IN_CONSTRUCTOR
        GENERATE_MOC
        QML_REGISTRATION)
install(TARGETS eloquens ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
