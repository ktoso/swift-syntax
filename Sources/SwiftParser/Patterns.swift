//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(RawSyntax) import SwiftSyntax

extension Parser {
  /// Parse a pattern.
  mutating func parsePattern() -> RawPatternSyntax {
    enum ExpectedTokens: TokenSpecSet {
      case leftParen
      case wildcard
      case identifier
      case dollarIdentifier  // For recovery
      case `let`
      case `var`
      case `inout`

      init?(lexeme: Lexer.Lexeme) {
        switch PrepareForKeywordMatch(lexeme) {
        case TokenSpec(.leftParen): self = .leftParen
        case TokenSpec(.wildcard): self = .wildcard
        case TokenSpec(.identifier): self = .identifier
        case TokenSpec(.dollarIdentifier): self = .dollarIdentifier
        case TokenSpec(.let): self = .let
        case TokenSpec(.var): self = .var
        case TokenSpec(.inout): self = .inout
        default: return nil
        }
      }

      var spec: TokenSpec {
        switch self {
        case .leftParen: return .leftParen
        case .wildcard: return .wildcard
        case .identifier: return .identifier
        case .dollarIdentifier: return .dollarIdentifier
        case .let: return .keyword(.let)
        case .var: return .keyword(.var)
        case .inout: return .keyword(.inout)
        }
      }
    }

    switch self.at(anyIn: ExpectedTokens.self) {
    case (.leftParen, let handle)?:
      let lparen = self.eat(handle)
      let elements = self.parsePatternTupleElements()
      let (unexpectedBeforeRParen, rparen) = self.expect(.rightParen)
      return RawPatternSyntax(
        RawTuplePatternSyntax(
          leftParen: lparen,
          elements: elements,
          unexpectedBeforeRParen,
          rightParen: rparen,
          arena: self.arena
        )
      )
    case (.wildcard, let handle)?:
      let wildcard = self.eat(handle)
      return RawPatternSyntax(
        RawWildcardPatternSyntax(
          wildcard: wildcard,
          typeAnnotation: nil,
          arena: self.arena
        )
      )
    case (.identifier, let handle)?:
      let identifier = self.eat(handle)
      return RawPatternSyntax(
        RawIdentifierPatternSyntax(
          identifier: identifier,
          arena: self.arena
        )
      )
    case (.dollarIdentifier, let handle)?:
      let dollarIdent = self.eat(handle)
      let unexpectedBeforeIdentifier = RawUnexpectedNodesSyntax(elements: [RawSyntax(dollarIdent)], arena: self.arena)
      return RawPatternSyntax(
        RawIdentifierPatternSyntax(
          unexpectedBeforeIdentifier,
          identifier: missingToken(.identifier),
          arena: self.arena
        )
      )
    case (.let, let handle)?,
      (.var, let handle)?,
      (.inout, let handle)?:
      let bindingSpecifier = self.eat(handle)
      let value = self.parsePattern()
      return RawPatternSyntax(
        RawValueBindingPatternSyntax(
          bindingSpecifier: bindingSpecifier,
          pattern: value,
          arena: self.arena
        )
      )
    case nil:
      if self.currentToken.isLexerClassifiedKeyword, !self.atStartOfLine {
        // Recover if a keyword was used instead of an identifier
        let keyword = self.consumeAnyToken()
        return RawPatternSyntax(
          RawIdentifierPatternSyntax(
            RawUnexpectedNodesSyntax([keyword], arena: self.arena),
            identifier: missingToken(.identifier),
            arena: self.arena
          )
        )
      } else {
        return RawPatternSyntax(RawMissingPatternSyntax(arena: self.arena))
      }
    }
  }

  /// Parse a typed pattern.
  mutating func parseTypedPattern(allowRecoveryFromMissingColon: Bool = true) -> (RawPatternSyntax, RawTypeAnnotationSyntax?) {
    let pattern = self.parsePattern()

    // Now parse an optional type annotation.
    let colon = self.consume(if: .colon)
    var lookahead = self.lookahead()
    var type: RawTypeAnnotationSyntax?
    if let colon {
      let result = self.parseResultType()
      type = RawTypeAnnotationSyntax(
        colon: colon,
        type: result,
        arena: self.arena
      )
    } else if allowRecoveryFromMissingColon
      && !self.atStartOfLine
      && lookahead.canParseType()
    {
      let (unexpectedBeforeColon, colon) = self.expect(.colon)
      let result = self.parseType()

      type = RawTypeAnnotationSyntax(
        unexpectedBeforeColon,
        colon: colon,
        type: result,
        arena: self.arena
      )
    }

    return (pattern, type)
  }

