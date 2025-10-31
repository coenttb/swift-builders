//
//  StringBuilder Tests.swift
//  swift-builders
//
//  Created by Coen ten Thije Boonkkamp on 29/07/2025.
//

import Foundation
import Testing

@testable import StringBuilder

@Suite("StringBuilder Tests")
struct StringBuilderTests {

  @Suite("Basic String Building")
  struct BasicStringBuildingTests {

    @Test("Single string")
    func singleString() {
      let result = String {
        "Hello World"
      }
      #expect(result == "Hello World")
    }

    @Test("Multiple strings joined with newlines")
    func multipleStringsJoinedWithNewlines() {
      let result = String {
        "First line"
        "Second line"
        "Third line"
      }
      #expect(result == "First line\nSecond line\nThird line")
    }

    @Test("Empty string building")
    func emptyStringBuilding() {
      let result = String {
        ""
      }
      #expect(result == "")
    }
  }

  @Suite("Control Flow")
  struct ControlFlowTests {

    @Test("Conditional strings - if true")
    func conditionalStringsIfTrue() {
      let includeGreeting = true
      let result = String {
        if includeGreeting {
          "Hello"
        } else {
          "Goodbye"
        }
        "World"
      }
      #expect(result == "Hello\nWorld")
    }

    @Test("Conditional strings - if false")
    func conditionalStringsIfFalse() {
      let includeGreeting = false
      let result = String {
        if includeGreeting {
          "Hello"
        } else {
          "Goodbye"
        }
        "World"
      }
      #expect(result == "Goodbye\nWorld")
    }

    @Test("Optional strings - some")
    func optionalStringsSome() {
      let optionalLine: String? = "Optional content"
      let result = String {
        "Start"
        if let line = optionalLine {
          line
        }
        "End"
      }
      #expect(result == "Start\nOptional content\nEnd")
    }

    @Test("Optional strings - none")
    func optionalStringsNone() {
      let optionalLine: String? = nil
      let result = String {
        "Start"
        if let line = optionalLine {
          line
        }
        "End"
      }
      #expect(result == "Start\n\nEnd")
    }

    @Test("For loop string building")
    func forLoopStringBuilding() {
      let result = String {
        "Header"
        for i in 1...3 {
          "Item \(i)"
        }
        "Footer"
      }
      #expect(result == "Header\nItem 1\nItem 2\nItem 3\nFooter")
    }
  }

  @Suite("Real-World Usage Patterns")
  struct RealWorldUsagePatternsTests {

    @Test("Building configuration text")
    func buildingConfigurationText() {
      let debugMode = true
      let version = "1.0.0"

      let config = String {
        "Application Configuration"
        "Version: \(version)"
        if debugMode {
          "Debug Mode: Enabled"
          "Log Level: Verbose"
        } else {
          "Debug Mode: Disabled"
          "Log Level: Error"
        }
        "Status: Ready"
      }

      let expected = """
        Application Configuration
        Version: 1.0.0
        Debug Mode: Enabled
        Log Level: Verbose
        Status: Ready
        """
      #expect(config == expected)
    }

    @Test("Building error messages")
    func buildingErrorMessages() {
      let errors = ["Invalid input", "Missing field", "Timeout occurred"]

      let errorReport = String {
        "Error Report:"
        "============"
        for error in errors {
          "• \(error)"
        }
        "Total errors: \(errors.count)"
      }

      let expected = """
        Error Report:
        ============
        • Invalid input
        • Missing field
        • Timeout occurred
        Total errors: 3
        """
      #expect(errorReport == expected)
    }

    @Test("Building formatted output")
    func buildingFormattedOutput() {
      let items = ["Apple", "Banana", "Cherry"]
      let showNumbers = true

      let output = String {
        "Item List:"
        "---------"
        for (index, item) in items.enumerated() {
          if showNumbers {
            "\(index + 1). \(item)"
          } else {
            "- \(item)"
          }
        }
      }

      let expected = """
        Item List:
        ---------
        1. Apple
        2. Banana
        3. Cherry
        """
      #expect(output == expected)
    }
  }

