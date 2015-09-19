/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include <QtQuick>
#include <sailfishapp.h>
#include <QDebug>
#include <QDir>
#include <QScopedPointer>
#include <QQuickView>
#include <QQmlEngine>
#include <QGuiApplication>

#include "server_configurator.h"
#include "settings.h"

static QJSValue appVersionSingletonProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)

    QJSValue appInfo = scriptEngine->newObject();
    appInfo.setProperty("version", GIT_VERSION);
    return appInfo;
}


int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view (SailfishApp::createView());

    QScopedPointer<ServerConfigurator> serverConfigurator (new ServerConfigurator(app.data()));
    serverConfigurator->configure(view.data());

    qmlRegisterSingletonType("harbour.wlan.keyboard", 1, 0, "AppInfo", appVersionSingletonProvider);

    //Utils appUtils = ;
    view->rootContext()->setContextProperty("utils", &Utils::getInstance(app.data()));

    Settings &settings = Settings::getInstance();
    view->rootContext()->setContextProperty("_qtSettings", &settings);
    qmlRegisterType<Settings>("harbour.wlan.keyboard",1,0,"Settings");

    view->setSource(SailfishApp::pathTo("qml/harbour-wlan-keyboard.qml") );
    view->showFullScreen();

    return app->exec();

}
