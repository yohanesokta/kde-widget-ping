import QtQuick 2.15
import org.kde.plasma.core 5.0
import Qt.labs.processes 1.0

QtObject {
    id: root

    property alias target: process.arguments
    property real latency: 0
    signal pingUpdated

    Process {
        id: process
        program: "/bin/ping"
        arguments: ["-c", "1", "-W", "1", root.target]
        onReadyReadStandardOutput: {
            var output = new TextDecoder().decode(process.readAllStandardOutput());
            var lines = output.split('\n');
            var latencyLine = lines.find(line => line.includes('time='));
            if (latencyLine) {
                var matches = latencyLine.match(/time=(\d+\.?\d*)/);
                if (matches && matches.length > 1) {
                    root.latency = parseFloat(matches[1]);
                    root.pingUpdated();
                } else {
                    console.log("Failed to parse latency from line:", latencyLine);
                }
            } else {
                root.latency = -1;
                root.pingUpdated();
                console.log("No 'time=' found in ping output.");
            }
        }
        onError: {
            console.log("Process error:", process.errorString);
        }
        onFinished: {
            if (process.exitCode !== 0) {
                console.log("Ping process failed with exit code:", process.exitCode);
            }
        }
    }

    Timer {
        id: pingTimer
        interval: 5000
        running: true
        repeat: true
        onTriggered: process.start()
    }

    Component.onCompleted: {
        process.start();
    }
}