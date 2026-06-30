import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "./tray"

Scope {
  id: root 

  Variants {
    model: Quickshell.screens

    delegate: Component {
      PanelWindow {
        required property var modelData
        screen: modelData
        
        id: statusBar
        color: "#FCFB00"
        implicitHeight: 31

        anchors {
          top: true
          left: true
          right: true
        }

        RowLayout {
          id: workspaces
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.leftMargin: 8
          spacing: 5
          
          Button {
            label: "1"
          }
          Button {
            label: "2"
          }
          Button {
            label: "3"
          }
          Button {
            label: "4"
          }
          Button {
            label: "5"
          }
        }


        RowLayout {
          id: datatime
          anchors.centerIn: parent

          Text {
            id: time
            verticalAlignment: Text.AlignVCenter
            text: DateTime.showDate ? DateTime.date : DateTime.time

            MouseArea {
              anchors.fill: parent
              cursorShape: Qt.PointingHandCursor
              onClicked: DateTime.toggleDate()
            }
          }
        }

        RowLayout {
          id: icons
          spacing: 5
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          anchors.rightMargin: 8

          Ethernet { }
          Volume { }
          CPU { }
        }
      }
    }
  }
}
