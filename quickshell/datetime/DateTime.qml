pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property string date: {
    Qt.formatDateTime(clock.date, "dd MMMM yyyy");
  }
  readonly property string time: {
    Qt.formatDateTime(clock.date, "dddd hh:mm");
  }

  SystemClock {
    id: clock
  }
}
