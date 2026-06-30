import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Shapes
import QtQuick.Effects
import QtQuick.Controls

Button {
  id: button
  implicitWidth: 26
  implicitHeight: 26

  property string label: "0"
  property real cutSize: 7 

  property color color_1: "#13141b"
  property color color_2: "#ff3b48"
  property color color_3: "#34ffa6"

  property bool isHover: false 
  readonly property bool isActive: isHover

  property color bg: color_1
  property color fg: isHover ? color_3 : color_2
  Behavior on fg { ColorAnimation { duration: 150 } }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true 
    cursorShape: Qt.PointingHandCursor
    onEntered: button.isHover = true 
    onExited: button.isHover = false
  }

  // Button background shape //
  background: Rectangle {
    color: "transparent"

    Shape {
      id: bodyShape
      anchors.fill: parent

      ShapePath {
        strokeColor: "transparent"
        fillColor: button.bg
        startX: 0; startY: 0
        PathLine { x: bodyShape.width - 1; y: 0 }
        PathLine { x: bodyShape.width - 1; y: button.cutSize }
        PathLine { x: bodyShape.width - 1; y: bodyShape.height - 1 }
        PathLine { x: button.cutSize; y: bodyShape.height - 1 }
        PathLine { x: 0; y: bodyShape.height - 1 - button.cutSize }
        PathLine { x: 0; y: 0 }
      }
    }

  }

  // Corners // 
  Shape {
    id: corners
    anchors.fill: parent 
    antialiasing: true

    ShapePath { // top-left
      strokeColor: button.fg 
      strokeWidth: 2 
      fillColor: "transparent"
      startX: 1; startY: 9
      PathLine { x: 1; y: 1 }
      PathLine { x: 9; y: 1 }
    }

    ShapePath { // bottom-right
      strokeColor: button.fg 
      strokeWidth: 2
      fillColor: "transparent"
      startX: corners.width - 2; startY: corners.height - 10
      PathLine { x: corners.width - 2; y: corners.height - 2 }
      PathLine { x: corners.width - 10; y: corners.height - 2 }
    }
  }



  // content
  Column {
    anchors.centerIn: parent

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: button.label
      font.pixelSize: 12
      font.bold: true
      color: button.fg
    }
  }
}
