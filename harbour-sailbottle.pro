# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-sailbottle

CONFIG += sailfishapp

SOURCES += src/harbour-sailbottle.cpp

OTHER_FILES += qml/harbour-sailbottle.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-sailbottle.spec \
    rpm/harbour-sailbottle.yaml \
    translations/*.ts \
    harbour-sailbottle.desktop \
    qml/pages/volume.qml \
    qml/cover/bottle.png \
    qml/pages/about.qml \
    qml/bottle-small.png \
    qml/drop-small.png \
    translations/harbour-sailbottle-de.qm \
    rpm/harbour-sailbottle.changes

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-sailbottle-de.ts

translations.path = /usr/share/harbour-sailbottle/translations
translations.files = translations/harbour-sailbottle-de.qm
INSTALLS += translations