  @Suite("Edge Cases")
  struct EdgeCasesTests {

    @Test("Empty strings in builder")
    func emptyStringsInBuilder() {
      let result = String {
        "Start"
        ""
        "Middle"
        ""
        "End"
      }
      #expect(result == "Start\n\nMiddle\n\nEnd")
    }

    @Test("Nested conditionals")
    func nestedConditionals() {
      let condition1 = true
      let condition2 = false

      let result = String {
        "Begin"
        if condition1 {
          "Condition 1 is true"
          if condition2 {
            "Condition 2 is also true"
          } else {
            "But condition 2 is false"
          }
        }
        "End"
      }

      let expected = """
        Begin
        Condition 1 is true
        But condition 2 is false
        End
        """
      #expect(result == expected)
    }

    @Test("Large string building")
    func largeStringBuilding() {
      let result = String {
        "Large String Test"
        for i in 1...100 {
          "Line \(i)"
        }
        "End of large string"
      }

      let lines = result.components(separatedBy: "\n")
      #expect(lines.count == 102)  // Header + 100 lines + footer
      #expect(lines.first == "Large String Test")
      #expect(lines.last == "End of large string")
      #expect(lines[1] == "Line 1")
      #expect(lines[100] == "Line 100")
    }

    @Test("Special characters and unicode")
    func specialCharactersAndUnicode() {
      let result = String {
        "Special Characters Test"
        "Emoji: 🚀 🎉 ✨"
        "Unicode: áéíóú ñ"
        "Symbols: @#$%^&*()"
        "Quotes: \"Hello\" 'World'"
      }

      #expect(result.contains("🚀"))
      #expect(result.contains("áéíóú"))
      #expect(result.contains("\"Hello\""))
    }
  }

  @Suite("Performance Characteristics")
  struct PerformanceCharacteristicsTests {

    @Test("Efficient string concatenation")
    func efficientStringConcatenation() {
      let lines = (1...1000).map { "Line \($0)" }

      let result = String {
        "Performance Test"
        for line in lines {
          line
        }
        "End Performance Test"
      }

      let resultLines = result.components(separatedBy: "\n")
      #expect(resultLines.count == 1002)  // Header + 1000 lines + footer
      #expect(resultLines.first == "Performance Test")
      #expect(resultLines.last == "End Performance Test")
    }
  }

  @Suite("Direct Static Method Testing")
  struct DirectStaticMethodTests {

    @Test("buildPartialBlock first")
    func buildPartialBlockFirst() {
      let result = StringBuilder.buildPartialBlock(first: "First string")
      #expect(result == "First string")
    }

    @Test("buildPartialBlock accumulated and next")
    func buildPartialBlockAccumulatedAndNext() {
      let result = StringBuilder.buildPartialBlock(accumulated: "First", next: "Second")
      #expect(result == "First\nSecond")
    }

    @Test("buildEither first")
    func buildEitherFirst() {
      let result = StringBuilder.buildEither(first: "First option")
      #expect(result == "First option")
    }

    @Test("buildEither second")
    func buildEitherSecond() {
      let result = StringBuilder.buildEither(second: "Second option")
      #expect(result == "Second option")
    }

    @Test("buildOptional with value")
    func buildOptionalWithValue() {
      let result = StringBuilder.buildOptional("Some value")
      #expect(result == "Some value")
    }

    @Test("buildOptional with nil")
    func buildOptionalWithNil() {
      let result = StringBuilder.buildOptional(nil)
      #expect(result == "")
    }

    @Test("buildArray")
    func buildArray() {
      let components = ["Line 1", "Line 2", "Line 3"]
      let result = StringBuilder.buildArray(components)
      #expect(result == "Line 1\nLine 2\nLine 3")
    }

    @Test("buildArray with empty array")
    func buildArrayWithEmptyArray() {
      let result = StringBuilder.buildArray([])
      #expect(result == "")
    }
  }
}
