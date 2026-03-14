//
//  Created by Vitali Kurlovich on 13.03.26.
//

public struct CoreVersion: Sendable {
    public let major: UInt64
    public let minor: UInt64
    public let patch: UInt64

    public init(major: UInt64 = 0, minor: UInt64 = 0, patch: UInt64 = 0) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }
}

extension CoreVersion: Comparable {
    public static func < (lhs: CoreVersion, rhs: CoreVersion) -> Bool {
        lhs.major < rhs.major || lhs.minor < rhs.minor || lhs.patch < rhs.patch
    }
}

extension CoreVersion: CustomStringConvertible {
    public var description: String {
        "\(major).\(minor).\(patch)"
    }
}

public extension CoreVersion {
    init(_ string: String) throws {
        let parser = VersionParser()
        self = try parser.parseCoreVersion(string)
    }
}
