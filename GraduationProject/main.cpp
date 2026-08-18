#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "radiostationmodel.h"
#include "mediabackend.h"
#include "usbbackend.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // =====================================================
    // RADIO BACKEND
    // =====================================================

    RadioStationModel radioModel;

    engine.rootContext()->setContextProperty(
        "radioModel",
        &radioModel
        );

    // =====================================================
    // MEDIA BACKEND
    // =====================================================

    MediaBackend mediaBackend;

    engine.rootContext()->setContextProperty(
        "mediaBackend",
        &mediaBackend
        );

    // =====================================================
    // USB BACKEND
    // =====================================================

    usbbackend usbBackend;

    engine.rootContext()->setContextProperty(
        "usbBackend",
        &usbBackend
        );

    // =====================================================
    // QML ERROR HANDLING
    // =====================================================

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []()
        {
            QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection
        );

    // =====================================================
    // LOAD MAIN QML
    // =====================================================

    engine.loadFromModule(
        "MediaPlayerIVI",
        "Main"
        );

    return app.exec();
}
