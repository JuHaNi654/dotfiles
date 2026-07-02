pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Services.Pipewire
import "../styles"
import "./popup"

Item {
  id: root
  implicitWidth: btnLoader.implicitWidth

  property bool isHover: false
  property color fg: isHover ? Style.color4 : Style.color1
  Behavior on fg {
    ColorAnimation {
      duration: 150
    }
  }

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  Connections {
    target: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio : null
  }

  Component {
    id: button

    Button {
      implicitWidth: Style.buttonW
      implicitHeight: Style.buttonH

      CustomIcon {
        id: iconElem
        anchors.centerIn: parent
        filePath: "icons/headphones.svg"
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
        onClicked: Quickshell.execDetached(["bash", "-c", "omarchy-launch-audio"])
        onWheel: wheel => {
          const sink = Pipewire.defaultAudioSink;
          if (!sink?.audio)
            return;

          const step = 0.05;
          const delta = wheel.angleDelta.y > 0 ? step : -step;
          sink.audio.volume = Math.max(0, Math.min(1, sink.audio.volume + delta));
          wheel.accepted = true;
        }
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

      implicitWidth: label.implicitWidth * 1.6
      implicitHeight: label.implicitHeight * 2
      color: "transparent"

      PopupBorder {
        color: Style.color0
        borderColor: Style.color1
      }

      Text {
        id: label
        anchors.centerIn: parent
        text: "Playing at " + Math.round(Pipewire.defaultAudioSink?.audio.volume * 100) + "%"
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
