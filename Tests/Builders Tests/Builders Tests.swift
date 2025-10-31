import Builders
import Testing

@Suite("Builders Tests")
struct BuildersTests {

  @Suite("ArrayBuilder Examples")
  struct ArrayBuilderExamples {

    @Test("Simple array construction")
    func simpleArrayConstruction() {
      let numbers = [Int] {
        1
        2
        3
      }
      #expect(numbers == [1, 2, 3])
    }

    @Test("Conditional array construction")
    func conditionalArrayConstruction() {
      let includeOptional = true
      let items = [String] {
        "always"
        "included"
        if includeOptional {
          "conditional"
        }
      }
      #expect(items == ["always", "included", "conditional"])
    }
  }

  @Suite("SetBuilder Examples")
  struct SetBuilderExamples {

    @Test("Set with duplicates")
    func setWithDuplicates() {
      let result = Set<Int> {
        1
        2
        1  // duplicate
        3
      }
      #expect(result == Set([1, 2, 3]))
    }

    @Test("Set with arrays")
    func setWithArrays() {
      let tags = Set<String> {
        "swift"
        ["programming", "ios"]
        Set(["swift", "mobile"])  // "swift" is duplicate
      }
      #expect(tags == Set(["swift", "programming", "ios", "mobile"]))
    }
  }

  @Suite("StringBuilder Examples")
  struct StringBuilderExamples {

    @Test("Simple string building")
    func simpleStringBuilding() {
      // Test that String {} defaults to StringBuilder
      let result = String {
        "Line 1"
        "Line 2"
        "Line 3"
      }
      #expect(result == "Line 1\nLine 2\nLine 3")
    }

    @Test("Conditional string building")
    func conditionalStringBuilding() {
      let isDebug = true
      // Test that String {} defaults to StringBuilder
      let config = String {
        "App Config"
        "Version: 1.0"
        if isDebug {
          "Debug: enabled"
        }
      }
      #expect(config == "App Config\nVersion: 1.0\nDebug: enabled")
    }
  }

  @Suite("MarkdownBuilder Examples")
  struct MarkdownBuilderExamples {

    @Test("Simple markdown building")
    func simpleMarkdownBuilding() {
      // Use explicit parameter name to resolve ambiguity
      let result = String(markdown: {
        "# Title"
        "This is content"
        "More content"
      })
      #expect(result == "# Title\nThis is content\nMore content")
    }

    @Test("Markdown with arrays")
    func markdownWithArrays() {
      let features = ["Feature A", "Feature B"]
      // Use explicit parameter name to resolve ambiguity
      let doc = String(markdown: {
        "# Project"
        "## Features"
        for feature in features {
          "- \(feature)"
        }
      })
      #expect(doc == "# Project\n## Features\n- Feature A\n- Feature B")
    }
  }
}
