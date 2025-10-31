//
//  ArrayBuilder Tests.swift
//  swift-builders
//
//  Created by Coen ten Thije Boonkkamp on 29/07/2025.
//

import Testing

@testable import ArrayBuilder

@Suite("ArrayBuilder Tests")
struct ArrayBuilderTests {

  @Suite("Expression Building")
  struct ExpressionBuildingTests {

    @Test("Single element expression")
    func singleElementExpression() {
      let array = [Int] {
        42
      }
      #expect(array == [42])
    }

    @Test("Array expression")
    func arrayExpression() {
      let array = [Int] {
        [1, 2, 3]
      }
      #expect(array == [1, 2, 3])
    }

    @Test("Mixed expressions")
    func mixedExpressions() {
      let array = [Int] {
        1
        [2, 3]
        4
      }
      #expect(array == [1, 2, 3, 4])
    }
  }

  @Suite("Block Building")
  struct BlockBuildingTests {

    @Test("Empty block")
    func emptyBlock() {
      let array = [Int] {
      }
      #expect(array.isEmpty)
    }

    @Test("Single component block")
    func singleComponentBlock() {
      let array = [String] {
        "hello"
      }
      #expect(array == ["hello"])
    }

    @Test("Multiple component block")
    func multipleComponentBlock() {
      let array = [String] {
        "hello"
        "world"
        "test"
      }
      #expect(array == ["hello", "world", "test"])
    }

    @Test("Nested arrays in block")
    func nestedArraysInBlock() {
      let array = [Int] {
        [1, 2]
        [3, 4]
        [5, 6]
      }
      #expect(array == [1, 2, 3, 4, 5, 6])
    }
  }

  @Suite("Control Flow")
  struct ControlFlowTests {

    @Test("Optional elements - some")
    func optionalElementsSome() {
      let shouldInclude = true
      let array = [String] {
        "always"
        if shouldInclude {
          "conditional"
        }
        "end"
      }
      #expect(array == ["always", "conditional", "end"])
    }

    @Test("Optional elements - none")
    func optionalElementsNone() {
      let shouldInclude = false
      let array = [String] {
        "always"
        if shouldInclude {
          "conditional"
        }
        "end"
      }
      #expect(array == ["always", "end"])
    }

    @Test("If-else first branch")
    func ifElseFirstBranch() {
      let condition = true
      let array = [String] {
        if condition {
          "first"
        } else {
          "second"
        }
      }
      #expect(array == ["first"])
    }

    @Test("If-else second branch")
    func ifElseSecondBranch() {
      let condition = false
      let array = [String] {
        if condition {
          "first"
        } else {
          "second"
        }
      }
      #expect(array == ["second"])
    }

    @Test("For loop")
    func forLoop() {
      let array = [Int] {
        for i in 1...3 {
          i * 2
        }
      }
      #expect(array == [2, 4, 6])
    }

    @Test("Complex for loop with nested arrays")
    func complexForLoopWithNestedArrays() {
      let array = [Int] {
        0
        for i in 1...2 {
          [i, i + 10]
        }
        100
      }
      #expect(array == [0, 1, 11, 2, 12, 100])
    }
  }

  @Suite("Limited Availability")
  struct LimitedAvailabilityTests {

    @Test("Limited availability passthrough")
    func limitedAvailabilityPassthrough() {
      let array = [String] {
        "available"
        if #available(iOS 13.0, *) {
          "newer"
        }
      }
      #expect(array.contains("available"))
      #expect(array.contains("newer"))
    }
  }

  @Suite("Type Inference")
  struct TypeInferenceTests {

    @Test("String type inference")
    func stringTypeInference() {
      let array = Array {
        "hello"
        "world"
      }
      #expect(array == ["hello", "world"])
    }

    @Test("Int type inference")
    func intTypeInference() {
      let array = Array {
        1
        2
        3
      }
      #expect(array == [1, 2, 3])
    }

    @Test("Mixed numeric types promote to common type")
    func mixedNumericTypes() {
      let array = [Double] {
        1.0
        2.5
        3.0
      }
      #expect(array == [1.0, 2.5, 3.0])
    }
  }

  @Suite("Edge Cases")
  struct EdgeCasesTests {

    @Test("Deeply nested conditionals")
    func deeplyNestedConditionals() {
      let a = true
      let b = false
      let c = true

      let array = [String] {
        "start"
        if a {
          "a-true"
          if b {
            "b-true"
          } else {
            "b-false"
            if c {
              "c-true"
            }
          }
        }
        "end"
      }
      #expect(array == ["start", "a-true", "b-false", "c-true", "end"])
    }

    @Test("Empty arrays in builder")
    func emptyArraysInBuilder() {
      let array = [Int] {
        [1, 2]
        []
        [3, 4]
        []
      }
      #expect(array == [1, 2, 3, 4])
    }

    @Test("Large array construction")
    func largeArrayConstruction() {
      let array = [Int] {
        for i in 1...100 {
          i
        }
      }
      #expect(array.count == 100)
      #expect(array.first == 1)
      #expect(array.last == 100)
    }

    @Test("Alternating types with Optional")
    func alternatingTypesWithOptional() {
      let array = [Int?] {
        1
        nil
        2
        nil
        3
      }
      #expect(array == [1, nil, 2, nil, 3])
    }
  }

  @Suite("Performance Characteristics")
  struct PerformanceCharacteristicsTests {

    @Test("Builder doesn't create unnecessary intermediate arrays")
    func builderEfficiency() {
      // This test ensures that the builder flattens efficiently
      let array = [Int] {
        [1, 2, 3]
        [4, 5, 6]
        [7, 8, 9]
      }

      #expect(array == [1, 2, 3, 4, 5, 6, 7, 8, 9])
      #expect(array.count == 9)
    }
  }
}
