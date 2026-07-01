pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property int buttonW: 26
  readonly property int buttonH: 26

  readonly property real iconW: 16
  readonly property real iconH: 16

  readonly property color black: "#13141b"
  readonly property color red: "#ff3b48"
  readonly property color blue: "#34ffa6"
}
