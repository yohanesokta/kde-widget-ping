import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.plasma.configuration 2.0

Column {
    id: root
    spacing: 10
    anchors.margins: 12

    Row {
        spacing: 6
        Label {
            text: i18n("Hostname / IP:")
        }
        TextField {
            id: hostField
            text: plasmoid.configuration.hostname || "8.8.8.8"
            onTextChanged: plasmoid.configuration.hostname = text
            width: 150
        }
    }

    Row {
        spacing: 6
        Label {
            text: i18n("Interval (ms):")
        }
        SpinBox {
            id: intervalField
            from: 500
            to: 10000
            stepSize: 500
            value: plasmoid.configuration.interval || 500
            onValueChanged: plasmoid.configuration.interval = value
            width: 100
        }
    }
}
