//
//  Created by Vitali Kurlovich on 15.03.26.
//

import Foundation

public struct VersionFormatAttributes: AttributeScope {
    public let corePart: Self.CoreVersionPartAttribute

    public let version: Self.VersionPartAttribute

    public enum VersionPartAttribute: CodableAttributedStringKey {
        public enum VersionPart: Int, Codable, Sendable {
            case coreVersion
            case preRelease
            case preReleaseSeparator
            case metadata
            case metadataSeparator
        }

        public static let name: String = .init(describing: Self.self)

        public typealias Value = Self.VersionPart
    }

    public enum CoreVersionPartAttribute: CodableAttributedStringKey {
        public enum CoreVersionPart: Int, Codable, Sendable {
            case major
            case minor
            case patch
            case groupSeparator
        }

        public static let name: String = .init(describing: Self.self)

        public typealias Value = Self.CoreVersionPart
    }
}
