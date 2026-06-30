import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

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
  }

  Timer {
    interval: 1000 * 2 // Update every 2 seconds
    running: root.isRunning
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      statFile.reload()
      parseStat(statFile.text())
    }
  }

  function parseStat(text) {
    const lines = text.split("\n").filter(l => /^cpu\d/.test(l))
    const newUsages = []
    const newIdle = []
    const newTotal = []

    for (let i = 0; i < lines.length; i++) {
      const fields = lines[i].trim().split(/\s+/).slice(1).map(Number)
      // user nice system idle iowait irq softirq steal
      const idle = fields[3] + fields[4]
      const total = fields.reduce((a, b) => a + b, 0)

      if (prevTotal[i] !== undefined) {
        const totalDiff = total - prevTotal[i]
        const idleDiff = idle - prevIdle[i]
        newUsages.push(totalDiff > 0 ? (1 - idleDiff / totalDiff) * 100 : 0)
      } else {
        newUsages.push(0)
      }
      newIdle.push(idle)
      newTotal.push(total)
    }

    coreUsages = newUsages
    prevIdle = newIdle
    prevTotal = newTotal
  }

  GridLayout {
    id: layout
    columns: 4
    columnSpacing: 5

    Repeater {
      model: root.coreUsages
      delegate: ColumnLayout {
        Text {
          text: "Core" + index + ": " + Math.round(modelData) + "%"
          color: "white"
          font.pixelSize: 10
          Layout.alignment: Qt.AlignHCenter
        }
      }
    }
  }
}
