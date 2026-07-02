pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property int buttonW: 26
  readonly property int buttonH: 26

  readonly property real iconW: 16
  readonly property real iconH: 16

  readonly property color color0: "#13141b" // Black
  readonly property color color1: "#ff3b48" // Red
  readonly property color color2: "#000000" // Green
  readonly property color color3: "#fdfc02" // Yellow
  readonly property color color4: "#34ffa6" // Blue
  readonly property color color5: "#000000" // Magenta
  readonly property color color6: "#000000" // Cyan
  readonly property color color7: "#ffffff" // White

  // Bright
  readonly property color color8: "#13141b"   // Bright black
  readonly property color color9: "#ff3b48"   // Bright Red
  readonly property color color10: "#000000"  // Bright Green
  readonly property color color11: "#fcfb00"  // Bright Yellow
  readonly property color color12: "#34ffa6"  // Bright Blue
  readonly property color color13: "#000000"  // Bright Magenta
  readonly property color color14: "#000000"  // Bright Cyan
  readonly property color color15: "#ffffff"  // Bright White

  readonly property string fontFamily: "SquareFont"
}
