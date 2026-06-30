import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

RowLayout {
  id: tray
  anchors.centerIn: parent
  spacing: 6

  Repeater {
    model: SystemTray.items

    delegate: Item {
      id: trayIcon
      required property SystemTrayItem modelData

      width: 24
      height: 30

      IconImage {
        anchors.centerIn: parent
        implicitSize: 18
        source: trayIcon.modelData.icon
      }

      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor

        onClicked: mouse => {
          if (mouse.button === Qt.RightButton && trayIcon.modelData.hasMenu) {
            menuAnchor.open()
          } else {
            tooltipPopup.visible = !tooltipPopup.visible
          }
        }
      }

      // right-click context menu, using the app's own DBus menu
      QsMenuAnchor {
        id: menuAnchor
        menu: trayIcon.modelData.menu
        anchor.item: trayIcon
        anchor.edges: Edges.Bottom
      }

      // left-click "tooltip" popup
      PopupWindow {
        id: tooltipPopup
        visible: false

        anchor.item: trayIcon
        anchor.edges: Edges.Bottom
        anchor.gravity: Edges.Bottom

        implicitWidth: 240
        implicitHeight: content.implicitHeight + 16
        color: "transparent"

        Rectangle {
          anchors.fill: parent
          radius: 8
          color: "#2e2e2e"
          border.color: "#555"

          Column {
            id: content
            anchors.fill: parent
            anchors.margins: 8
            spacing: 2

            Text {
              text: trayIcon.modelData.tooltipTitle || trayIcon.modelData.title
              color: "white"
              font.bold: true
            }
            Text {
              text: trayIcon.modelData.tooltipDescription
              color: "#cccccc"
              wrapMode: Text.WordWrap
              width: parent.width
              visible: text.length > 0
            }
          }
        }
      }
    }
  }
}
