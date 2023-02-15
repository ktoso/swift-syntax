//// Automatically Generated From AttributeKinds.swift.gyb.
//// Do Not Edit Directly!
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

public class Attribute {
  public let name: String
  public let swiftName: String

  public init(name: String, swiftName: String? = nil) {
    self.name = name
    self.swiftName = swiftName ?? name
  }
}

public class TypeAttribute: Attribute {
  public init(name: String) {
    super.init(name: name)
  }
}

public class DeclAttribute: Attribute {
  public let className: String
  public let options: [String]
  public let code: Int

  public convenience init(name: String, className: String, options: String..., code: Int, swiftName: String? = nil) {
    self.init(name: name, className: className, options: options, code: code, swiftName: swiftName)
  }

  public init(name: String, className: String, options: [String], code: Int, swiftName: String? = nil) {
    self.className = className
    self.options = options
    self.code = code
    super.init(name: name, swiftName: swiftName)
  }
}

public class SimpleDeclAttribute: DeclAttribute {}

public class ContextualDeclAttribute: DeclAttribute {
  public init(name: String, className: String, options: String..., code: Int) {
    super.init(name: name, className: className, options: options, code: code)
  }
}

public class ContextualSimpleDeclAttribute: SimpleDeclAttribute {
  public init(name: String, className: String, options: String..., code: Int) {
    super.init(name: name, className: className, options: options, code: code)
  }
}

public class DeclAttributeAlias: Attribute {
  public let className: String

  public init(name: String, className: String, swiftName: String? = nil) {
    self.className = className
    super.init(name: name, swiftName: swiftName)

  }
}

public class ContextualDeclAttributeAlias: DeclAttributeAlias {}

public class BuiltinDeclModifier: Attribute {}

// Type attributes
public let TYPE_ATTR_KINDS = [
  TypeAttribute(name: "autoclosure"),
  TypeAttribute(name: "convention"),
  TypeAttribute(name: "noescape"),
  TypeAttribute(name: "escaping"),
  TypeAttribute(name: "differentiable"),
  TypeAttribute(name: "noDerivative"),
  TypeAttribute(name: "async"),
  TypeAttribute(name: "Sendable"),
  TypeAttribute(name: "unchecked"),
  TypeAttribute(name: "_local"),
  TypeAttribute(name: "_noMetadata"),
  TypeAttribute(name: "_opaqueReturnTypeOf"),
]

