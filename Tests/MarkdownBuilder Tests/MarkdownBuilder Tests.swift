//
//  MarkdownBuilder Tests.swift
//  swift-builders
//
//  Created by Coen ten Thije Boonkkamp on 29/07/2025.
//

import Foundation
@testable import MarkdownBuilder
import Testing

@Suite("MarkdownBuilder Tests")
struct MarkdownBuilderTests {
    
    @Suite("Basic Markdown Building")
    struct BasicMarkdownBuildingTests {
        
        @Test("Single string")
        func singleString() {
            let result = String(markdown: {
                "Hello World"
            })
            #expect(result == "Hello World")
        }
        
        @Test("Multiple strings")
        func multipleStrings() {
            let result = String(markdown: {
                "# Header"
                "This is content"
                "More content"
            })
            #expect(result == "# Header\nThis is content\nMore content")
        }
        
        @Test("Empty markdown building")
        func emptyMarkdownBuilding() {
            let result = String(markdown: {
                // Empty
            })
            #expect(result == "")
        }
        
        @Test("Mixed string and array expressions")
        func mixedStringAndArrayExpressions() {
            let result = String(markdown: {
                "Header"
                ["Line 1", "Line 2"]
                "Footer"
            })
            #expect(result == "Header\nLine 1\nLine 2\nFooter")
        }
    }
    
    @Suite("Control Flow")
    struct ControlFlowTests {
        
        @Test("Conditional content - if true")
        func conditionalContentIfTrue() {
            let includeSection = true
            let result = String(markdown: {
                "# Document"
                if includeSection {
                    "## Section"
                    "Content here"
                } else {
                    "## Alternative"
                    "Different content"
                }
                "End of document"
            })
            
            let expected = """
            # Document
            ## Section
            Content here
            End of document
            """
            #expect(result == expected)
        }
        
        @Test("For loop content generation")
        func forLoopContentGeneration() {
            let items = ["Apple", "Banana", "Cherry"]
            let result = String(markdown: {
                "# Fruit List"
                for item in items {
                    "- \(item)"
                }
                "End of list"
            })
            
            let expected = """
            # Fruit List
            - Apple
            - Banana
            - Cherry
            End of list
            """
            #expect(result == expected)
        }
        
        @Test("Optional string expression - some")
        func optionalStringExpressionSome() {
            let optionalText: String? = "Optional content"
            let result = String(markdown: {
                "Start"
                optionalText
                "End"
            })
            #expect(result == "Start\nOptional content\nEnd")
        }
        
        @Test("Optional string expression - none")
        func optionalStringExpressionNone() {
            let optionalText: String? = nil
            let result = String(markdown: {
                "Start"
                optionalText
                "End"
            })
            #expect(result == "Start\nEnd")
        }
    }
    
    @Suite("Real-World Markdown Usage")
    struct RealWorldMarkdownUsageTests {
        
        @Test("Building README content")
        func buildingReadmeContent() {
            let projectName = "MyProject"
            let version = "1.0.0"
            let features = ["Feature A", "Feature B", "Feature C"]
            
            let readme = String(markdown: {
                "# \(projectName)"
                ""
                "Version: \(version)"
                ""
                "## Features"
                ""
                for feature in features {
                    "- \(feature)"
                }
                ""
                "## Installation"
                ""
                "```bash"
                "npm install \(projectName.lowercased())"
                "```"
            })
            
            let expected = """
            # MyProject
            
            Version: 1.0.0
            
            ## Features
            
            - Feature A
            - Feature B
            - Feature C
            
            ## Installation
            
            ```bash
            npm install myproject
            ```
            """
            #expect(readme == expected)
        }
        
        @Test("Building table of contents")
        func buildingTableOfContents() {
            let sections = [
                ("Introduction", "introduction"),
                ("Getting Started", "getting-started"),
                ("Advanced Usage", "advanced-usage"),
                ("FAQ", "faq")
            ]
            
            let toc = String(markdown: {
                "# Table of Contents"
                ""
                for (title, anchor) in sections {
                    "- [\(title)](#\(anchor))"
                }
            })
            
            let expected = """
            # Table of Contents
            
            - [Introduction](#introduction)
            - [Getting Started](#getting-started)
            - [Advanced Usage](#advanced-usage)
            - [FAQ](#faq)
            """
            #expect(toc == expected)
        }
    }
    
