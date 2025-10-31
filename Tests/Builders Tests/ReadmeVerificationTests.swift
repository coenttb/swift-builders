import Testing
import Foundation
@testable import ArrayBuilder
@testable import DictionaryBuilder
@testable import SetBuilder
@testable import StringBuilder
@testable import MarkdownBuilder

@Suite("README Verification")
struct ReadmeVerificationTests {

    // MARK: - Overview Examples (Lines 12-62)

    @Test("Overview: Menu items array (Lines 26-36)")
    func overviewMenuItems() {
        struct User {
            let isAuthenticated: Bool
        }
        struct Feature {
            let menuTitle: String
        }

        let user = User(isAuthenticated: true)
        let enabledFeatures = [
            Feature(menuTitle: "Settings"),
            Feature(menuTitle: "Help")
        ]

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

        #expect(menuItems == ["Home", "About", "Dashboard", "Profile", "Settings", "Help"])
    }

    @Test("Overview: Config string (Lines 39-47)")
    func overviewConfigString() {
        let serverHost = "localhost"
        let serverPort = 8080
        let sslEnabled = true
        let certPath = "/etc/ssl/cert.pem"

        let config = String {
            "# Server Configuration"
            "Host: \(serverHost)"
            "Port: \(serverPort)"
            if sslEnabled {
                "SSL: Enabled"
                "Certificate: \(certPath)"
            }
        }

        let expected = """
        # Server Configuration
        Host: localhost
        Port: 8080
        SSL: Enabled
        Certificate: /etc/ssl/cert.pem
        """
        #expect(config == expected)
    }

    @Test("Overview: Permissions set (Lines 50-58)")
    func overviewPermissionsSet() {
        enum Permission: Hashable {
            case read, write, admin, delete
        }
        struct Role {
            let defaultPermissions: Set<Permission>
        }
        struct User {
            let isAdmin: Bool
        }

        let userRole = Role(defaultPermissions: [.read])
        let user = User(isAdmin: true)

        let permissions = Set<Permission> {
            Permission.read
            Permission.write
            userRole.defaultPermissions
            if user.isAdmin {
                [Permission.admin, Permission.delete]
            }
        }

        #expect(permissions == [Permission.read, Permission.write, Permission.admin, Permission.delete])
    }

    @Test("Overview: Configuration dictionary (Lines 60-68)")
    func overviewConfigurationDictionary() {
        let serverHost = "localhost"
        let serverPort = 8080
        let sslEnabled = true
        let certPath = "/path/to/cert"
        let existingConfig: [String: String] = ["timeout": "30"]

        let configuration = Dictionary<String, String> {
            ("host", serverHost)
            ("port", "\(serverPort)")
            if sslEnabled {
                ("ssl", "true")
                ("cert_path", certPath)
            }
            existingConfig
        }

        #expect(configuration["host"] == "localhost")
        #expect(configuration["port"] == "8080")
        #expect(configuration["ssl"] == "true")
        #expect(configuration["cert_path"] == "/path/to/cert")
        #expect(configuration["timeout"] == "30")
    }

    // MARK: - Quick Start Example (Lines 85-108)

    @Test("Quick Start: Navigation menu (Lines 85-108)")
    func quickStartNavigationMenu() {
        struct User {
            let isAuthenticated: Bool
            let isAdmin: Bool
        }

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

        let currentUser = User(isAuthenticated: true, isAdmin: false)
        let menu = NavigationMenu(user: currentUser)
        #expect(menu.items == ["Home", "About", "Dashboard", "Settings"])
    }

    // MARK: - ArrayBuilder Examples (Lines 113-131)

    @Test("ArrayBuilder: Type-safe construction (Lines 115-123)")
    func arrayBuilderTypeSafe() {
        let condition = true
        let collection = ["item1", "item2"]

        let items = Array<String> {
            "Always included"
            if condition { "Conditional item" }
            for item in collection { item }
        }

        #expect(items == ["Always included", "Conditional item", "item1", "item2"])
    }

    // MARK: - StringBuilder Examples (Lines 133-160)

