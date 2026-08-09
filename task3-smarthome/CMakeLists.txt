cmake_minimum_required(VERSION 3.16)

project(task3qt VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick LinguistTools)

qt_standard_project_setup(REQUIRES 6.10)

if (EXISTS "${CMAKE_CURRENT_LIST_DIR}/importedcontent/CMakeLists.txt")
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/importedcontent)
endif()

qt_add_executable(apptask3qt
    main.cpp
)

qt_add_qml_module(apptask3qt
    URI task3qt

    QML_FILES
        Main.qml
        LoginPage.qml
        DashboardPage.qml
        SettingsPage.qml
        DeviceCard.qml


    RESOURCES
        images/logo.png
        images/home.png
        images/light.png
        images/fan.png
        images/ac.png
        images/garage.png
)

# Set up translations for Arabic and English
# Add translation targets
qt_add_translations(apptask3qt
    TS_FILES
        translations/app_ar.ts
        translations/app_en.ts
)

set_target_properties(apptask3qt PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(apptask3qt
    PRIVATE Qt6::Quick
)

install(TARGETS apptask3qt
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
