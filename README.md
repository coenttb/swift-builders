# swift-builders

[![CI](https://github.com/coenttb/swift-builders/workflows/CI/badge.svg)](https://github.com/coenttb/swift-builders/actions/workflows/ci.yml)
![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Result builder DSL for creating arrays, dictionaries, sets, strings, and markdown in Swift.

## Overview

swift-builders provides Swift result builders for declarative collection and content construction. Each builder supports conditionals, loops, and optional handling with compile-time type safety.

```swift
import ArrayBuilder
import DictionaryBuilder
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

// Build type-safe dictionaries
let configuration = Dictionary<String, String> {
    ("host", serverHost)
    ("port", "\(serverPort)")
    if sslEnabled {
        ("ssl", "true")
        ("cert_path", certPath)
    }
    existingConfig // merge another dictionary
}
```

## Features

- **Five specialized builders**: Array, Dictionary, Set, String, and Markdown
- **Control flow support**: if/else, switch, for-in, and optional handling
- **Type-safe construction**: Full generic type inference and compile-time validation
- **Zero runtime overhead**: All builder logic resolved at compile time
- **112 test cases**: Covering basic functionality, control flow, edge cases, and performance
- **Swift 5.10+ compatible**: Supports Swift 6.0 strict concurrency

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/coenttb/swift-builders.git", from: "0.0.1")
]
```

## Quick Start

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

## Usage

### ArrayBuilder

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

### StringBuilder

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

### MarkdownBuilder

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

### DictionaryBuilder

```swift
import DictionaryBuilder

// Configuration dictionaries
let serverConfig = Dictionary<String, String> {
    ("host", "localhost")
    ("port", "8080")
    if enableSSL {
        ("ssl", "true")
        ("cert_path", "/path/to/cert.pem")
    }
    existingConfig // merge existing dictionary
}

// Using KeyValuePair for better readability
let apiConfig = Dictionary<String, Any> {
    KeyValuePair("timeout", 30)
    KeyValuePair("retries", 3)
    KeyValuePair("base_url", baseURL)
    if isDebugMode {
        KeyValuePair("debug", true)
        KeyValuePair("verbose", true)
    }
}

// Dynamic configuration
let appSettings = Dictionary<String, String> {
    ("app_name", appName)
    ("version", appVersion)
    for (key, value) in environmentVars {
        (key.lowercased(), value)
    }
    if user.isPremium {
        ("tier", "premium")
        ("features", premiumFeatures.joined(separator: ","))
    }
}
```

### SetBuilder

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

## Examples

### API Response Building

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

### Email Template Generation

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

### Game Configuration

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

### Server Route Configuration

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

### Dynamic Configuration System

```swift
import DictionaryBuilder

struct ConfigurationManager {
    let environment: Environment
    let features: FeatureFlags
    let secrets: SecretStore
    
    var databaseConfig: [String: Any] {
        Dictionary {
            ("host", environment.databaseHost)
            ("port", environment.databasePort)
            ("database", environment.databaseName)
            
            // Environment-specific settings
            if environment.isProduction {
                ("pool_size", 20)
                ("timeout", 30)
                ("ssl_mode", "require")
            } else {
                ("pool_size", 5)
                ("timeout", 60)
                ("ssl_mode", "prefer")
            }
            
            // Feature flags
            if features.enableReadReplicas {
                ("read_replica_host", environment.readReplicaHost)
                ("read_replica_port", environment.readReplicaPort)
            }
            
            // Conditional authentication
            if let credentials = secrets.databaseCredentials {
                ("username", credentials.username)
                ("password", credentials.password)
            }
            
            // Merge existing configuration
            environment.customDatabaseSettings
        }
    }
    
    var redisConfig: [String: String] {
        Dictionary {
            ("host", environment.redisHost)
            ("port", "\(environment.redisPort)")
            
            if environment.isProduction {
                ("cluster_mode", "true")
                ("max_connections", "100")
            }
            
            // Add authentication if available
            if let auth = secrets.redisAuth {
                ("password", auth)
            }
            
            // Environment-specific overrides
            for (key, value) in environment.redisOverrides {
                (key, value)
            }
        }
    }
}
```

## Architecture

swift-builders provides five specialized result builders:

```
swift-builders
    ├── ArrayBuilder        → Generic array construction
    ├── DictionaryBuilder   → Key-value pair construction
    ├── SetBuilder          → Unique element collections
    ├── StringBuilder       → Text content generation
    └── MarkdownBuilder     → Documentation and markup
```

Each builder is optimized for its specific use case while maintaining consistent APIs.

## Testing

Run tests:
```bash
swift test
```

The package includes 112 test cases covering:
- Basic functionality for each builder
- Control flow (conditionals, loops, optionals)
- Edge cases (empty collections, type inference)
- Performance with large datasets

## Performance

All builder logic is resolved at compile time with zero runtime overhead. Performance tests verify consistent behavior with collections up to 1000+ elements.

## Related Packages

- [coenttb/swift-html](https://github.com/coenttb/swift-html) - The Swift library for domain-accurate and type-safe HTML & CSS.

## Contributing

Contributions are welcome. For significant changes, please open an issue first to discuss what you would like to change.

## License

Licensed under the Apache License 2.0. See [LICENSE](LICENSE) for details.