// Schema for `DeclAttribute`s:
//
// - Attribute name.
// - C++ class name without the 'Attr' suffix
// - Options for the attribute, including:
//    * the declarations the attribute can appear on
//    * whether duplicates are allowed
// - Unique attribute identifier used for serialization. This
//   can never be changed.
//
// SimpleDeclAttribute is the same, but the class becomes
// SimpleDeclAttr<DAK_##NAME> on the C++ side.
//
// Please help ease code review/audits:
// - Please place the "OnXYZ" flags together on the next line.
// - Please place the non-OnXYZ flags together on the next to last line.
// - Please place the unique code number on the last line.
// - Please sort attributes by serialization number.
// - Please create a "NOTE" comment if a unique number is skipped.
//
// If you're adding a new kind of "attribute" that is spelled without a leading
// '@' symbol, add an entry to the `DECL_MODIFIER_KINDS` array instead.
//
// If you're adding a new underscored attribute here, please document it in
// docs/ReferenceGuides/UnderscoredAttributes.md.
public let DECL_ATTR_KINDS: [Attribute] = [
  DeclAttribute(
    name: "_silgen_name",
    className: "SILGenName",
    options:
      "OnAbstractFunction",
    "LongAttribute",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 0,
    swiftName: "_silgen_name"
  ),
  DeclAttribute(
    name: "available",
    className: "Available",
    options:
      "OnAbstractFunction",
    "OnGenericType",
    "OnVar",
    "OnSubscript",
    "OnEnumElement",
    "OnMacro",
    "OnExtension",
    "AllowMultipleAttributes",
    "LongAttribute",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 1,
    swiftName: "available"
  ),
  DeclAttribute(
    name: "objc",
    className: "ObjC",
    options:
      "OnAbstractFunction",
    "OnClass",
    "OnProtocol",
    "OnExtension",
    "OnVar",
    "OnSubscript",
    "OnEnum",
    "OnEnumElement",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 3,
    swiftName: "objc"
  ),
  SimpleDeclAttribute(
    name: "dynamicCallable",
    className: "DynamicCallable",
    options:
      "OnNominalType",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 6,
    swiftName: "dynamicCallable"
  ),
  DeclAttribute(
    name: "main",
    className: "MainType",
    options:
      "OnClass",
    "OnStruct",
    "OnEnum",
    "OnExtension",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 7,
    swiftName: "main"
  ),
  SimpleDeclAttribute(
    name: "_exported",
    className: "Exported",
    options:
      "OnImport",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 8,
    swiftName: "_exported"
  ),
  SimpleDeclAttribute(
    name: "dynamicMemberLookup",
    className: "DynamicMemberLookup",
    options:
      "OnNominalType",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 9,
    swiftName: "dynamicMemberLookup"
  ),
  SimpleDeclAttribute(
    name: "NSCopying",
    className: "NSCopying",
    options:
      "OnVar",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 10,
    swiftName: "NSCopying"
  ),
  SimpleDeclAttribute(
    name: "IBAction",
    className: "IBAction",
    options:
      "OnFunc",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 11,
    swiftName: "IBAction"
  ),
  SimpleDeclAttribute(
    name: "IBDesignable",
    className: "IBDesignable",
    options:
      "OnClass",
    "OnExtension",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 12,
    swiftName: "IBDesignable"
  ),
  SimpleDeclAttribute(
    name: "IBInspectable",
    className: "IBInspectable",
    options:
      "OnVar",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 13,
    swiftName: "IBInspectable"
  ),
  SimpleDeclAttribute(
    name: "IBOutlet",
    className: "IBOutlet",
    options:
      "OnVar",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 14,
    swiftName: "IBOutlet"
  ),
  SimpleDeclAttribute(
    name: "NSManaged",
    className: "NSManaged",
    options:
      "OnVar",
    "OnFunc",
    "OnAccessor",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 15,
    swiftName: "NSManaged"
  ),
  SimpleDeclAttribute(
    name: "LLDBDebuggerFunction",
    className: "LLDBDebuggerFunction",
    options:
      "OnFunc",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 17,
    swiftName: "LLDBDebuggerFunction"
  ),
  SimpleDeclAttribute(
    name: "UIApplicationMain",
    className: "UIApplicationMain",
    options:
      "OnClass",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 18,
    swiftName: "UIApplicationMain"
  ),
  SimpleDeclAttribute(
    name: "unsafe_no_objc_tagged_pointer",
    className: "UnsafeNoObjCTaggedPointer",
    options:
      "OnProtocol",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 19,
    swiftName: "unsafe_no_objc_tagged_pointer"
  ),
  DeclAttribute(
    name: "inline",
    className: "Inline",
    options:
      "OnVar",
    "OnSubscript",
    "OnAbstractFunction",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 20,
    swiftName: "inline"
  ),
  DeclAttribute(
    name: "_semantics",
    className: "Semantics",
    options:
      "OnAbstractFunction",
    "OnSubscript",
    "OnNominalType",
    "OnVar",
    "AllowMultipleAttributes",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 21,
    swiftName: "_semantics"
  ),
  SimpleDeclAttribute(
    name: "_transparent",
    className: "Transparent",
    options:
      "OnFunc",
    "OnAccessor",
    "OnConstructor",
    "OnVar",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 26,
    swiftName: "_transparent"
  ),
  SimpleDeclAttribute(
    name: "requires_stored_property_inits",
    className: "RequiresStoredPropertyInits",
    options:
      "OnClass",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 27,
    swiftName: "requires_stored_property_inits"
  ),
  SimpleDeclAttribute(
    name: "nonobjc",
    className: "NonObjC",
    options:
      "OnExtension",
    "OnFunc",
    "OnAccessor",
    "OnVar",
    "OnSubscript",
    "OnConstructor",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 30,
    swiftName: "nonobjc"
  ),
  SimpleDeclAttribute(
    name: "_fixed_layout",
    className: "FixedLayout",
    options:
      "OnVar",
    "OnClass",
    "OnStruct",
    "OnProtocol",
    "UserInaccessible",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 31,
    swiftName: "_fixed_layout"
  ),
  SimpleDeclAttribute(
    name: "inlinable",
    className: "Inlinable",
    options:
      "OnVar",
    "OnSubscript",
    "OnAbstractFunction",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 32,
    swiftName: "inlinable"
  ),
  DeclAttribute(
    name: "_specialize",
    className: "Specialize",
    options:
      "OnConstructor",
    "OnFunc",
    "OnAccessor",
    "AllowMultipleAttributes",
    "LongAttribute",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 33,
    swiftName: "_specialize"
  ),
  SimpleDeclAttribute(
    name: "objcMembers",
    className: "ObjCMembers",
    options:
      "OnClass",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 34,
    swiftName: "objcMembers"
  ),
  ContextualSimpleDeclAttribute(
    name: "_compilerInitialized",
    className: "CompilerInitialized",
    options:
      "OnVar",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 35
  ),
  SimpleDeclAttribute(
    name: "_hasStorage",
    className: "HasStorage",
    options:
      "OnVar",
    "UserInaccessible",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 45,
    swiftName: "_hasStorage"
  ),
  DeclAttribute(
    name: "__raw_doc_comment",
    className: "RawDocComment",
    options:
      "OnAnyDecl",
    "UserInaccessible",
    "RejectByParser",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 48,
    swiftName: "__raw_doc_comment"
  ),
  DeclAttribute(
    name: "_effects",
    className: "Effects",
    options:
      "OnAbstractFunction",
    "AllowMultipleAttributes",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 50,
    swiftName: "_effects"
  ),
  DeclAttribute(
    name: "__objc_bridged",
    className: "ObjCBridged",
    options:
      "OnClass",
    "UserInaccessible",
    "RejectByParser",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 51,
    swiftName: "__objc_bridged"
  ),
  SimpleDeclAttribute(
    name: "NSApplicationMain",
    className: "NSApplicationMain",
    options:
      "OnClass",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 52,
    swiftName: "NSApplicationMain"
  ),
  SimpleDeclAttribute(
    name: "_objc_non_lazy_realization",
    className: "ObjCNonLazyRealization",
    options:
      "OnClass",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 53,
    swiftName: "_objc_non_lazy_realization"
  ),
  DeclAttribute(
    name: "__synthesized_protocol",
    className: "SynthesizedProtocol",
    options:
      "OnConcreteNominalType",
    "UserInaccessible",
    "RejectByParser",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 54,
    swiftName: "__synthesized_protocol"
  ),
  SimpleDeclAttribute(
    name: "testable",
    className: "Testable",
    options:
      "OnImport",
    "UserInaccessible",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 55,
    swiftName: "testable"
  ),
  DeclAttribute(
    name: "_alignment",
    className: "Alignment",
    options:
      "OnStruct",
    "OnEnum",
    "UserInaccessible",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 56,
    swiftName: "_alignment"
  ),
  SimpleDeclAttribute(
    name: "rethrows",
    className: "AtRethrows",
    options:
      "OnProtocol",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 58,
    swiftName: "atRethrows"
  ),
  DeclAttribute(
    name: "_swift_native_objc_runtime_base",
    className: "SwiftNativeObjCRuntimeBase",
    options:
      "OnClass",
    "UserInaccessible",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 59,
    swiftName: "_swift_native_objc_runtime_base"
  ),
  SimpleDeclAttribute(
    name: "warn_unqualified_access",
    className: "WarnUnqualifiedAccess",
    options:
      "OnFunc",
    "OnAccessor",
    "LongAttribute",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    // "OnVar",
    code: 61,
    swiftName: "warn_unqualified_access"
  ),
  SimpleDeclAttribute(
    name: "_show_in_interface",
    className: "ShowInInterface",
    options:
      "OnProtocol",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 62,
    swiftName: "_show_in_interface"
  ),
  DeclAttribute(
    name: "_cdecl",
    className: "CDecl",
    options:
      "OnFunc",
    "OnAccessor",
    "LongAttribute",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 63,
    swiftName: "_cdecl"
  ),
  SimpleDeclAttribute(
    name: "usableFromInline",
    className: "UsableFromInline",
    options:
      "OnAbstractFunction",
    "OnVar",
    "OnSubscript",
    "OnNominalType",
    "OnTypeAlias",
    "LongAttribute",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 64,
    swiftName: "usableFromInline"
  ),
  SimpleDeclAttribute(
    name: "discardableResult",
    className: "DiscardableResult",
    options:
      "OnFunc",
    "OnAccessor",
    "OnConstructor",
    "LongAttribute",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 65,
    swiftName: "discardableResult"
  ),
  SimpleDeclAttribute(
    name: "GKInspectable",
    className: "GKInspectable",
    options:
      "OnVar",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 66,
    swiftName: "GKInspectable"
  ),
  DeclAttribute(
    name: "_implements",
    className: "Implements",
    options:
      "OnFunc",
    "OnAccessor",
    "OnVar",
    "OnSubscript",
    "OnTypeAlias",
    "UserInaccessible",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 67,
    swiftName: "_implements"
  ),
  DeclAttribute(
    name: "_objcRuntimeName",
    className: "ObjCRuntimeName",
    options:
      "OnClass",
    "UserInaccessible",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 68,
    swiftName: "_objcRuntimeName"
  ),
  SimpleDeclAttribute(
    name: "_staticInitializeObjCMetadata",
    className: "StaticInitializeObjCMetadata",
    options:
      "OnClass",
    "UserInaccessible",
    "LongAttribute",
    "RejectByParser",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 69,
    swiftName: "_staticInitializeObjCMetadata"
  ),
  DeclAttribute(
    name: "_restatedObjCConformance",
    className: "RestatedObjCConformance",
    options:
      "OnProtocol",
    "UserInaccessible",
    "LongAttribute",
    "RejectByParser",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 70,
    swiftName: "_restatedObjCConformance"
  ),

  // NOTE: 71 is unused

  DeclAttribute(
    name: "_objcImplementation",
    className: "ObjCImplementation",
    options:
      "OnExtension",
    "UserInaccessible",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 72,
    swiftName: "_objcImplementation"
  ),
  DeclAttribute(
    name: "_optimize",
    className: "Optimize",
    options:
      "OnAbstractFunction",
    "OnSubscript",
    "OnVar",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 73,
    swiftName: "_optimize"
  ),
  DeclAttribute(
    name: "_clangImporterSynthesizedType",
    className: "ClangImporterSynthesizedType",
    options:
      "OnGenericType",
    "LongAttribute",
    "RejectByParser",
    "UserInaccessible",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 74,
    swiftName: "_clangImporterSynthesizedType"
  ),
  SimpleDeclAttribute(
    name: "_weakLinked",
    className: "WeakLinked",
    options:
      "OnNominalType",
    "OnAssociatedType",
    "OnFunc",
    "OnAccessor",
    "OnVar",
    "OnSubscript",
    "OnConstructor",
    "OnEnumElement",
    "OnExtension",
    "OnImport",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 75,
    swiftName: "_weakLinked"
  ),
  SimpleDeclAttribute(
    name: "frozen",
    className: "Frozen",
    options:
      "OnEnum",
    "OnStruct",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToRemove",
    "APIStableToAdd",
    code: 76,
    swiftName: "frozen"
  ),
  DeclAttributeAlias(
    name: "_frozen",
    className: "Frozen",
    swiftName: "_frozen"
  ),
  SimpleDeclAttribute(
    name: "_forbidSerializingReference",
    className: "ForbidSerializingReference",
    options:
      "OnAnyDecl",
    "LongAttribute",
    "RejectByParser",
    "UserInaccessible",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 77,
    swiftName: "_forbidSerializingReference"
  ),
  SimpleDeclAttribute(
    name: "_hasInitialValue",
    className: "HasInitialValue",
    options:
      "OnVar",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 78,
    swiftName: "_hasInitialValue"
  ),
  SimpleDeclAttribute(
    name: "_nonoverride",
    className: "NonOverride",
    options:
      "OnFunc",
    "OnAccessor",
    "OnVar",
    "OnSubscript",
    "OnConstructor",
    "OnAssociatedType",
    "UserInaccessible",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 79,
    swiftName: "_nonoverride"
  ),
  DeclAttribute(
    name: "_dynamicReplacement",
    className: "DynamicReplacement",
    options:
      "OnAbstractFunction",
    "OnVar",
    "OnSubscript",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 80,
    swiftName: "_dynamicReplacement"
  ),
  SimpleDeclAttribute(
    name: "_borrowed",
    className: "Borrowed",
    options:
      "OnVar",
    "OnSubscript",
    "UserInaccessible",
    "NotSerialized",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 81,
    swiftName: "_borrowed"
  ),
  DeclAttribute(
    name: "_private",
    className: "PrivateImport",
    options:
      "OnImport",
    "UserInaccessible",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 82,
    swiftName: "_private"
  ),
  SimpleDeclAttribute(
    name: "_alwaysEmitIntoClient",
    className: "AlwaysEmitIntoClient",
    options:
      "OnVar",
    "OnSubscript",
    "OnAbstractFunction",
    "UserInaccessible",
    "ABIBreakingToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 83,
    swiftName: "_alwaysEmitIntoClient"
  ),
  SimpleDeclAttribute(
    name: "_implementationOnly",
    className: "ImplementationOnly",
    options:
      "OnImport",
    "OnFunc",
    "OnConstructor",
    "OnVar",
    "OnSubscript",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 84,
    swiftName: "_implementationOnly"
  ),
  DeclAttribute(
    name: "_custom",
    className: "Custom",
    options:
      "OnAnyDecl",
    "RejectByParser",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 85,
    swiftName: "_custom"
  ),
  SimpleDeclAttribute(
    name: "propertyWrapper",
    className: "PropertyWrapper",
    options:
      "OnStruct",
    "OnClass",
    "OnEnum",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 86,
    swiftName: "propertyWrapper"
  ),
  SimpleDeclAttribute(
    name: "_disfavoredOverload",
    className: "DisfavoredOverload",
    options:
      "OnAbstractFunction",
    "OnVar",
    "OnSubscript",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 87,
    swiftName: "_disfavoredOverload"
  ),
  SimpleDeclAttribute(
    name: "resultBuilder",
    className: "ResultBuilder",
    options:
      "OnNominalType",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 88,
    swiftName: "resultBuilder"
  ),
  DeclAttribute(
    name: "_projectedValueProperty",
    className: "ProjectedValueProperty",
    options:
      "OnVar",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 89,
    swiftName: "_projectedValueProperty"
  ),
  SimpleDeclAttribute(
    name: "_nonEphemeral",
    className: "NonEphemeral",
    options:
      "OnParam",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIBreakingToAdd",
    "APIStableToRemove",
    code: 90,
    swiftName: "_nonEphemeral"
  ),
  DeclAttribute(
    name: "differentiable",
    className: "Differentiable",
    options:
      "OnAccessor",
    "OnConstructor",
    "OnFunc",
    "OnVar",
    "OnSubscript",
    "LongAttribute",
    "AllowMultipleAttributes",
    "ABIStableToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIBreakingToRemove",
    code: 91,
    swiftName: "differentiable"
  ),
  SimpleDeclAttribute(
    name: "_hasMissingDesignatedInitializers",
    className: "HasMissingDesignatedInitializers",
    options:
      "OnClass",
    "UserInaccessible",
    "NotSerialized",
    "APIBreakingToAdd",
    "ABIBreakingToAdd",
    "APIStableToRemove",
    "ABIStableToRemove",
    code: 92,
    swiftName: "_hasMissingDesignatedInitializers"
  ),
  SimpleDeclAttribute(
    name: "_inheritsConvenienceInitializers",
    className: "InheritsConvenienceInitializers",
    options:
      "OnClass",
    "UserInaccessible",
    "NotSerialized",
    "APIStableToAdd",
    "ABIStableToAdd",
    "APIBreakingToRemove",
    "ABIBreakingToRemove",
    code: 93,
    swiftName: "_inheritsConvenienceInitializers"
  ),
  DeclAttribute(
    name: "_typeEraser",
    className: "TypeEraser",
    options:
      "OnProtocol",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIBreakingToRemove",
    code: 94,
    swiftName: "_typeEraser"
  ),
  SimpleDeclAttribute(
    name: "IBSegueAction",
    className: "IBSegueAction",
    options:
      "OnFunc",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 95,
    swiftName: "IBSegueAction"
  ),
  DeclAttribute(
    name: "_originallyDefinedIn",
    className: "OriginallyDefinedIn",
    options:
      "OnNominalType",
    "OnFunc",
    "OnVar",
    "OnExtension",
    "UserInaccessible",
    "AllowMultipleAttributes",
    "LongAttribute",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 96,
    swiftName: "_originallyDefinedIn"
  ),
  DeclAttribute(
    name: "derivative",
    className: "Derivative",
    options:
      "OnFunc",
    "LongAttribute",
    "AllowMultipleAttributes",
    "ABIStableToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIBreakingToRemove",
    code: 97,
    swiftName: "derivative"
  ),
  DeclAttribute(
    name: "_spi",
    className: "SPIAccessControl",
    options:
      "OnAbstractFunction",
    "OnExtension",
    "OnGenericType",
    "OnVar",
    "OnSubscript",
    "OnImport",
    "OnAccessor",
    "OnEnumElement",
    "OnMacro",
    "AllowMultipleAttributes",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIBreakingToAdd",
    "APIStableToRemove",
    code: 98,
    swiftName: "_spi"
  ),
  DeclAttribute(
    name: "transpose",
    className: "Transpose",
    options:
      "OnFunc",
    "LongAttribute",
    "AllowMultipleAttributes",
    "ABIStableToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIBreakingToRemove",
    code: 99,
    swiftName: "transpose"
  ),
  SimpleDeclAttribute(
    name: "noDerivative",
    className: "NoDerivative",
    options:
      "OnAbstractFunction",
    "OnVar",
    "OnSubscript",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 100,
    swiftName: "noDerivative"
  ),

  // 101 was @asyncHandler and is now unused

  SimpleDeclAttribute(
    name: "globalActor",
    className: "GlobalActor",
    options:
      "OnClass",
    "OnStruct",
    "OnEnum",
    "ABIStableToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIBreakingToRemove",
    code: 104,
    swiftName: "globalActor"
  ),

  SimpleDeclAttribute(
    name: "_specializeExtension",
    className: "SpecializeExtension",
    options:
      "OnExtension",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 105,
    swiftName: "_specializeExtension"
  ),
  SimpleDeclAttribute(
    name: "Sendable",
    className: "Sendable",
    options:
      "OnFunc",
    "OnConstructor",
    "OnAccessor",
    "OnAnyClangDecl",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 107,
    swiftName: "Sendable"
  ),
  SimpleDeclAttribute(
    name: "_marker",
    className: "Marker",
    options:
      "OnProtocol",
    "UserInaccessible",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 108,
    swiftName: "_marker"
  ),
  SimpleDeclAttribute(
    name: "reasync",
    className: "AtReasync",
    options:
      "OnProtocol",
    "ConcurrencyOnly",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 110,
    swiftName: "atReasync"
  ),

  // 111 was an experimental @completionHandlerAsync and is now unused

  // 113 was experimental _unsafeSendable and is now unused

  // Previously experimental _unsafeMainActor
  SimpleDeclAttribute(
    name: "_unsafeInheritExecutor",
    className: "UnsafeInheritExecutor",
    options:
      "OnFunc",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIBreakingToRemove",
    code: 114,
    swiftName: "_unsafeInheritExecutor"
  ),
  SimpleDeclAttribute(
    name: "_implicitSelfCapture",
    className: "ImplicitSelfCapture",
    options:
      "OnParam",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIBreakingToRemove",
    code: 115,
    swiftName: "_implicitSelfCapture"
  ),
  SimpleDeclAttribute(
    name: "_inheritActorContext",
    className: "InheritActorContext",
    options:
      "OnParam",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 116,
    swiftName: "_inheritActorContext"
  ),
  SimpleDeclAttribute(
    name: "_eagerMove",
    className: "EagerMove",
    options:
      "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    "OnFunc",
    "OnParam",
    "OnVar",
    "OnNominalType",
    code: 117,
    swiftName: "_eagerMove"
  ),
  SimpleDeclAttribute(
    name: "_lexicalLifetimes",
    className: "LexicalLifetimes",
    options:
      "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    "OnFunc",
    code: 36,
    swiftName: "_lexicalLifetimes"
  ),
  SimpleDeclAttribute(
    name: "_noEagerMove",
    className: "NoEagerMove",
    options:
      "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    "OnFunc",
    "OnParam",
    "OnVar",
    "OnNominalType",
    code: 119,
    swiftName: "_noEagerMove"
  ),
  SimpleDeclAttribute(
    name: "_assemblyVision",
    className: "EmitAssemblyVisionRemarks",
    options:
      "OnFunc",
    "UserInaccessible",
    "NotSerialized",
    "OnNominalType",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 120,
    swiftName: "_assemblyVision"
  ),
  DeclAttribute(
    name: "_nonSendable",
    className: "NonSendable",
    options:
      "OnNominalType",
    "UserInaccessible",
    "AllowMultipleAttributes",
    "ABIStableToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIBreakingToRemove",
    code: 121,
    swiftName: "_nonSendable"
  ),
  SimpleDeclAttribute(
    name: "_noImplicitCopy",
    className: "NoImplicitCopy",
    options:
      "UserInaccessible",
    "ABIStableToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIBreakingToRemove",
    "OnFunc",
    "OnParam",
    "OnVar",
    code: 122,
    swiftName: "_noImplicitCopy"
  ),
  SimpleDeclAttribute(
    name: "_noLocks",
    className: "NoLocks",
    options:
      "OnAbstractFunction",
    "OnSubscript",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 123,
    swiftName: "_noLocks"
  ),
  SimpleDeclAttribute(
    name: "_noAllocation",
    className: "NoAllocation",
    options:
      "OnAbstractFunction",
    "OnSubscript",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 124,
    swiftName: "_noAllocation"
  ),
  SimpleDeclAttribute(
    name: "preconcurrency",
    className: "Preconcurrency",
    options:
      "OnFunc",
    "OnConstructor",
    "OnProtocol",
    "OnGenericType",
    "OnVar",
    "OnSubscript",
    "OnEnumElement",
    "OnImport",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 125,
    swiftName: "preconcurrency"
  ),
  DeclAttribute(
    name: "_unavailableFromAsync",
    className: "UnavailableFromAsync",
    options:
      "OnFunc",
    "OnConstructor",
    "OnMacro",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIBreakingToAdd",
    "APIStableToRemove",
    code: 127,
    swiftName: "_unavailableFromAsync"
  ),
  DeclAttribute(
    name: "exclusivity",
    className: "Exclusivity",
    options:
      "OnVar",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 128,
    swiftName: "exclusivity"
  ),
  DeclAttribute(
    name: "backDeployed",
    className: "BackDeployed",
    options:
      "OnAbstractFunction",
    "OnAccessor",
    "OnSubscript",
    "OnVar",
    "AllowMultipleAttributes",
    "LongAttribute",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIBreakingToRemove",
    code: 129,
    swiftName: "backDeployed"
  ),
  DeclAttributeAlias(
    name: "_backDeploy",
    className: "BackDeployed",
    swiftName: "_backDeploy"
  ),
  SimpleDeclAttribute(
    name: "_moveOnly",
    className: "MoveOnly",
    options:
      "OnNominalType",
    "UserInaccessible",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 131,
    swiftName: "_moveOnly"
  ),
  SimpleDeclAttribute(
    name: "_alwaysEmitConformanceMetadata",
    className: "AlwaysEmitConformanceMetadata",
    options:
      "OnProtocol",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 132,
    swiftName: "_alwaysEmitConformanceMetadata"
  ),
  DeclAttribute(
    name: "_expose",
    className: "Expose",
    options:
      "OnFunc",
    "OnNominalType",
    "OnVar",
    "OnConstructor",
    "LongAttribute",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 133,
    swiftName: "_expose"
  ),
  SimpleDeclAttribute(
    name: "typeWrapper",
    className: "TypeWrapper",
    options:
      "OnStruct",
    "OnClass",
    "OnEnum",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 134,
    swiftName: "typeWrapper"
  ),
  SimpleDeclAttribute(
    name: "_spiOnly",
    className: "SPIOnly",
    options:
      "OnImport",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 135,
    swiftName: "_spiOnly"
  ),
  DeclAttribute(
    name: "_documentation",
    className: "Documentation",
    options:
      "OnAnyDecl",
    "UserInaccessible",
    "APIBreakingToAdd",
    "APIStableToRemove",
    "ABIStableToAdd",
    "ABIStableToRemove",
    code: 136,
    swiftName: "_documentation"
  ),
  SimpleDeclAttribute(
    name: "typeWrapperIgnored",
    className: "TypeWrapperIgnored",
    options:
      "OnVar",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 137,
    swiftName: "typeWrapperIgnored"
  ),
  SimpleDeclAttribute(
    name: "_noMetadata",
    className: "NoMetadata",
    options:
      "OnGenericTypeParam",
    "UserInaccessible",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 138,
    swiftName: "_noMetadata"
  ),
  SimpleDeclAttribute(
    name: "runtimeMetadata",
    className: "RuntimeMetadata",
    options:
      "OnStruct",
    "OnClass",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 139,
    swiftName: "runtimeMetadata"
  ),
]

