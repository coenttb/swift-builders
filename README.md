# swift-builders

<p align="center">
  <img src="https://img.shields.io/badge/Swift-6.0-orange.svg" alt="Swift 6.0">
  <img src="https://img.shields.io/badge/Platforms-macOS%20|%20iOS%20|%20tvOS%20|%20watchOS%20|%20Linux-lightgray.svg" alt="Platforms">
  <img src="https://img.shields.io/badge/License-AGPL%203.0-blue.svg" alt="License">
  <img src="https://img.shields.io/badge/Tests-144%20passing-green.svg" alt="Tests">
</p>

<p align="center">
  <strong>Declarative collection and content builders for Swift</strong><br>
  Create arrays, sets, strings, and markdown with SwiftUI-like result builder syntax
</p>

## Overview

**swift-builders** provides a comprehensive collection of Swift Result Builders that transform how you create and manipulate data structures. Using familiar SwiftUI-style syntax, build complex collections and content with type safety, performance optimization, and clean, readable code.

```swift
import ArrayBuilder
import StringBuilder
import SetBuilder

// Build complex arrays declaratively
let menuItems = Array<String> {
    "Home"
    "About"
    if user.isAuthenticated {
        "Dashboard"
        "Profile"
    }
    for feature in enabledFeatures {
        feature.menuTitle
    }
}

// Generate configuration strings
let config = String {
    "# Server Configuration"
    "Host: \(serverHost)"
    "Port: \(serverPort)"
    if sslEnabled {
        "SSL: Enabled"
        "Certificate: \(certPath)"
    }
}

// Create unique collections
let permissions = Set<Permission> {
    .read
    .write
    userRole.defaultPermissions
    if user.isAdmin {
        [.admin, .delete]
    }
}
```

## Why swift-builders?

### 🏗️ Declarative Syntax
- **SwiftUI-like patterns**: Familiar syntax for Swift developers
- **Readable code**: Express intent clearly with minimal boilerplate
- **Natural flow**: Write code that reads like the data structure you're building

### 🛡️ Type Safety
- **Compile-time validation**: Catch errors before runtime
- **Generic support**: Full type inference and safety across all builders
- **IDE integration**: Complete autocomplete and refactoring support

### ⚡ Performance Optimized
- **Zero overhead**: Compile-time transformations with no runtime cost
- **Memory efficient**: Optimized operations avoid unnecessary allocations
- **Scalable**: Tested with large datasets (1000+ elements)

### 🔧 Production Ready
- **Complete API coverage**: All Swift result builder methods implemented
- **Comprehensive tests**: 144 tests covering edge cases and real-world usage
- **Battle tested**: Used in production applications

## Requirements

- Swift 5.10+ (Full Swift 6.0 support)

## Quick Start

### Installation

Add swift-builders to your Swift package:

```swift
dependencies: [
    .package(url: "https://github.com/coenttb/swift-builders.git", from: "0.0.1")
]
```

For Xcode projects, add the package URL: `https://github.com/coenttb/swift-builders`

### Your First Builder

```swift
import ArrayBuilder

struct NavigationMenu {
    let user: User
    
    var items: [String] {
        Array {
            "Home"
            "About"
            if user.isAuthenticated {
                "Dashboard"
                "Settings"
            }
            if user.isAdmin {
                "Admin Panel"
            }
        }
    }
}

// Simple and clean
let menu = NavigationMenu(user: currentUser)
print(menu.items) // ["Home", "About", "Dashboard", "Settings"]
```

## Core Builders

### 🔤 ArrayBuilder

Build arrays with SwiftUI-like syntax:

```swift
import ArrayBuilder

// Type-safe array construction
let items = Array<String> {
    "Always included"
    if condition { "Conditional item" }
    for item in collection { item.name }
}

// Perfect for UI data sources
let tableRows = Array<TableRow> {
    HeaderRow()
    ContentRows(from: data)
    if showFooter { FooterRow() }
}
```

### 📝 StringBuilder  

Generate strings with automatic formatting:

```swift
import StringBuilder

// Configuration files
let config = String {
    "# Application Config"
    "version: \(appVersion)"
    if isProduction {
        "environment: production"
        "debug: false"
    } else {
        "environment: development"  
        "debug: true"
    }
}

// Log messages
let logEntry = String {
    "[\(timestamp)]"
    "[\(level.uppercased())]"
    message
    if let error = error {
        "Error: \(error.localizedDescription)"
    }
}
```

### 📄 MarkdownBuilder

Create Markdown with intelligent formatting:

```swift
import MarkdownBuilder

// Standard formatting (single newlines)
let readme = String(markdown: {
    "# Project Title"
    "Brief description here"
    for feature in features {
        "- \(feature.name): \(feature.description)"
    }
})

// Paragraph formatting (double newlines for sections)
let documentation = String(markdownWithParagraphs: {
    "# Getting Started"
    ""
    "This guide will help you get started."
    ""
    "## Installation" 
    ""
    for step in installSteps {
        "1. \(step)"
    }
})
```

### 🎯 SetBuilder

Build sets with automatic deduplication:

```swift
import SetBuilder

// Permission systems
let userPermissions = Set<Permission> {
    .read
    .write
    rolePermissions
    if user.isAdmin {
        [.admin, .delete, .create]
    }
}

// Tag collections  
let articleTags = Set<String> {
    "swift"
    "programming"
    category.defaultTags
    if article.isFeatured {
        "featured"
    }
}
```

## Real-World Examples

### 🏗️ API Response Building

