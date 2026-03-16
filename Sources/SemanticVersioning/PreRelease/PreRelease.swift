//
//  Created by Vitali Kurlovich on 12.03.26.
//

import Foundation

public struct PreRelease: Hashable, Sendable {
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
        lhs.value.compare(rhs.value, options: [.numeric]) == .orderedAscending
    }
}

extension PreRelease: CustomStringConvertible {
    public var description: String {
        let converter = VersionString()
        return converter.string(from: self)
    }
}
