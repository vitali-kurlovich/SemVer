//
//  Created by Vitali Kurlovich on 13.03.26.
//

public struct CoreVersion: Sendable {
    public let major: Int
    public let minor: Int
    public let patch: Int

    public init(major: Int, minor: Int, patch: Int) {
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