  /// Parse the elements of a tuple pattern.
  mutating func parsePatternTupleElements() -> RawTuplePatternElementListSyntax {
    if let remainingTokens = remainingTokensIfMaximumNestingLevelReached() {
      return RawTuplePatternElementListSyntax(
        elements: [
          RawTuplePatternElementSyntax(
            remainingTokens,
            label: nil,
            colon: nil,
            pattern: RawPatternSyntax(RawMissingPatternSyntax(arena: self.arena)),
            trailingComma: nil,
            arena: self.arena
          )
        ],
        arena: self.arena
      )
    }
    var elements = [RawTuplePatternElementSyntax]()
    do {
      var keepGoing = true
      var loopProgress = LoopProgressCondition()
      while !self.at(.endOfFile, .rightParen) && keepGoing && self.hasProgressed(&loopProgress) {
        // If the tuple element has a label, parse it.
        let labelAndColon = self.consume(if: .identifier, followedBy: .colon)
        var (label, colon) = (labelAndColon?.0, labelAndColon?.1)

        /// If we have something like `x SomeType`, use the indication that `SomeType` starts with a capital letter (and is thus probably a type name)
        /// as an indication that the user forgot to write the colon instead of forgetting to write the comma to separate two elements.
        if label == nil, colon == nil, self.at(.identifier), peek(isAt: .identifier), peek().tokenText.isStartingWithUppercase {
          label = consume(if: .identifier)
          colon = self.missingToken(.colon)
        }

        let pattern = self.parsePattern()
        var trailingComma = self.consume(if: .comma)

        if trailingComma == nil && self.at(TokenSpec(.identifier, allowAtStartOfLine: false)) {
          trailingComma = self.missingToken(RawTokenKind.comma)
        }

        keepGoing = trailingComma != nil
        elements.append(
          RawTuplePatternElementSyntax(
            label: label,
            colon: colon,
            pattern: pattern,
            trailingComma: trailingComma,
            arena: self.arena
          )
        )
      }
    }
    return RawTuplePatternElementListSyntax(elements: elements, arena: self.arena)
  }
}

extension Parser {
  /// Parse a pattern that appears immediately under syntax for conditionals like
  /// for-in loops and guard clauses.
  mutating func parseMatchingPattern(context: PatternContext) -> RawPatternSyntax {
    // Parse productions that can only be patterns.
    switch self.at(anyIn: MatchingPatternStart.self) {
    case (.var, let handle)?,
      (.let, let handle)?,
      (.inout, let handle)?:
      let bindingSpecifier = self.eat(handle)
      let value = self.parseMatchingPattern(context: .bindingIntroducer)
      return RawPatternSyntax(
        RawValueBindingPatternSyntax(
          bindingSpecifier: bindingSpecifier,
          pattern: value,
          arena: self.arena
        )
      )
    case (.is, let handle)?:
      let isKeyword = self.eat(handle)
      let type = self.parseType()
      return RawPatternSyntax(
        RawIsTypePatternSyntax(
          isKeyword: isKeyword,
          type: type,
          arena: self.arena
        )
      )
    case nil:
      // matching-pattern ::= expr
      // Fall back to expression parsing for ambiguous forms. Name lookup will
      // disambiguate.
      let patternSyntax = self.parseSequenceExpression(.basic, pattern: context)
      if let pat = patternSyntax.as(RawPatternExprSyntax.self) {
        // The most common case here is to parse something that was a lexically
        // obvious pattern, which will come back wrapped in an immediate
        // RawUnresolvedPatternExprSyntax.
        //
        // FIXME: This is pretty gross. Let's find a way to disambiguate let
        // binding patterns much earlier.
        return RawPatternSyntax(pat.pattern)
      }
      let expr = RawExprSyntax(patternSyntax)
      return RawPatternSyntax(RawExprPatternSyntax(expression: expr, arena: self.arena))
    }
  }
}

// MARK: Lookahead

