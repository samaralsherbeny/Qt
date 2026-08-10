project(QtCalculator LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Widgets)

add_executable(QtCalculator
    main.cpp
    mainwindow.h
    mainwindow.cpp
)

target_link_libraries(QtCalculator PRIVATE Qt6::Widgets)
