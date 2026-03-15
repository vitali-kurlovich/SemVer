//
//  Created by Vitali Kurlovich on 12.03.26.
//

public struct Metadata: Sendable {
    public let value: Substring
}

public extension Metadata {
    init(_ string: String) throws {
        let parser = VersionParser()
        self = try parser.parseMetadata(string)
    }
}

extension Metadata: Equatable {}

extension Metadata: CustomStringConvertible {
    public var description: String {
        let converter = VersionString()
        return converter.string(from: self)
    }
}
