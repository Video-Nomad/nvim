---@type vim.lsp.Config
return {
  settings = {
    python = {
      pyrefly = {
        diagnosticMode = "workspace",
        typeCheckingMode = "strict",
      },
    },
  },
}

--[[
→ pyrefly.commentFoldingRanges             default: false
→ pyrefly.lspArguments                     default: ["lsp"]
→ pyrefly.lspPath                          default: ""
→ pyrefly.trace.server                     default: "off"
→ python.analysis.completeFunctionParens   default: false
→ python.analysis.showHoverGoToLinks       default: true
→ python.pyrefly.configPath                default: ""
→ python.pyrefly.diagnosticMode            default: "openFilesOnly"
→ python.pyrefly.disableLanguageServices   default: false
→ python.pyrefly.disableTypeErrors         default: false
→ python.pyrefly.disabledLanguageServices
→ python.pyrefly.displayTypeErrors         default: "default"
→ python.pyrefly.runnableCodeLens          default: false
→ python.pyrefly.streamDiagnostics         default: true
→ python.pyrefly.syncNotebooks             default: true
→ python.pyrefly.typeCheckingMode          default: "auto"
]]
--
