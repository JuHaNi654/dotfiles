import Quickshell
import QtQuick
import QtQuick.Layouts
import "./tray"
import "./datetime"
import "./workspaceControls/"

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    delegate: Component {
      PanelWindow {
        id: statusBar
        required property var modelData
        screen: modelData
        color: "#FCFB00"
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
