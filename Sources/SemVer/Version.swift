

public struct Version: Sendable {
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
    init(major: Int, minor: Int, patch: Int,
         prerelease: PreRelease? = nil,
         metadata: Metadata? = nil)
    {
        let core = CoreVersion(major: major, minor: minor, patch: patch)

        self.init(core, prerelease: prerelease, metadata: metadata)
    }
}

public extension Version {
    init(_ string: String) throws {
        let parser = VersionParser()
        self = try parser.parse(string)
    }
}

public extension Version {
    var major: Int {
        core.major
    }

    var minor: Int {
        core.minor
    }

    var patch: Int {
        core.patch
    }
}

extension Version: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.core == rhs.core && lhs.prerelease == rhs.prerelease
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
        var string = core.description

        if let prerelease {
            string.append("-\(prerelease.description)")
        }

        if let metadata {
            string.append("+\(metadata.description)")
        }

        return string
    }
}
