//
//  DictionaryBuilder Tests.swift
//  swift-builders
//
//  Created by Coen ten Thije Boonkkamp on 30/07/2025.
//

import Testing

@testable import DictionaryBuilder

@Suite("DictionaryBuilder Tests")
struct DictionaryBuilderTests {

  @Test("Basic tuple construction")
  func basicTupleConstruction() {
    let dict = [String: String] {
      ("key", "value")
    }
    #expect(dict == ["key": "value"])
  }

  @Test("Multiple tuples")
  func multipleTuples() {
    let dict = [String: Int] {
      ("a", 1)
      ("b", 2)
    }
    #expect(dict == ["a": 1, "b": 2])
  }

  @Test("KeyValuePair construction")
  func keyValuePairConstruction() {
    let dict = [String: String] {
      KeyValuePair("host", "localhost")
    }
    #expect(dict == ["host": "localhost"])
  }

  @Test("DictionaryLiteral construction")
  func dictionaryLiteralConstruction() {
    let dict = [String: String] {
      ["host": "localhost"]
    }
    #expect(dict == ["host": "localhost"])
  }

  @Test("Dictionary merging")
  func dictionaryMerging() {
    let existing = ["a": 1, "b": 2]
    let dict = [String: Int] {
      existing
      ("c", 3)
    }
    #expect(dict == ["a": 1, "b": 2, "c": 3])
  }

  @Test("Conditional elements")
  func conditionalElements() {
    let includePort = true
    let dict = [String: String] {
      ("host", "localhost")
      if includePort {
        ("port", "8080")
      }
    }
    #expect(dict == ["host": "localhost", "port": "8080"])
  }

  @Test("Key override behavior")
  func keyOverrideBehavior() {
    let dict = [String: String] {
      ("key", "first")
      ("key", "second")
    }
    #expect(dict == ["key": "second"])
  }
}
