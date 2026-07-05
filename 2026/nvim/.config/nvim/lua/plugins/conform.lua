return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      qml = { "qmlformat" },
    },
    formatters = {
      qmlformat = {
        command = "/usr/lib/qt6/bin/qmlformat",
        prepend_args = { "-w", "2" },
      },
    },
  },
}
