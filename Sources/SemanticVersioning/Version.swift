

public struct Version: Hashable, Sendable {
    public let core: CoreVersion
    public let prerelease: PreRelease?
    public let metadata: Metadata?

    public init(_ core: CoreVersion,
                prerelease: PreRelease? = nil,
                metadata: Metadata? = nil)
    {
        self.core = core
        self.prerelease = prerelease
        self.metadata = metadata
    }
}

public extension Version {
    init(major: UInt64, minor: UInt64, patch: UInt64,
         prerelease: PreRelease? = nil,
         metadata: Metadata? = nil)
    {
        self.init(CoreVersion(major: major, minor: minor, patch: patch),
                  prerelease: prerelease,
                  metadata: metadata)
    }
}

public extension Version {
    init(_ string: String) throws(VersionError) {
        let parser = VersionParser()
        self = try parser.parse(string)
    }

    init(_ string: Substring) throws(VersionError) {
        let parser = VersionParser()
        self = try parser.parse(string)
    }
}

public extension Version {
    var major: UInt64 {
        core.major
    }

    var minor: UInt64 {
        core.minor
    }

    var patch: UInt64 {
        core.patch
    }
}

extension Version: Comparable {
    public static func < (lhs: Version, rhs: Version) -> Bool {
        guard lhs.core == rhs.core else {
            return lhs.core < rhs.core
        }

        switch (lhs.prerelease, rhs.prerelease) {
        case (.some, .none):
            return true
        case (.none, .some):
            return false
        case (.none, .none):
            return false
        case let (.some(left), .some(right)):
            return left < right
        }
    }
}

extension Version: CustomStringConvertible {
    public var description: String {
        let converter = VersionString()
        return converter.string(from: self)
    }
}

extension Version: Encodable {
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        let converter = VersionString()
        let string = converter.string(from: self)
        try container.encode(string)
    }
}

extension Version: Decodable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        try self.init(string)
    }
}
