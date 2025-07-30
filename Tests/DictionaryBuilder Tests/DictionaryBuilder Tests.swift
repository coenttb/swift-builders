//
//  DictionaryBuilder Tests.swift
//  swift-builders
//
//  Created by Coen ten Thije Boonkkamp on 30/07/2025.
//

@testable import DictionaryBuilder
import Testing

@Suite("DictionaryBuilder Tests")
struct DictionaryBuilderTests {
    
    @Test("Basic tuple construction")
    func basicTupleConstruction() {
        let dict = Dictionary<String, String> {
            ("key", "value")
        }
        #expect(dict == ["key": "value"])
    }
    
    @Test("Multiple tuples")
    func multipleTuples() {
        let dict = Dictionary<String, Int> {
            ("a", 1)
            ("b", 2)
        }
        #expect(dict == ["a": 1, "b": 2])
    }
    
    @Test("KeyValuePair construction")
    func keyValuePairConstruction() {
        let dict = Dictionary<String, String> {
            KeyValuePair("host", "localhost")
        }
        #expect(dict == ["host": "localhost"])
    }
    
    @Test("DictionaryLiteral construction")
    func dictionaryLiteralConstruction() {
        let dict = Dictionary<String, String> {
            ["host": "localhost"]
        }
        #expect(dict == ["host": "localhost"])
    }
    
    @Test("Dictionary merging")
    func dictionaryMerging() {
        let existing = ["a": 1, "b": 2]
        let dict = Dictionary<String, Int> {
            existing
            ("c", 3)
        }
        #expect(dict == ["a": 1, "b": 2, "c": 3])
    }
    
    @Test("Conditional elements")
    func conditionalElements() {
        let includePort = true
        let dict = Dictionary<String, String> {
            ("host", "localhost")
            if includePort {
                ("port", "8080")
            }
        }
        #expect(dict == ["host": "localhost", "port": "8080"])
    }
    
    @Test("Key override behavior")
    func keyOverrideBehavior() {
        let dict = Dictionary<String, String> {
            ("key", "first")
            ("key", "second")
        }
        #expect(dict == ["key": "second"])
    }
}
