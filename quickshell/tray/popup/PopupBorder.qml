import QtQuick.Shapes
import QtQuick

Rectangle {
  id: popupBorder
  anchors.fill: parent
  antialiasing: true

  property color borderColor: "#ffffff"

  Shape {
    anchors.fill: parent

    Shape {
      id: border
      anchors.fill: parent
      property int size: 8
      property int offset: 1

      ShapePath {
        strokeColor: popupBorder.borderColor
        strokeWidth: 5
        fillColor: "transparent"
        startX: border.offset
        startY: border.size + border.offset

        PathLine {
          x: border.offset
          y: border.offset
        }

        PathLine {
          x: border.size + border.offset
          y: border.offset
        }
      }

      ShapePath {
        strokeColor: popupBorder.borderColor
        strokeWidth: 5
        fillColor: "transparent"
        startX: popupBorder.width - 8
        startY: 0

        PathLine {
          x: popupBorder.width
          y: 0
        }

        PathLine {
          x: popupBorder.width
          y: 8
        }
      }

      ShapePath {
        strokeColor: popupBorder.borderColor
        strokeWidth: 5
        fillColor: "transparent"
        startX: popupBorder.width
        startY: popupBorder.height - 8

        PathLine {
          x: popupBorder.width
          y: popupBorder.height
        }

        PathLine {
          x: popupBorder.width - 8
          y: popupBorder.height
        }
      }

      ShapePath {
        strokeColor: popupBorder.borderColor
        strokeWidth: 5
        fillColor: "transparent"
        startX: border.offset
        startY: popupBorder.height - border.size

        PathLine {
          x: border.offset
          y: popupBorder.height
        }

        PathLine {
          x: border.size
          y: popupBorder.height
        }
      }
    }
  }
}
