// swift-tools-version:5.10

import PackageDescription

extension String {
    static let builders: Self = "Builders"
    static let arrayBuilder: Self = "ArrayBuilder"
    static let dictionaryBuilder: Self = "DictionaryBuilder"
    static let setBuilder: Self = "SetBuilder"
    static let stringBuilder: Self = "StringBuilder"
    static let markdownBuilder: Self = "MarkdownBuilder"
}

extension Target.Dependency {
    static var builders: Self { .target(name: .builders) }
    static var arrayBuilder: Self { .target(name: .arrayBuilder) }
    static var dictionaryBuilder: Self { .target(name: .dictionaryBuilder) }
    static var setBuilder: Self { .target(name: .setBuilder) }
    static var stringBuilder: Self { .target(name: .stringBuilder) }
    static var markdownBuilder: Self { .target(name: .markdownBuilder) }
}

let package = Package(
    name: "swift-builders",
    products: [
        .library(
            name: .builders,
            targets: [
                .builders,
                .arrayBuilder,
                .dictionaryBuilder,
                .setBuilder,
                .stringBuilder,
                .markdownBuilder,
            ]
        ),
        .library(
            name: .arrayBuilder,
            targets: [.arrayBuilder]
        ),
        .library(
            name: .setBuilder,
            targets: [.setBuilder]
        ),
        .library(
            name: .stringBuilder,
            targets: [.stringBuilder]
        ),
        .library(
            name: .dictionaryBuilder,
            targets: [.dictionaryBuilder]
        ),
        .library(
            name: .markdownBuilder,
            targets: [.markdownBuilder]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: .builders,
            dependencies: [
                .arrayBuilder,
                .dictionaryBuilder,
                .setBuilder,
                .stringBuilder,
                .markdownBuilder,
            ]
        ),
        .testTarget(
            name: .builders.tests,
            dependencies: [
                .builders,
            ]
        ),
        .target(name: .arrayBuilder),
        .testTarget(
            name: .arrayBuilder.tests,
            dependencies: [
                .arrayBuilder,
            ]
        ),
        .target(name: .dictionaryBuilder),
        .testTarget(
            name: .dictionaryBuilder.tests,
            dependencies: [
                .dictionaryBuilder,
            ]
        ),
        .target(name: .setBuilder),
        .testTarget(
            name: .setBuilder.tests,
            dependencies: [
                .setBuilder,
            ]
        ),
        .target(name: .stringBuilder),
        .testTarget(
            name: .stringBuilder.tests,
            dependencies: [
                .stringBuilder,
            ]
        ),
        .target(name: .markdownBuilder),
        .testTarget(
            name: .markdownBuilder.tests,
            dependencies: [
                .markdownBuilder,
            ]
        ),
    ],
)

extension String { var tests: Self { self + " Tests" } }
