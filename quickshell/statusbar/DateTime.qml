pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root 

  property bool showDate: false
  readonly property string date: {
    Qt.formatDateTime(clock.date, "dd MMMM yyyy")
  }
  readonly property string time: {
    Qt.formatDateTime(clock.date, "dddd hh:mm")
  }

  function toggleDate() {
    showDate = !showDate
  }

  SystemClock {
    id: clock
  }
}