    @Test("StringBuilder: Configuration file (Lines 135-150)")
    func stringBuilderConfig() {
        let appVersion = "1.0"
        let isProduction = false

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

        let expected = """
        # Application Config
        version: 1.0
        environment: development
        debug: true
        """
        #expect(config == expected)
    }

    @Test("StringBuilder: Log entry (Lines 152-160)")
    func stringBuilderLogEntry() {
        enum Level: String {
            case info
            case error
            func uppercased() -> String { rawValue.uppercased() }
        }

        let timestamp = "2024-01-01"
        let level = Level.error
        let message = "Connection failed"
        let error: Error? = NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Timeout"])

        let logEntry = String {
            "[\(timestamp)]"
            "[\(level.uppercased())]"
            message
            if let error = error {
                "Error: \(error.localizedDescription)"
            }
        }

        let expected = """
        [2024-01-01]
        [ERROR]
        Connection failed
        Error: Timeout
        """
        #expect(logEntry == expected)
    }

    // MARK: - MarkdownBuilder Examples (Lines 162-188)

    @Test("MarkdownBuilder: Standard formatting (Lines 164-175)")
    func markdownBuilderStandard() {
        struct Feature {
            let name: String
            let description: String
        }
        let features = [
            Feature(name: "Fast", description: "Quick processing"),
            Feature(name: "Safe", description: "Type-safe")
        ]

        let readme = String(markdown: {
            "# Project Title"
            "Brief description here"
            for feature in features {
                "- \(feature.name): \(feature.description)"
            }
        })

        let expected = """
        # Project Title
        Brief description here
        - Fast: Quick processing
        - Safe: Type-safe
        """
        #expect(readme == expected)
    }

    // MARK: - DictionaryBuilder Examples (Lines 190-229)

    @Test("DictionaryBuilder: Server config (Lines 192-202)")
    func dictionaryBuilderServerConfig() {
        let enableSSL = true
        let existingConfig: [String: String] = ["log_level": "debug"]

        let serverConfig = Dictionary<String, String> {
            ("host", "localhost")
            ("port", "8080")
            if enableSSL {
                ("ssl", "true")
                ("cert_path", "/path/to/cert.pem")
            }
            existingConfig
        }

        #expect(serverConfig["host"] == "localhost")
        #expect(serverConfig["port"] == "8080")
        #expect(serverConfig["ssl"] == "true")
        #expect(serverConfig["cert_path"] == "/path/to/cert.pem")
        #expect(serverConfig["log_level"] == "debug")
    }

    @Test("DictionaryBuilder: KeyValuePair (Lines 204-216)")
    func dictionaryBuilderKeyValuePair() {
        let baseURL = "https://api.example.com"
        let isDebugMode = true

        let apiConfig: Dictionary<String, Any> = Dictionary {
            KeyValuePair("timeout", 30 as Any)
            KeyValuePair("retries", 3 as Any)
            KeyValuePair("base_url", baseURL as Any)
            if isDebugMode {
                KeyValuePair("debug", true as Any)
                KeyValuePair("verbose", true as Any)
            }
        }

        #expect(apiConfig["timeout"] as? Int == 30)
        #expect(apiConfig["retries"] as? Int == 3)
        #expect(apiConfig["base_url"] as? String == baseURL)
        #expect(apiConfig["debug"] as? Bool == true)
        #expect(apiConfig["verbose"] as? Bool == true)
    }

    // MARK: - SetBuilder Examples (Lines 231-254)

    @Test("SetBuilder: Permission systems (Lines 233-243)")
    func setBuilderPermissions() {
        enum Permission: Hashable {
            case read, write, admin, delete, create
        }
        struct User {
            let isAdmin: Bool
        }

        let rolePermissions: Set<Permission> = [.read]
        let user = User(isAdmin: true)

        let userPermissions = Set<Permission> {
            Permission.read
            Permission.write
            rolePermissions
            if user.isAdmin {
                [Permission.admin, Permission.delete, Permission.create]
            }
        }

        #expect(userPermissions == [Permission.read, Permission.write, Permission.admin, Permission.delete, Permission.create])
    }
}
