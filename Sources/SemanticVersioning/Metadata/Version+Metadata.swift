//
//  Created by Vitali Kurlovich on 12.03.26.
//

public extension Version {
    /// Version metadata
    ///
    /// for more info read [Semantic Versioning](https://semver.org/#spec-item-10)
    struct Metadata: Hashable, Sendable {
        public let value: Substring
    }
}

public extension Version.Metadata {
    init(_ string: String) throws(VersionError) {
        let parser = VersionParser()
        self = try parser.parseMetadata(string)
    }
}

extension Version.Metadata: CustomStringConvertible {
    public var description: String {
        formatted()
    }
}
