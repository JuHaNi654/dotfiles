pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Io
import "../styles"
import "./popup"

Item {
  id: root
  implicitWidth: btnLoader.implicitWidth

  property string iface: ""
  property bool wiredConnected: false
  property bool isHover: false
  property color fg: isHover ? Style.color4 : Style.color1
  Behavior on fg {
    ColorAnimation {
      duration: 150
    }
  }

  Process {
    id: findIface
    command: ["bash", "-c", "ip -j route show default | jq -r '.[0].dev'"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        root.iface = text.trim();
      }
    }
  }

  FileView {
    id: operstateFile
    path: root.iface ? "/sys/class/net/" + root.iface + "/operstate" : ""
    watchChanges: true
    onFileChanged: reload()
    onLoaded: {
      root.wiredConnected = text().trim() === "up";
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
        filePath: "icons/wired.svg"
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
        onClicked: Quickshell.execDetached(["bash", "-c", "omarchy-launch-wifi"])
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

      implicitWidth: label.implicitWidth * 1.75
      implicitHeight: label.implicitHeight * 2
      color: "transparent"

      PopupBorder {
        color: Style.color0
        borderColor: Style.color1
      }

      Text {
        id: label
        anchors.centerIn: parent
        text: root.wiredConnected ? "Connected" : "Disconnected"
        color: Style.color7
        font.family: Style.fontFamily
        topPadding: 4
        font.pixelSize: 16
      }
    }
  }

  Loader {
    id: btnLoader
    sourceComponent: button
    anchors.centerIn: parent
  }
}
