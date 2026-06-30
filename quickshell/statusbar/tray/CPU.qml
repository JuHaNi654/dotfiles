import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Shapes
import QtQuick.Controls
import Quickshell.Io

Item {
  id: cpu
  
  property int w: 16
  property int h: 32
  property color color_1: "#13141b"
  property color color_2: "#ff3b48"
  property color color_3: "#34ffa6"

  property bool isHover: false 
  property color textColor: isHover ? cpu.color_3 : cpu.color_2
  Behavior on textColor { ColorAnimation { duration: 150 } }

  implicitWidth: cpu.w
  implicitHeight: cpu.h

  Component {
    id: button

    Button {
      implicitWidth: cpu.w
      implicitHeight: cpu.h


      Text {
        anchors.centerIn: parent
        text: "󰍛"
        font.pixelSize: 16
        color: cpu.textColor
      }

      background: Rectangle {
        color: "transparent"
      }


      MouseArea {
        anchors.fill: parent
        hoverEnabled: true 
        cursorShape: Qt.PointingHandCursor
        onEntered: cpu.isHover = true 
        onExited: cpu.isHover = false
        //onClicked: Quickshell.execDetached(["bash", "-c", "omarchy-launch-or-focus-tui btop"])
      }

    }
  }

  PopupWindow {
    id: popup
    visible: cpu.isHover

    anchor.item: cpu
    anchor.edges: Edges.Bottom
    anchor.gravity: Edges.Bottom

    implicitWidth: 250
    implicitHeight: 100
    color: "#2e2e2e"

    Cores { 
      isRunning: cpu.isHover
      anchors.centerIn: parent
    }
  }

  Loader { sourceComponent: button }
}

