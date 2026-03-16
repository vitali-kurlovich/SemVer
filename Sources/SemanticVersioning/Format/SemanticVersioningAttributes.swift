//
//  Created by Vitali Kurlovich on 15.03.26.
//

import Foundation

public extension AttributeScopes {
    var semanticVersioning: AttributeScopes.SemanticVersioningAttributes.Type {
        SemanticVersioningAttributes.self
    }

    /// A type for using a ``Version`` format as an attribute.
    struct SemanticVersioningAttributes: AttributeScope {
        public let semantic: Self.SemanticVersionAttribute

        public let versionPart: Self.CoreVersionPartAttribute
        public let preReleasePart: Self.PreReleasePartAttribute
        public let metadataPart: Self.MetadataPartAttribute

        public enum SemanticVersionAttribute: CodableAttributedStringKey {
            public enum SemanticVersion: Int, Codable, Sendable {
                case semanticVersion
            }

            public static let name: String = "semver"

            public typealias Value = Self.SemanticVersion
        }

        public enum CoreVersionPartAttribute: CodableAttributedStringKey {
            public enum CoreVersionPart: Int, Codable, Sendable {
                case major
                case minor
                case patch
                case groupSeparator
            }

            public static let name: String = "semver.core"

            public typealias Value = Self.CoreVersionPart
        }

        public enum PreReleasePartAttribute: CodableAttributedStringKey {
            public enum PreReleasePart: Int, Codable, Sendable {
                case preRelease
                case groupSeparator
            }

            public static let name: String = "semver.release"

            public typealias Value = Self.PreReleasePart
        }

        public enum MetadataPartAttribute: CodableAttributedStringKey {
            public enum MetadataPart: Int, Codable, Sendable {
                case metadata
                case groupSeparator
            }

            public static let name: String = "semver.meta"

            public typealias Value = Self.MetadataPart
        }
    }
}
