import Quickshell
import QtQuick
import QtQuick.Layouts
import "./tray"
import "./datetime"
import "./workspaceControls/"
import "./styles"

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    delegate: Component {
      PanelWindow {
        id: statusBar
        required property var modelData
        screen: modelData
        color: Style.color3
        implicitHeight: 31

        anchors {
          top: true
          left: true
          right: true
        }

        Workspace {}

        RowLayout {
          id: datatime
          anchors.centerIn: parent

          Text {
            id: time
            property bool showDate: false
            verticalAlignment: Text.AlignVCenter
            text: showDate ? DateTime.date : DateTime.time
            font.family: Style.fontFamily
            font.pixelSize: 14
            topPadding: 2

            MouseArea {
              anchors.fill: parent
              cursorShape: Qt.PointingHandCursor
              onClicked: time.toggleDate()
            }

            function toggleDate() {
              showDate = !showDate;
            }
          }
        }

        RowLayout {
          id: icons
          Layout.fillHeight: true
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          anchors.rightMargin: 8

          SystemTray {
            implicitHeight: 32
          }

          Ethernet {
            implicitHeight: 32
          }
          Volume {
            implicitHeight: 32
          }
          CPU {
            implicitHeight: 32
          }
        }
      }
    }
  }
}
