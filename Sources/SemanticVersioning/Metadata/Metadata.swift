//
//  Created by Vitali Kurlovich on 12.03.26.
//

public struct Metadata: Hashable, Sendable {
    public let value: Substring
}

public extension Metadata {
    init(_ string: String) throws(VersionError) {
        let parser = VersionParser()
        self = try parser.parseMetadata(string)
    }
}

extension Metadata: CustomStringConvertible {
    public var description: String {
        let converter = VersionString()
        return converter.string(from: self)
    }
}
