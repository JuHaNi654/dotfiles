pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
  id: root
  anchors.verticalCenter: parent.verticalCenter
  anchors.left: parent.left
  anchors.leftMargin: 8
  spacing: 5

  property string current: "1"

  Component.onCompleted: {
    if (Hyprland.focusedWorkspace?.name) {
      Hyprland.focusedWorkspace?.name;
    }
  }

  Connections {
    target: Hyprland
    function onFocusedWorkspaceChanged() {
      root.current = Hyprland.focusedWorkspace?.name;
    }
  }

  Repeater {
    model: 5

    delegate: Button {
      id: btn
      required property int index
      label: (index + 1)
      workspace: (index + 1)
      workspaceActive: String(index + 1) == root.current
    }
  }
}
