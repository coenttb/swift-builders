//
//  File.swift
//  coenttb-html
//
//  Created by Coen ten Thije Boonkkamp on 07/10/2024.
//

@resultBuilder
public enum StringBuilder {
    public static func buildPartialBlock(first: String) -> String {
        first
    }
    
    public static func buildPartialBlock(accumulated: String, next: String) -> String {
        if accumulated.isEmpty {
            return next
        } else {
            return accumulated + "\n" + next
        }
    }
    
    public static func buildEither(first component: String) -> String {
        component
    }
    
    public static func buildEither(second component: String) -> String {
        component
    }
    
    public static func buildOptional(_ component: String?) -> String {
        component ?? ""
    }
    
    public static func buildArray(_ components: [String]) -> String {
        components.joined(separator: "\n")
    }
    
    // Add missing methods for completeness
    public static func buildBlock() -> String {
        ""
    }
    
    public static func buildBlock(_ components: String...) -> String {
        components.joined(separator: "\n")
    }
    
    public static func buildLimitedAvailability(_ component: String) -> String {
        component
    }
}

extension String {
    public init(@StringBuilder _ builder: () -> String) {
        self = builder()
    }
}