/// Schema for declaration modifiers:
///
/// - Modifier name.
/// - C++ class name without the 'Attr' suffix
/// - Options for the attribute, including:
///    * the declarations the attribute can appear on
///    * whether duplicates are allowed
/// - Unique attribute identifier used for serialization. This
///   can never be changed.
///
/// SimpleDeclAttribute is the same, but the class becomes
/// SimpleDeclAttr<DAK_##NAME> on the C++ side.
///
/// Please help ease code review/audits:
/// - Please place the "OnXYZ" flags together on the next line.
/// - Please place the non-OnXYZ flags together on the next to last line.
/// - Please place the unique code number on the last line.
/// - Please sort attributes by serialization number.
/// - Please create a "NOTE" comment if a unique number is skipped.
///
/// If you're adding a new kind of attribute that is spelled with a leading
/// '@' symbol, add an entry to the `DECL_ATTR_KINDS` array instead.
public let DECL_MODIFIER_KINDS: [Attribute] = [
  // These are not really attributes or modifiers in the C++ AST and they are
  // serialized directly into the ASTs they are attached to rather than using
  // the generic attribute serialization infrastructure.
  BuiltinDeclModifier(
    name: "static",
    swiftName: "`static`"
  ),
  BuiltinDeclModifier(
    name: "class",
    swiftName: "`class`"
  ),
  ContextualSimpleDeclAttribute(
    name: "final",
    className: "Final",
    options:
      "OnClass",
    "OnFunc",
    "OnAccessor",
    "OnVar",
    "OnSubscript",
    "DeclModifier",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 2
  ),
  ContextualSimpleDeclAttribute(
    name: "required",
    className: "Required",
    options:
      "OnConstructor",
    "DeclModifier",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 4
  ),
  ContextualSimpleDeclAttribute(
    name: "optional",
    className: "Optional",
    options:
      "OnConstructor",
    "OnFunc",
    "OnAccessor",
    "OnVar",
    "OnSubscript",
    "DeclModifier",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 5
  ),
  ContextualSimpleDeclAttribute(
    name: "lazy",
    className: "Lazy",
    options:
      "DeclModifier",
    "OnVar",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 16
  ),
  ContextualSimpleDeclAttribute(
    name: "dynamic",
    className: "Dynamic",
    options:
      "OnFunc",
    "OnAccessor",
    "OnVar",
    "OnSubscript",
    "OnConstructor",
    "DeclModifier",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 22
  ),
  ContextualSimpleDeclAttribute(
    name: "infix",
    className: "Infix",
    options:
      "OnFunc",
    "OnOperator",
    "DeclModifier",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 23
  ),
  ContextualSimpleDeclAttribute(
    name: "prefix",
    className: "Prefix",
    options:
      "OnFunc",
    "OnOperator",
    "DeclModifier",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 24
  ),
  ContextualSimpleDeclAttribute(
    name: "postfix",
    className: "Postfix",
    options:
      "OnFunc",
    "OnOperator",
    "DeclModifier",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 25
  ),
  ContextualSimpleDeclAttribute(
    name: "__consuming",
    className: "Consuming",
    options:
      "OnFunc",
    "OnAccessor",
    "DeclModifier",
    "UserInaccessible",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 40
  ),
  ContextualSimpleDeclAttribute(
    name: "mutating",
    className: "Mutating",
    options:
      "OnFunc",
    "OnAccessor",
    "DeclModifier",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 41
  ),
  ContextualSimpleDeclAttribute(
    name: "nonmutating",
    className: "NonMutating",
    options:
      "OnFunc",
    "OnAccessor",
    "DeclModifier",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 42
  ),
  ContextualSimpleDeclAttribute(
    name: "convenience",
    className: "Convenience",
    options:
      "OnConstructor",
    "DeclModifier",
    "NotSerialized",
    "ABIBreakingToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 43
  ),
  ContextualSimpleDeclAttribute(
    name: "override",
    className: "Override",
    options:
      "OnFunc",
    "OnAccessor",
    "OnVar",
    "OnSubscript",
    "OnConstructor",
    "OnAssociatedType",
    "DeclModifier",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 44
  ),
  DeclAttribute(
    name: "private",
    className: "AccessControl",
    options:
      "OnFunc",
    "OnAccessor",
    "OnExtension",
    "OnGenericType",
    "OnVar",
    "OnSubscript",
    "OnConstructor",
    "OnMacro",
    "OnImport",
    "DeclModifier",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 46,
    swiftName: "`private`"
  ),
  DeclAttributeAlias(
    name: "fileprivate",
    className: "AccessControl",
    swiftName: "`fileprivate`"
  ),
  DeclAttributeAlias(
    name: "internal",
    className: "AccessControl",
    swiftName: "`internal`"
  ),
  DeclAttributeAlias(
    name: "public",
    className: "AccessControl",
    swiftName: "`public`"
  ),
  ContextualDeclAttributeAlias(
    name: "package",
    className: "AccessControl",
    swiftName: "package"
  ),
  ContextualDeclAttributeAlias(
    name: "open",
    className: "AccessControl",
    swiftName: "open"
  ),
  DeclAttribute(
    name: "__setter_access",
    className: "SetterAccess",
    options:
      "OnVar",
    "OnSubscript",
    "DeclModifier",
    "RejectByParser",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 47,
    swiftName: "__setter_access"
  ),
  ContextualDeclAttribute(
    name: "weak",
    className: "ReferenceOwnership",
    options:
      "OnVar",
    "DeclModifier",
    "NotSerialized",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 49
  ),
  ContextualDeclAttributeAlias(
    name: "unowned",
    className: "ReferenceOwnership",
    swiftName: "unowned"
  ),
  SimpleDeclAttribute(
    name: "rethrows",
    className: "Rethrows",
    options:
      "OnFunc",
    "OnConstructor",
    "RejectByParser",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 57,
    swiftName: "`rethrows`"
  ),
  ContextualSimpleDeclAttribute(
    name: "indirect",
    className: "Indirect",
    options:
      "DeclModifier",
    "OnEnum",
    "OnEnumElement",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIStableToAdd",
    "APIStableToRemove",
    code: 60
  ),
  ContextualSimpleDeclAttribute(
    name: "isolated",
    className: "Isolated",
    options:
      "DeclModifier",
    "OnParam",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 103
  ),
  ContextualSimpleDeclAttribute(
    name: "async",
    className: "Async",
    options:
      "DeclModifier",
    "OnVar",
    "OnFunc",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 106
  ),
  SimpleDeclAttribute(
    name: "reasync",
    className: "Reasync",
    options:
      "OnFunc",
    "OnConstructor",
    "RejectByParser",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 109,
    swiftName: "reasync"
  ),
  ContextualSimpleDeclAttribute(
    name: "nonisolated",
    className: "Nonisolated",
    options:
      "DeclModifier",
    "OnFunc",
    "OnConstructor",
    "OnVar",
    "OnSubscript",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIBreakingToAdd",
    "APIStableToRemove",
    code: 112
  ),
  ContextualSimpleDeclAttribute(
    name: "distributed",
    className: "DistributedActor",
    options:
      "DeclModifier",
    "OnClass",
    "OnFunc",
    "OnAccessor",
    "OnVar",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 118
  ),
  ContextualSimpleDeclAttribute(
    name: "_const",
    className: "CompileTimeConst",
    options:
      "DeclModifier",
    "OnParam",
    "OnVar",
    "UserInaccessible",
    "ABIStableToAdd",
    "ABIStableToRemove",
    "APIBreakingToAdd",
    "APIStableToRemove",
    code: 126
  ),
  ContextualSimpleDeclAttribute(
    name: "_local",
    className: "KnownToBeLocal",
    options:
      "DeclModifier",
    "OnFunc",
    "OnParam",
    "OnVar",
    "UserInaccessible",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 130
  ),
]

public let DEPRECATED_MODIFIER_KINDS: [Attribute] = [
  // TODO: Remove this once we don't need to support 'actor' as a modifier
  ContextualSimpleDeclAttribute(
    name: "actor",
    className: "Actor",
    options:
      "DeclModifier",
    "OnClass",
    "ConcurrencyOnly",
    "ABIBreakingToAdd",
    "ABIBreakingToRemove",
    "APIBreakingToAdd",
    "APIBreakingToRemove",
    code: 102
  )
]
