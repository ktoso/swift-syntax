add_swift_syntax_library(SwiftSyntaxMacroExpansion
  BasicMacroExpansionContext.swift
  FunctionParameterUtils.swift
  IndentationUtils.swift
  MacroExpansion.swift
  MacroExpansionDiagnosticMessages.swift
  MacroReplacement.swift
  MacroSystem.swift
)

target_link_swift_syntax_libraries(SwiftSyntaxMacroExpansion PUBLIC
  SwiftBasicFormat
  SwiftDiagnostics
  SwiftOperators
  SwiftSyntax
  SwiftSyntaxBuilder
  SwiftSyntaxMacros
)
