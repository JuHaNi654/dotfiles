import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Shapes
import QtQuick.Effects
import QtQuick.Controls

Button {
  id: cpu
  implicitWidth: 16
  implicitHeight: 16

  property string label: "󰀂"

  property color color_1: "#13141b"
  property color color_2: "#ff3b48"
  property color color_3: "#34ffa6"

  property bool isHover: false 
  readonly property bool isActive: isHover

  property color fg: isHover ? color_3 : color_2
  Behavior on fg { ColorAnimation { duration: 150 } }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true 
    cursorShape: Qt.PointingHandCursor
    onEntered: cpu.isHover = true 
    onExited: cpu.isHover = false
    onClicked: Quickshell.execDetached(["bash", "-c", "omarchy-launch-wifi"])
  }

  // Button background shape //
  background: Rectangle {
    color: "transparent"
  }

  // content
  Column {
    anchors.centerIn: parent

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: cpu.label
      font.pixelSize: 13
      color: cpu.fg
    }
  }
}
