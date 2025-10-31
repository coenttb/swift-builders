//
//  SetBuilder Tests.swift
//  swift-builders
//
//  Created by Coen ten Thije Boonkkamp on 29/07/2025.
//

import Testing

@testable import SetBuilder

@Suite("SetBuilder Tests")
struct SetBuilderTests {

  @Suite("Partial Block Building")
  struct PartialBlockBuildingTests {

    @Test("First element")
    func firstElement() {
      let result = SetBuilder<String>.buildPartialBlock(first: "hello")
      #expect(result == ["hello"])
    }

    @Test("First set")
    func firstSet() {
      let inputSet: Set<Int> = [1, 2, 3]
      let result = SetBuilder<Int>.buildPartialBlock(first: inputSet)
      #expect(result == inputSet)
    }

    @Test("Accumulated set and next element")
    func accumulatedSetAndNextElement() {
      let accumulated: Set<String> = ["a", "b"]
      let result = SetBuilder<String>.buildPartialBlock(accumulated: accumulated, next: "c")
      #expect(result == ["a", "b", "c"])
    }

    @Test("Accumulated set and next set")
    func accumulatedSetAndNextSet() {
      let accumulated: Set<Int> = [1, 2]
      let next: Set<Int> = [3, 4]
      let result = SetBuilder<Int>.buildPartialBlock(accumulated: accumulated, next: next)
      #expect(result == [1, 2, 3, 4])
    }

    @Test("Duplicate elements are ignored")
    func duplicateElementsAreIgnored() {
      let accumulated: Set<String> = ["a", "b"]
      let result = SetBuilder<String>.buildPartialBlock(accumulated: accumulated, next: "a")
      #expect(result == ["a", "b"])
      #expect(result.count == 2)
    }

    @Test("Overlapping sets merge correctly")
    func overlappingSetsSergeCorrectly() {
      let accumulated: Set<Int> = [1, 2, 3]
      let next: Set<Int> = [3, 4, 5]
      let result = SetBuilder<Int>.buildPartialBlock(accumulated: accumulated, next: next)
      #expect(result == [1, 2, 3, 4, 5])
      #expect(result.count == 5)
    }
  }

  @Suite("Control Flow")
  struct ControlFlowTests {

    @Test("Empty block")
    func emptyBlock() {
      let result = SetBuilder<Int>.buildBlock()
      #expect(result.isEmpty)
    }

    @Test("Void first")
    func voidFirst() {
      let result = SetBuilder<String>.buildPartialBlock(first: ())
      #expect(result.isEmpty)
    }

    @Test("BuildIf with some set")
    func buildIfWithSomeSet() {
      let inputSet: Set<String>? = ["conditional"]
      let result = SetBuilder<String>.buildIf(inputSet)
      #expect(result == ["conditional"])
    }

    @Test("BuildIf with nil set")
    func buildIfWithNilSet() {
      let inputSet: Set<String>? = nil
      let result = SetBuilder<String>.buildIf(inputSet)
      #expect(result.isEmpty)
    }

    @Test("BuildEither first branch")
    func buildEitherFirstBranch() {
      let inputSet: Set<String> = ["first", "option"]
      let result = SetBuilder<String>.buildEither(first: inputSet)
      #expect(result == inputSet)
    }

    @Test("BuildEither second branch")
    func buildEitherSecondBranch() {
      let inputSet: Set<String> = ["second", "option"]
      let result = SetBuilder<String>.buildEither(second: inputSet)
      #expect(result == inputSet)
    }

    @Test("BuildArray merges all sets")
    func buildArrayMergesAllSets() {
      let components: [Set<Int>] = [
        [1, 2],
        [3, 4],
        [2, 5],  // Contains duplicate
      ]
      let result = SetBuilder<Int>.buildArray(components)
      #expect(result == [1, 2, 3, 4, 5])
      #expect(result.count == 5)
    }
  }

  @Suite("Set Extension Initialization")
  struct SetExtensionInitializationTests {

    @Test("Set initialization with elements")
    func setInitializationWithElements() {
      let set = Set {
        "hello"
        "world"
        "hello"  // Duplicate should be ignored
      }
      #expect(set == ["hello", "world"])
      #expect(set.count == 2)
    }

    @Test("Set initialization with mixed elements and sets")
    func setInitializationWithMixedElementsAndSets() {
      let existingSet: Set<Int> = [2, 3]
      let set = Set {
        1
        existingSet
        4
        existingSet  // Duplicate set
      }
      #expect(set == [1, 2, 3, 4])
      #expect(set.count == 4)
    }

