@resultBuilder
public struct ArrayBuilder<Element> {
    // MARK: - Expression Building
    
    // This is key for type inference
    public static func buildExpression(_ expression: Element) -> [Element] {
        [expression]
    }
    
    // Support for array expressions
    public static func buildExpression(_ expression: [Element]) -> [Element] {
        expression
    }
    
    // MARK: - Block Building
    
    // Empty block
    public static func buildBlock() -> [Element] {
        []
    }
    
    // Single element block
    public static func buildBlock(_ component: [Element]) -> [Element] {
        component
    }
    
    // Multiple element block
    public static func buildBlock(_ components: [Element]...) -> [Element] {
        components.flatMap { $0 }
    }
    
    // MARK: - Control Flow
    
    // Optional elements
    public static func buildOptional(_ component: [Element]?) -> [Element] {
        component ?? []
    }
    
    // Conditional elements
    public static func buildEither(first component: [Element]) -> [Element] {
        component
    }
    
    public static func buildEither(second component: [Element]) -> [Element] {
        component
    }
    
    // Arrays of elements
    public static func buildArray(_ components: [[Element]]) -> [Element] {
        components.flatMap { $0 }
    }
    
    // Limited element
    public static func buildLimitedAvailability(_ component: [Element]) -> [Element] {
        component
    }
}

extension Array {
    public init(@ArrayBuilder<Element> _ builder: () -> [Element]) {
        self = builder()
    }
}
