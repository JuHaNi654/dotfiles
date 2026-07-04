import QtQuick
import QtQuick.Shapes
import "../styles"

Rectangle {
  id: root
  color: "transparent"
  property real cutSize: 7
  property color borderColor: "#ffffff"

  // Background
  Shape {
    id: bgShape
    anchors.fill: parent

    // Corner cuts
    ShapePath {
      id: bottomRightCorner
      strokeColor: "transparent"
      fillColor: Style.color0
      startX: 0
      startY: 0
      PathLine {
        x: bgShape.width - 1
        y: 0
      }

      PathLine {
        x: bgShape.width - 1
        y: bgShape.height - 1 - root.cutSize
      }
      PathLine {
        x: bgShape.width - 1 - root.cutSize
        y: bgShape.height - 1
      }

      PathLine {
        x: 0
        y: bgShape.height - 1
      }
    }

    // Corner border style
    Shape {
      id: corners
      anchors.fill: parent
      antialiasing: true

      ShapePath { // top-left
        strokeColor: root.borderColor
        strokeWidth: 2
        fillColor: "transparent"
        startX: corners.width - 2
        startY: 9
        PathLine {
          x: corners.width - 2
          y: 1
        }
        PathLine {
          x: corners.width - 9
          y: 1
        }
      }

      ShapePath { // bottom-right
        strokeColor: root.borderColor
        strokeWidth: 2
        fillColor: "transparent"
        startX: 1
        startY: corners.height - 9 - 2
        PathLine {
          x: 1
          y: corners.height - 2
        }
        PathLine {
          x: 9
          y: corners.height - 2
        }
      }
    }
  }
}
