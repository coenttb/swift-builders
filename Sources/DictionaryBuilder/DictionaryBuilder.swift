//
//  DictionaryBuilder.swift
//  swift-builders
//
//  Created by Coen ten Thije Boonkkamp on 30/07/2025.
//

public struct KeyValuePair<Key: Hashable, Value> {
  public let key: Key
  public let value: Value

  public init(_ key: Key, _ value: Value) {
    self.key = key
    self.value = value
  }
}

@resultBuilder
public struct DictionaryBuilder<Key: Hashable, Value> {

  // MARK: - Core Building Blocks

  public static func buildPartialBlock(first: KeyValuePair<Key, Value>) -> [Key: Value] {
    [first.key: first.value]
  }

  public static func buildPartialBlock(first: (Key, Value)) -> [Key: Value] {
    [first.0: first.1]
  }

  public static func buildPartialBlock(first: [Key: Value]) -> [Key: Value] {
    first
  }

  public static func buildPartialBlock(first: [(Key, Value)]) -> [Key: Value] {
    Dictionary(first, uniquingKeysWith: { _, new in new })
  }

  public static func buildPartialBlock(accumulated: [Key: Value], next: KeyValuePair<Key, Value>)
    -> [Key: Value]
  {
    var result = accumulated
    result[next.key] = next.value
    return result
  }

  public static func buildPartialBlock(accumulated: [Key: Value], next: (Key, Value)) -> [Key:
    Value]
  {
    var result = accumulated
    result[next.0] = next.1
    return result
  }

  public static func buildPartialBlock(accumulated: [Key: Value], next: [Key: Value]) -> [Key:
    Value]
  {
    var result = accumulated
    result.merge(next) { _, new in new }
    return result
  }

  public static func buildPartialBlock(accumulated: [Key: Value], next: [(Key, Value)]) -> [Key:
    Value]
  {
    var result = accumulated
    for (key, value) in next {
      result[key] = value
    }
    return result
  }

  // MARK: - Control Flow

  public static func buildPartialBlock(first: Void) -> [Key: Value] { [:] }

  public static func buildPartialBlock(first: Never) -> [Key: Value] {}

  public static func buildBlock() -> [Key: Value] { [:] }

  public static func buildIf(_ element: [Key: Value]?) -> [Key: Value] {
    element ?? [:]
  }

  public static func buildEither(first: [Key: Value]) -> [Key: Value] {
    first
  }

  public static func buildEither(second: [Key: Value]) -> [Key: Value] {
    second
  }

  public static func buildArray(_ components: [[Key: Value]]) -> [Key: Value] {
    components.reduce(into: [Key: Value]()) { result, dict in
      result.merge(dict) { _, new in new }
    }
  }

  public static func buildLimitedAvailability(_ component: [Key: Value]) -> [Key: Value] {
    component
  }
}

extension Dictionary {
  public init(@DictionaryBuilder<Key, Value> _ builder: () -> [Key: Value]) {
    self = builder()
  }
}