extension Parser.Lookahead {
  ///   pattern ::= identifier
  ///   pattern ::= '_'
  ///   pattern ::= pattern-tuple
  ///   pattern ::= 'var' pattern
  ///   pattern ::= 'let' pattern
  ///   pattern ::= 'inout' pattern
  mutating func canParsePattern() -> Bool {
    enum PatternStartTokens: TokenSpecSet {
      case identifier
      case wildcard
      case `let`
      case `var`
      case leftParen
      case `inout`

      init?(lexeme: Lexer.Lexeme) {
        switch PrepareForKeywordMatch(lexeme) {
        case TokenSpec(.identifier): self = .identifier
        case TokenSpec(.wildcard): self = .wildcard
        case TokenSpec(.let): self = .let
        case TokenSpec(.var): self = .var
        case TokenSpec(.leftParen): self = .leftParen
        case TokenSpec(.inout): self = .inout
        default: return nil
        }
      }

      var spec: TokenSpec {
        switch self {
        case .identifier: return .identifier
        case .wildcard: return .wildcard
        case .let: return .keyword(.let)
        case .var: return .keyword(.var)
        case .leftParen: return .leftParen
        case .inout: return .keyword(.inout)
        }
      }
    }

    switch self.at(anyIn: PatternStartTokens.self) {
    case (.identifier, let handle)?,
      (.wildcard, let handle)?:
      self.eat(handle)
      return true
    case (.let, let handle)?,
      (.var, let handle)?,
      (.inout, let handle)?:
      self.eat(handle)
      return self.canParsePattern()
    case (.leftParen, _)?:
      return self.canParsePatternTuple()
    case nil:
      return false
    }
  }

  private mutating func canParsePatternTuple() -> Bool {
    guard self.consume(if: .leftParen) != nil else {
      return false
    }

    if !self.at(.rightParen) {
      var loopProgress = LoopProgressCondition()
      repeat {
        guard self.canParsePattern() else {
          return false
        }
      } while self.consume(if: .comma) != nil && self.hasProgressed(&loopProgress)
    }

    return self.consume(if: .rightParen) != nil
  }

  /// Determine whether we are at the start of a parameter name when
  /// parsing a parameter.
  /// If `allowMisplacedSpecifierRecovery` is `true`, then this will skip over any type
  /// specifiers before checking whether this lookahead starts a parameter name.
  mutating func startsParameterName(isClosure: Bool, allowMisplacedSpecifierRecovery: Bool) -> Bool {
    if allowMisplacedSpecifierRecovery {
      while canHaveParameterSpecifier,
        self.consume(ifAnyIn: TypeSpecifier.self) != nil
      {}
    }

    // To have a parameter name here, we need a name.
    guard self.atArgumentLabel(allowDollarIdentifier: true) else {
      return false
    }

    // If the next token is ':', this is a name.
    let nextTok = self.peek()
    if nextTok.rawTokenKind == .colon {
      return true
    }

    // If the next token can be an argument label, we might have a name.
    if nextTok.isArgumentLabel(allowDollarIdentifier: true) {
      // If the first name wasn't a contextual keyword, we're done.
      if !self.at(.keyword(.isolated))
        && !self.at(.keyword(.some))
        && !self.at(.keyword(.any))
        && !self.at(.keyword(.each))
        && !self.at(.keyword(.repeat))
        && !self.at(.keyword(.__shared))
        && !self.at(.keyword(.__owned))
        && !self.at(.keyword(.borrowing))
        && !self.at(.keyword(.consuming))
      {
        return true
      }

      // Parameter specifiers can be an argument label, but it's also a contextual keyword,
      // so look ahead one more token (two total) see if we have a ':' that would
      // indicate that this is an argument label.
      do {
        if self.at(.colon) {
          return true  // isolated :
        }
        self.consumeAnyToken()
        return self.atArgumentLabel(allowDollarIdentifier: true) && self.peek().rawTokenKind == .colon
      }
    }

    if nextTok.rawTokenKind == .postfixQuestionMark || nextTok.rawTokenKind == .exclamationMark {
      return false
    }

    // The identifier could be a name or it could be a type. In a closure, we
    // assume it's a name, because the type can be inferred. Elsewhere, we
    // assume it's a type.
    return isClosure
  }
}
