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
    
    public static func buildPartialBlock(first: KeyValuePair<Key, Value>) -> Dictionary<Key, Value> {
        [first.key: first.value]
    }
    
    public static func buildPartialBlock(first: (Key, Value)) -> Dictionary<Key, Value> {
        [first.0: first.1]
    }
    
    public static func buildPartialBlock(first: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        first
    }
    
    public static func buildPartialBlock(first: [(Key, Value)]) -> Dictionary<Key, Value> {
        Dictionary(first, uniquingKeysWith: { _, new in new })
    }
    
    public static func buildPartialBlock(accumulated: Dictionary<Key, Value>, next: KeyValuePair<Key, Value>) -> Dictionary<Key, Value> {
        var result = accumulated
        result[next.key] = next.value
        return result
    }
    
    public static func buildPartialBlock(accumulated: Dictionary<Key, Value>, next: (Key, Value)) -> Dictionary<Key, Value> {
        var result = accumulated
        result[next.0] = next.1
        return result
    }
    
    public static func buildPartialBlock(accumulated: Dictionary<Key, Value>, next: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        var result = accumulated
        result.merge(next) { _, new in new }
        return result
    }
    
    public static func buildPartialBlock(accumulated: Dictionary<Key, Value>, next: [(Key, Value)]) -> Dictionary<Key, Value> {
        var result = accumulated
        for (key, value) in next {
            result[key] = value
        }
        return result
    }
    
    // MARK: - Control Flow
    
    public static func buildPartialBlock(first: Void) -> Dictionary<Key, Value> { [:] }
    
    public static func buildPartialBlock(first: Never) -> Dictionary<Key, Value> { }
    
    public static func buildBlock() -> Dictionary<Key, Value> { [:] }
    
    public static func buildIf(_ element: Dictionary<Key, Value>?) -> Dictionary<Key, Value> {
        element ?? [:]
    }
    
    public static func buildEither(first: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        first
    }
    
    public static func buildEither(second: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        second
    }
    
    public static func buildArray(_ components: [Dictionary<Key, Value>]) -> Dictionary<Key, Value> {
        components.reduce(into: Dictionary<Key, Value>()) { result, dict in
            result.merge(dict) { _, new in new }
        }
    }
    
    public static func buildLimitedAvailability(_ component: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        component
    }
}

public extension Dictionary {
    init(@DictionaryBuilder<Key, Value> _ builder: () -> Dictionary<Key, Value>) {
        self = builder()
    }
}