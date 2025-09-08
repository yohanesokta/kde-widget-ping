import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.plasma.configuration 2.0

ConfigPage {
    ConfigSection {
        label: i18n("Ping Settings")

        ConfigTextField {
            configKey: "hostname"
            label: i18n("Hostname or IP")
            defaultValue: "8.8.8.8"
        }
    }
}