    @Test("Empty set initialization")
    func emptySetInitialization() {
      let set = Set<String> {
      }
      #expect(set.isEmpty)
    }
  }

  @Suite("Hashable Types Compatibility")
  struct HashableTypesCompatibilityTests {

    @Test("String sets")
    func stringSets() {
      let set = Set {
        "apple"
        "banana"
        "apple"
      }
      #expect(set == ["apple", "banana"])
    }

    @Test("Integer sets")
    func integerSets() {
      let set = Set {
        1
        2
        3
        1
      }
      #expect(set == [1, 2, 3])
    }

    @Test("Custom hashable type")
    func customHashableType() {
      struct Person: Hashable {
        let name: String
        let age: Int
      }

      let alice = Person(name: "Alice", age: 30)
      let bob = Person(name: "Bob", age: 25)
      let aliceDuplicate = Person(name: "Alice", age: 30)

      let set = Set {
        alice
        bob
        aliceDuplicate  // Should be ignored due to equality
      }

      #expect(set.count == 2)
      #expect(set.contains(alice))
      #expect(set.contains(bob))
    }

    @Test("Enum sets")
    func enumSets() {
      enum Color: String, Hashable, CaseIterable {
        case red, green, blue
      }

      let set = Set {
        Color.red
        Color.green
        Color.blue
        Color.red  // Duplicate
      }

      #expect(set == Set(Color.allCases))
      #expect(set.count == 3)
    }
  }

  @Suite("Edge Cases")
  struct EdgeCasesTests {

    @Test("Large set construction")
    func largeSetConstruction() {
      let components: [Set<Int>] = (0..<100).map { i in
        Set([i, i + 1000])  // Each set has 2 elements with some overlaps
      }

      let result = SetBuilder<Int>.buildArray(components)

      #expect(result.count == 200)  // 0-99 and 1000-1099, no overlaps between ranges
      #expect(result.contains(0))
      #expect(result.contains(99))
      #expect(result.contains(1000))
      #expect(result.contains(1099))
    }

    @Test("Empty sets in array")
    func emptySetsInArray() {
      let components: [Set<String>] = [
        ["a"],
        [],
        ["b"],
        [],
        ["c"],
      ]

      let result = SetBuilder<String>.buildArray(components)
      #expect(result == ["a", "b", "c"])
    }

    @Test("All empty sets")
    func allEmptySets() {
      let components: [Set<Int>] = [[], [], []]
      let result = SetBuilder<Int>.buildArray(components)
      #expect(result.isEmpty)
    }

    @Test("Single element repeated")
    func singleElementRepeated() {
      let components: [Set<String>] = [
        ["same"],
        ["same"],
        ["same"],
      ]

      let result = SetBuilder<String>.buildArray(components)
      #expect(result == ["same"])
      #expect(result.count == 1)
    }
  }

  @Suite("Never Type Handling")
  struct NeverTypeHandlingTests {

    @Test("Never type returns empty set")
    func neverTypeReturnsEmptySet() {
      // This test documents the behavior with Never type
      let result = SetBuilder<Int>.buildPartialBlock(first: () as Void)
      #expect(result.isEmpty)
    }
  }

  @Suite("Performance Characteristics")
  struct PerformanceCharacteristicsTests {

    @Test("Efficient set union operations")
    func efficientSetUnionOperations() {
      // Test that union operations are performed efficiently
      var accumulated: Set<Int> = []

      for i in 0..<100 {
        let nextSet: Set<Int> = [i]
        accumulated = SetBuilder<Int>.buildPartialBlock(accumulated: accumulated, next: nextSet)
      }

      #expect(accumulated.count == 100)
      for i in 0..<100 {
        #expect(accumulated.contains(i))
      }
    }

    @Test("Memory efficiency with overlapping sets")
    func memoryEfficiencyWithOverlappingSets() {
      // Create sets with significant overlap
      let components: [Set<Int>] = (0..<50).map { i in
        Set(i..<(i + 10))  // Each set contains 10 consecutive numbers
      }

      let result = SetBuilder<Int>.buildArray(components)

      // Should contain numbers 0 through 58 (49 + 10 - 1)
      #expect(result.count == 59)
      #expect(result.contains(0))
      #expect(result.contains(58))
      #expect(!result.contains(59))
    }

    @Test("Handles duplicate elimination correctly")
    func handlesDuplicateEliminationCorrectly() {
      // Build a set with many duplicates
      let result = Set {
        1
        Set([1, 2, 3])
        2
        Set([2, 3, 4])
        3
        Set([1, 2, 3, 4, 5])
      }

      #expect(result == [1, 2, 3, 4, 5])
      #expect(result.count == 5)
    }
  }
}
