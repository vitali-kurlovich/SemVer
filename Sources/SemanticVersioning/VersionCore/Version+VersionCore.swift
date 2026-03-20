//
//  Created by Vitali Kurlovich on 13.03.26.
//

public extension Version {
    /// A version number in MAJOR.MINOR.PATCH format
    ///
    /// for more info read [Semantic Versioning](https://semver.org/)
    struct VersionCore: Hashable, Sendable {
        public let major: UInt64
        public let minor: UInt64
        public let patch: UInt64

        public init(major: UInt64 = 0, minor: UInt64 = 0, patch: UInt64 = 0) {
            self.major = major
            self.minor = minor
            self.patch = patch
        }
    }
}

extension Version.VersionCore: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.major < rhs.major {
            return true
        } else if lhs.major > rhs.major {
            return false
        }

        if lhs.minor < rhs.minor {
            return true
        } else if lhs.minor > rhs.minor {
            return false
        }

        return lhs.patch < rhs.patch
    }
}

extension Version.VersionCore: CustomStringConvertible {
    public var description: String {
        formatted()
    }
}

public extension Version.VersionCore {
    init(_ string: String) throws(VersionError) {
        let parser = VersionParser()
        self = try parser.parseCoreVersion(string)
    }
}
