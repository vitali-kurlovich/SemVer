//
//  Created by Vitali Kurlovich on 12.03.26.
//

public struct PreRelease: Sendable {
    public let value: Substring
}

public extension PreRelease {
    init(_ string: String) throws {
        let parser = VersionParser()
        self = try parser.parsePreRelease(string)
    }
}

extension PreRelease: Comparable {
    public static func < (lhs: PreRelease, rhs: PreRelease) -> Bool {
        lhs.value < rhs.value
    }
}

extension PreRelease: CustomStringConvertible {
    public var description: String {
        value.description
    }
}
