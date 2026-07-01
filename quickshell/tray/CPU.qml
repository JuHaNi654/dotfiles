pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Controls
import "../styles"

Item {
  id: root
  implicitWidth: btnLoader.implicitWidth

  property bool isHover: false
  property color fg: isHover ? Style.blue : Style.red
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
        filePath: "icons/memory.svg"
        fill: root.fg
      }

      background: IconBackground {
        borderColor: root.fg
      }

      MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: root.isHover = true
        onExited: root.isHover = false
        onClicked: Quickshell.execDetached(["bash", "-c", "omarchy-launch-or-focus-tui btop"])
      }
    }
  }

  LazyLoader {
    active: root.isHover

    PopupWindow {
      id: popup
      visible: root.isHover

      anchor.item: root
      anchor.edges: Edges.Bottom    // qmllint disable missing-type
      anchor.gravity: Edges.Bottom  // qmllint disable missing-type

      implicitWidth: 250
      implicitHeight: 100
      color: "#2e2e2e"

      Cores {
        isRunning: root.isHover
        anchors.centerIn: parent
      }
    }
  }

  Loader {
    id: btnLoader
    sourceComponent: button
    anchors.centerIn: parent
  }
}
