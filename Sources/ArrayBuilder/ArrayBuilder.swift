@resultBuilder
public struct ArrayBuilder<Element> {
    // MARK: - Expression Building (for type inference)
    
    public static func buildExpression(_ expression: Element) -> [Element] {
        [expression]
    }
    
    public static func buildExpression(_ expression: [Element]) -> [Element] {
        expression
    }
    
    public static func buildExpression(_ expression: Element?) -> [Element] {
        expression.map { [$0] } ?? []
    }
    
    // MARK: - Core Building Blocks
    
    public static func buildPartialBlock(first: [Element]) -> [Element] {
        first
    }
    
    public static func buildPartialBlock(accumulated: [Element], next: [Element]) -> [Element] {
        accumulated + next
    }
    
    // MARK: - Block Building
    
    public static func buildBlock() -> [Element] {
        []
    }
    
    public static func buildBlock(_ component: [Element]) -> [Element] {
        component
    }
    
    public static func buildBlock(_ components: [Element]...) -> [Element] {
        components.flatMap { $0 }
    }
    
    // MARK: - Control Flow
    
    public static func buildPartialBlock(first: Void) -> [Element] { [] }
    
    public static func buildPartialBlock(first: Never) -> [Element] { }
    
    public static func buildOptional(_ component: [Element]?) -> [Element] {
        component ?? []
    }
    
    public static func buildEither(first: [Element]) -> [Element] {
        first
    }
    
    public static func buildEither(second: [Element]) -> [Element] {
        second
    }
    
    public static func buildArray(_ components: [[Element]]) -> [Element] {
        components.flatMap { $0 }
    }
    
    public static func buildLimitedAvailability(_ component: [Element]) -> [Element] {
        component
    }
}

extension Array {
    public init(@ArrayBuilder<Element> _ builder: () -> [Element]) {
        self = builder()
    }
}