//
//  Created by Vitali Kurlovich on 12.03.26.
//

public extension Version {
    /// A pre-release version description
    ///
    /// for more info read [Semantic Versioning](https://semver.org/#spec-item-9)
    struct PreRelease: Hashable, Sendable {
        public let value: Substring
    }
}

public extension Version.PreRelease {
    init(_ string: String) throws(VersionError) {
        let parser = VersionParser()
        self = try parser.parsePreRelease(string)
    }
}

extension Version.PreRelease: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.value.compare(rhs.value, options: [.numeric]) == .orderedAscending
    }
}

extension Version.PreRelease: CustomStringConvertible {
    public var description: String {
        formatted()
    }
}
