cmake_minimum_required(VERSION 3.16)

project(task4 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)
find_package(Qt6 REQUIRED COMPONENTS Quick LinguistTools)

qt_standard_project_setup(
    REQUIRES 6.5
    I18N_SOURCE_LANGUAGE en
    I18N_TRANSLATED_LANGUAGES ar
)

if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/importedcontent/CMakeLists.txt")
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/importedcontent)
endif()

qt_add_executable(apptask4
    main.cpp
)

qt_add_qml_module(apptask4
    URI task4
    VERSION 1.0

    QML_FILES
        Main.qml
        LoginPage.qml
        HomePage.qml
        ProductsPage.qml
        ProductDetails.qml
        CartPage.qml
        CheckoutPage.qml
        SettingsPage.qml
        ProductCard.qml
    RESOURCES
        icons.qrc
)

set_target_properties(apptask4 PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.apptask4
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

qt_add_translations(apptask4
    TS_FILE_BASE qml
    TS_FILE_DIR i18n
    RESOURCE_PREFIX /qt/qml/task4/i18n
)

target_link_libraries(apptask4
    PRIVATE Qt6::Quick
)

install(TARGETS apptask4
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
