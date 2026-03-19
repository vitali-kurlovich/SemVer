//
//  Created by Vitali Kurlovich on 19.03.26.
//

import Foundation

public struct VersionDetectorResult {
    public let range: Range<String.Index>
    public let version: Version
}

public struct VersionDetector {
    public init() {}
}

public extension VersionDetector {
    func firstMatch(in string: String) -> VersionDetectorResult? {
        let parser = VersionParser()

        guard let result = parser.firstMatch(in: string) else {
            return nil
        }

        return VersionDetectorResult(range: result.0, version: result.1)
    }

    func firstMatch(in string: Substring) -> VersionDetectorResult? {
        let parser = VersionParser()

        guard let result = parser.firstMatch(in: string) else {
            return nil
        }

        return VersionDetectorResult(range: result.0, version: result.1)
    }

//    func firstMatch(in string: Substring) throws -> VersionDetectorResult? {
//        guard let match = try regexp.firstMatch(in: string) else {
//            return nil
//        }
//
//        let version = try Version(string[match.range])
//        return VersionDetectorResult(range: match.range, version: version)
//    }
}
