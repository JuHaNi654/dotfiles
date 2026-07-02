pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Effects
import "../styles"

Item {
  id: root
  property color fill: Style.color7
  property string filePath: ""

  implicitWidth: Style.iconW
  implicitHeight: Style.iconH

  Image {
    id: iconElem
    source: Qt.resolvedUrl(root.filePath)
    sourceSize: Qt.size(Style.iconW, Style.iconH)
    visible: false
  }

  MultiEffect {
    anchors.fill: iconElem
    source: iconElem
    colorization: 1.0
    colorizationColor: root.fill
  }
}
