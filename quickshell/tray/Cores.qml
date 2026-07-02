import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell.Io
import "../styles"

Item {
  id: root
  implicitWidth: layout.implicitWidth
  implicitHeight: layout.implicitHeight

  property bool isRunning: false
  property var coreUsages: []
  property var prevIdle: []
  property var prevTotal: []

  FileView {
    id: statFile
    path: "/proc/stat"
    onLoaded: root.parseStat(statFile.text())
  }

  Component.onCompleted: {
    statFile.reload();
  }

  Timer {
    id: timer
    interval: 1000
    running: root.isRunning
    repeat: true
    onTriggered: statFile.reload()
  }

  function parseStat(text) {
    const lines = text.split("\n").filter(l => /^cpu\d/.test(l));
    const newUsages = [];
    const newIdle = [];
    const newTotal = [];

    for (let i = 0; i < lines.length; i++) {
      const fields = lines[i].trim().split(/\s+/).slice(1).map(Number);
      // user nice system idle iowait irq softirq steal
      const idle = fields[3] + fields[4];
      const total = fields.reduce((a, b) => a + b, 0);

      if (prevTotal[i] !== undefined) {
        const totalDiff = total - prevTotal[i];
        const idleDiff = idle - prevIdle[i];
        newUsages.push(totalDiff > 0 ? (1 - idleDiff / totalDiff) * 100 : 0);
      } else {
        newUsages.push(0);
      }
      newIdle.push(idle);
      newTotal.push(total);
    }

    coreUsages = newUsages;
    prevIdle = newIdle;
    prevTotal = newTotal;
  }

  GridLayout {
    id: layout
    columns: 4
    columnSpacing: 5

    Repeater {
      model: root.coreUsages

      delegate: Rectangle {
        id: columnRoot
        required property real modelData
        required property int index

        color: "transparent"
        implicitWidth: 30 + 8
        implicitHeight: implicitWidth

        Shape {
          id: bgShape
          anchors.fill: parent
          property int cutSize: 7

          ShapePath {
            id: bottomRightCorner
            strokeColor: "transparent"
            fillColor: Style.color4
            startX: 0
            startY: bgShape.cutSize

            PathLine {
              x: bgShape.cutSize
              y: 0
            }

            PathLine {
              x: bgShape.width - bgShape.cutSize
              y: 0
            }

            PathLine {
              x: bgShape.width
              y: bgShape.cutSize
            }

            PathLine {
              x: bgShape.width
              y: bgShape.height - bgShape.cutSize
            }

            PathLine {
              x: bgShape.width - bgShape.cutSize
              y: bgShape.height
            }

            PathLine {
              x: bgShape.cutSize
              y: bgShape.height
            }

            PathLine {
              x: 0
              y: bgShape.height - bgShape.cutSize
            }
          }
        }

        Text {
          id: coreId
          text: columnRoot.index + 1
          anchors.centerIn: parent
          font.pixelSize: 32
          font.family: Style.fontFamily
          font.bold: true
          topPadding: 4
          opacity: 0.25
          color: Style.color0
        }

        Text {
          id: label
          anchors.centerIn: parent
          text: String(Math.round(columnRoot.modelData)).padStart(3, "0") + "%"
          color: Style.color0
          font.pixelSize: 12
          font.bold: true
          font.family: Style.fontFamily
          topPadding: 4
          Layout.alignment: Qt.AlignHCenter
          opacity: 0.9
        }
      }
    }
  }
}