```swift
import ArrayBuilder

struct APIResponse {
    let users: [User]
    let includeInactive: Bool
    
    var responseData: [UserData] {
        Array {
            // Always include active users
            users.filter(\.isActive).map(\.data)
            
            // Conditionally include inactive users
            if includeInactive {
                users.filter { !$0.isActive }.map(\.data)
            }
            
            // Add system users for admin responses
            if currentUser.isAdmin {
                SystemUser.all.map(\.data)
            }
        }
    }
}
```

### 📧 Email Template Generation

```swift
import StringBuilder
import MarkdownBuilder

struct WelcomeEmail {
    let user: User
    let features: [Feature]
    
    var subject: String {
        String {
            "Welcome to \(AppConfig.name),"
            user.firstName
        }
    }
    
    var body: String {
        String(markdown: {
            "# Welcome, \(user.firstName)!"
            ""
            "Thank you for joining \(AppConfig.name). Here's what you can do:"
            ""
            for feature in features {
                "- **\(feature.name)**: \(feature.description)"
            }
            ""
            if user.isPremium {
                "## Premium Features"
                ""
                "As a premium member, you also have access to:"
                for premium in PremiumFeature.allCases {
                    "- \(premium.displayName)"
                }
            }
        })
    }
}
```

### 🎮 Game Configuration

```swift
import SetBuilder
import ArrayBuilder

struct GameSession {
    let players: [Player]
    let gameMode: GameMode
    
    var availablePowerUps: Set<PowerUp> {
        Set {
            // Base power-ups for all games
            PowerUp.basic
            
            // Mode-specific power-ups
            gameMode.defaultPowerUps
            
            // Player-unlocked power-ups
            for player in players {
                player.unlockedPowerUps
            }
            
            // Special event power-ups
            if Event.current?.isActive == true {
                Event.current!.specialPowerUps
            }
        }
    }
}
```

### 🌐 Server Route Configuration

```swift
import ArrayBuilder

struct APIRouter {
    let isProduction: Bool
    let features: FeatureFlags
    
    var routes: [Route] {
        Array {
            // Core API routes
            Route.health
            Route.auth
            
            // Feature-gated routes
            if features.userManagement {
                Route.users
                Route.profiles
            }
            
            if features.analytics {
                Route.analytics
                Route.metrics
            }
            
            // Development-only routes
            if !isProduction {
                Route.debug
                Route.testData
            }
            
            // Admin routes
            if features.adminPanel {
                for adminRoute in AdminRoute.allCases {
                    adminRoute.route
                }
            }
        }
    }
}
```

## Architecture

swift-builders provides six specialized result builders:

```
swift-builders
    ├── ArrayBuilder        → Generic array construction
    ├── SetBuilder          → Unique element collections
    ├── StringBuilder       → Text content generation
    └── MarkdownBuilder     → Documentation and markup
```

Each builder is optimized for its specific use case while maintaining consistent APIs.

## Testing

swift-builders includes comprehensive test coverage with 144+ tests:

```swift
import Testing
import ArrayBuilder

@Suite("ArrayBuilder Tests")
struct ArrayBuilderTests {
    @Test("Conditional arrays")
    func conditionalArrays() {
        let items = Array<String> {
            "always"
            if true { "conditional" }
            for i in 1...3 { "item-\(i)" }
        }
        #expect(items.count == 5)
    }
}
```

**Test Coverage:**
- ✅ Basic functionality for all builders
- ✅ Control flow (conditionals, loops, optionals)
- ✅ Edge cases and error conditions  
- ✅ Performance characteristics
- ✅ Real-world usage patterns

Run tests with:
```bash
swift test
```

## Performance

All builders are optimized for production use with zero runtime overhead:

- **🚀 Compile-time**: All builder logic happens at compile time
- **💾 Memory Efficient**: Optimized operations avoid unnecessary allocations
- **📊 Scalable**: Tested with large datasets (1000+ elements)
- **⚡ Fast**: Direct operations without intermediate transformations

Benchmark results show consistent performance regardless of collection size.

## Documentation

Comprehensive documentation is available:

- 📚 **[API Reference](Sources/)** - Complete API documentation
- 🏗️ **[Builder Guides](Tests/)** - Detailed examples for each builder
- 🎯 **[Best Practices](README.md#real-world-examples)** - Production patterns and tips
- 🧪 **[Testing Examples](Tests/)** - How to test builder-based code

## Support

- 🐛 **[Issue Tracker](https://github.com/coenttb/swift-builders/issues)** - Report bugs or request features
- 💬 **[Discussions](https://github.com/coenttb/swift-builders/discussions)** - Ask questions and share ideas
- 📧 **[Newsletter](http://coenttb.com/en/newsletter/subscribe)** - Stay updated with new releases
- 🐦 **[X (Twitter)](http://x.com/coenttb)** - Follow for updates
- 💼 **[LinkedIn](https://www.linkedin.com/in/tenthijeboonkkamp)** - Connect professionally

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Add tests for your changes
4. Ensure all tests pass (`swift test`)
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## License

This project is licensed under the Apache License 2.0. See [LICENSE](LICENSE) for details.

### Examples in Production

- **[coenttb.com](https://github.com/coenttb/coenttb-com-server)** - Full website built using swift-builders
  - Real-world usage patterns
  - Production-ready architecture
  - Performance optimizations

---

<p align="center">
  Made with ❤️ by <a href="https://coenttb.com">Coen ten Thije Boonkkamp</a><br>
</p>
