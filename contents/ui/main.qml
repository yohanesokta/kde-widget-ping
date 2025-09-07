import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {
    id: root
    width: 200
    height: 70

    property string pingValue: "..."
    property string connectionState: "checking"

    PlasmaCore.DataSource {
        id: pingSource
        engine: "executable"
        connectedSources: []

        onNewData: {
            var output = data["stdout"];
            var regex = /time=([0-9.]+) ms/;
            var match = regex.exec(output);

            if (match) {
                pingValue = match[1] + " ms";
                connectionState = "online";
            } else {
                pingValue = "Offline";
                connectionState = "offline";
            }
            disconnectSource(sourceName);
        }
    }

    Timer {
        id: pingTimer
        interval: 500
        running: true
        repeat: true
        onTriggered: pingSource.connectSource("/bin/bash -c \"ping -c 1 8.8.8.8\"")
    }

    Plasmoid.fullRepresentation: ColumnLayout {
        anchors.fill: parent
        spacing: 8
        Label {
            id: statusText
            text: pingValue
            font.bold: true
            font.pointSize: 14
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            color: connectionState === "online"   ? "lightgreen"
                 : connectionState === "offline" ? "red"
                 : "yellow"
        }
    }

    Plasmoid.compactRepresentation: Item {
        anchors.fill: parent
        Label {
            id: compactStatus
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: pingValue
            font.bold: true
            font.pointSize: 10
            padding: 4
            color: connectionState === "online"   ? "lightgreen"
                 : connectionState === "offline" ? "red"
                 : "yellow"
        }
    }
}
