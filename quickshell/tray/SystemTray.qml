pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import QtQuick.Effects
import Quickshell.Widgets
import "../styles"
import "./popup"

Item {
  id: root
  implicitWidth: btnLoader.implicitWidth

  property bool isActive: false
  property bool isHover: false
  property color fg: (isActive || isHover) ? Style.color4 : Style.color1
  Behavior on fg {
    ColorAnimation {
      duration: 150
    }
  }

  Component {
    id: button

    Button {
      implicitWidth: Style.buttonW
      implicitHeight: Style.buttonH

      CustomIcon {
        id: iconElem
        anchors.centerIn: parent
        filePath: "icons/arrow_down.svg"
        fill: root.fg
      }

      background: IconBackground {
        borderColor: root.fg
      }

      MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        scrollGestureEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: root.isHover = true
        onExited: root.isHover = false
        onClicked: root.isActive = !root.isActive
      }
    }
  }

  function setSize(size: int, spacing: int): int {
    return (size > 0) ? size + spacing : 150;
  }

  LazyLoader {
    active: root.isActive

    PopupWindow {
      id: popup
      visible: root.isActive

      anchor.item: root
      anchor.edges: Edges.Bottom    // qmllint disable missing-type
      anchor.gravity: Edges.Bottom  // qmllint disable missing-type

      implicitWidth: root.setSize(systemTray.implicitWidth, 32)
      implicitHeight: root.setSize(systemTray.implicitHeight, 16)
      color: "transparent"

      PopupBorder {
        color: Style.color0
        borderColor: Style.color1
      }

      GridLayout {
        id: systemTray
        anchors.centerIn: parent
        columns: 4
        columnSpacing: 5

        Repeater {
          model: SystemTray.items

          delegate: Rectangle {
            id: trayIcon
            required property SystemTrayItem modelData
            color: "transparent"

            width: 30
            height: 30

            IconImage {
              id: iconElem
              anchors.centerIn: parent
              implicitSize: 18
              source: trayIcon.modelData.icon
            }

            MultiEffect {
              anchors.fill: iconElem
              source: iconElem
              colorization: 1.0
              colorizationColor: Style.color4
            }
          }
        }
      }
    }
  }

  Loader {
    id: btnLoader
    sourceComponent: button
    anchors.centerIn: parent
  }
}
