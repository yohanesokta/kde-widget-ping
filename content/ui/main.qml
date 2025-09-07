import QtQuick 2.15
import org.kde.plasma.core 5.0
import "../code/PingModel.qml" as Code

Item {
    id: root
    Code.PingModel {
        id: pingModel
        target: "8.8.8.8"
        onPingUpdated: {
            statusText.text = "Ping: " + latency + " ms"
        }
    }

    Rectangle {
        id: mainRectangle
        width: 150
        height: 30
        color: "transparent"
        
        Text {
            id: statusText
            text: "Checking..."
            anchors.centerIn: parent
            color: "white"
        }
    }
}