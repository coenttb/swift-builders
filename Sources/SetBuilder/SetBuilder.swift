//
//  File.swift
//  coenttb-utils
//
//  Created by Coen ten Thije Boonkkamp on 01/11/2024.
//

@resultBuilder
public struct SetBuilder<Element: Hashable> {
    // MARK: - Core Building Blocks
    
    public static func buildPartialBlock(first: Element) -> Set<Element> {
        [first]
    }
    
    public static func buildPartialBlock(first: Set<Element>) -> Set<Element> {
        first
    }
    
    public static func buildPartialBlock(accumulated: Set<Element>, next: Element) -> Set<Element> {
        var result = accumulated
        result.insert(next)
        return result
    }
    
    public static func buildPartialBlock(accumulated: Set<Element>, next: Set<Element>) -> Set<Element> {
        var result = accumulated
        result.formUnion(next)
        return result
    }
    
    public static func buildPartialBlock(first: [Element]) -> Set<Element> {
        Set(first)
    }
    
    public static func buildPartialBlock(accumulated: Set<Element>, next: [Element]) -> Set<Element> {
        var result = accumulated
        result.formUnion(next)
        return result
    }
    
    // MARK: - Control Flow
    
    public static func buildPartialBlock(first: Void) -> Set<Element> { [] }
    
    public static func buildPartialBlock(first: Never) -> Set<Element> {}
    
    public static func buildBlock() -> Set<Element> { [] }
    
    public static func buildIf(_ element: Set<Element>?) -> Set<Element> {
        element ?? []
    }
    
    public static func buildEither(first: Set<Element>) -> Set<Element> {
        first
    }
    
    public static func buildEither(second: Set<Element>) -> Set<Element> {
        second
    }
    
    public static func buildArray(_ components: [Set<Element>]) -> Set<Element> {
        components.reduce(into: Set<Element>()) { result, set in
            result.formUnion(set)
        }
    }
    
    public static func buildLimitedAvailability(_ component: Set<Element>) -> Set<Element> {
        component
    }
}

public extension Set {
    init(@SetBuilder<Element> _ builder: () -> Set<Element>) {
        self = builder()
    }
}
