cmake_minimum_required(VERSION 3.16)

project(hello_live VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick LinguistTools)

qt_standard_project_setup(
REQUIRES 6.10
I18N_SOURCE_LANGUAGE en
I18N_TRANSLATED_LANGUAGES ar
)

qt_add_executable(apptask5
main.cpp
)

qt_add_qml_module(apptask5
URI task5


QML_FILES
    Main.qml
    LoginPage.qml
    DashboardPage.qml
    SettingsPage.qml
    DeviceCard.qml

RESOURCES
    pictures.qrc


)

qt_add_translations(apptask5
TS_FILE_BASE qml
TS_FILE_DIR i18n

RESOURCE_PREFIX
    /qt/qml/task5/i18n


)

set_target_properties(apptask5 PROPERTIES
MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
MACOSX_BUNDLE TRUE
WIN32_EXECUTABLE TRUE
)

target_link_libraries(apptask5
PRIVATE Qt6::Quick
)

include(GNUInstallDirs)

install(TARGETS apptask5
BUNDLE DESTINATION .
LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