    @Suite("Edge Cases")
    struct EdgeCasesTests {
        
        @Test("Empty strings in builder")
        func emptyStringsInBuilder() {
            let result = String(markdown: {
                "# Header"
                ""
                "Content"
                ""
                "Footer"
            })
            #expect(result == "# Header\n\nContent\n\nFooter")
        }
        
        @Test("Nested arrays direct syntax")
        func nestedArraysDirectSyntax() {
            let result = String(markdown: {
                "Start"
                [["Nested 1", "Nested 2"], ["Nested 3", "Nested 4"]]
                "End"
            })
            #expect(result == "Start\nNested 1\nNested 2\nNested 3\nNested 4\nEnd")
        }
        
        @Test("Nested arrays through for loop")
        func nestedArraysThroughForLoop() {
            let nestedArrays = [["Nested 1", "Nested 2"], ["Nested 3", "Nested 4"]]
            let result = String(markdown: {
                "Start"
                for array in nestedArrays {
                    array
                }
                "End"
            })
            #expect(result == "Start\nNested 1\nNested 2\nNested 3\nNested 4\nEnd")
        }
        
        @Test("Large markdown generation")
        func largeMarkdownGeneration() {
            let result = String(markdown: {
                "# Large Document"
                for i in 1...100 {
                    "## Section \(i)"
                    "Content for section \(i)"
                }
                "# End"
            })
            
            let lines = result.components(separatedBy: "\n")
            #expect(lines.count == 202) // Header + (2 lines * 100 sections) + End
            #expect(lines.first == "# Large Document")
            #expect(lines.last == "# End")
        }
    }
    
    @Suite("Direct Static Method Testing")
    struct DirectStaticMethodTests {
        
        @Test("buildExpression with string")
        func buildExpressionWithString() {
            let result = MarkdownBuilder.buildExpression("Test string")
            #expect(result == ["Test string"])
        }
        
        @Test("buildExpression with string array")
        func buildExpressionWithStringArray() {
            let result = MarkdownBuilder.buildExpression(["Line 1", "Line 2"])
            #expect(result == ["Line 1", "Line 2"])
        }
        
        @Test("buildExpression with nested string arrays")
        func buildExpressionWithNestedStringArrays() {
            let result = MarkdownBuilder.buildExpression([["A", "B"], ["C", "D"]])
            #expect(result == ["A", "B", "C", "D"])
        }
        
        @Test("buildExpression with optional string - some")
        func buildExpressionWithOptionalStringSome() {
            let optionalString: String? = "Optional value"
            let result = MarkdownBuilder.buildExpression(optionalString)
            #expect(result == ["Optional value"])
        }
        
        @Test("buildExpression with optional string - none")
        func buildExpressionWithOptionalStringNone() {
            let optionalString: String? = nil
            let result = MarkdownBuilder.buildExpression(optionalString)
            #expect(result == [])
        }
        
        @Test("buildBlock empty")
        func buildBlockEmpty() {
            let result = MarkdownBuilder.buildBlock()
            #expect(result == [])
        }
        
        @Test("buildBlock with strings")
        func buildBlockWithStrings() {
            let result = MarkdownBuilder.buildBlock("Line 1", "Line 2", "Line 3")
            #expect(result == ["Line 1", "Line 2", "Line 3"])
        }
        
        @Test("buildFinalResult")
        func buildFinalResult() {
            let components = ["Line 1", "Line 2", "Line 3"]
            let result = MarkdownBuilder.buildFinalResult(components)
            #expect(result == "Line 1\nLine 2\nLine 3")
        }
        
        @Test("buildFinalResult empty")
        func buildFinalResultEmpty() {
            let result = MarkdownBuilder.buildFinalResult([])
            #expect(result == "")
        }
    }
}
