//
//  Created by Vitali Kurlovich on 19.03.26.
//

public extension VersionDetector {
    func matches(in string: String) -> VersionDetectorMatches {
        let range = string.startIndex ..< string.endIndex
        return matches(in: string[range])
    }

    func matches(in string: Substring) -> VersionDetectorMatches {
        return VersionDetectorMatches(string)
    }
}

public extension VersionDetector {
    func firstMatch(in string: String) -> VersionDetectorResult? {
        let range = string.startIndex ..< string.endIndex
        return firstMatch(in: string[range])
    }

    func firstMatch(in string: Substring) -> VersionDetectorResult? {
        var iterator = matches(in: string).makeIterator()
        return iterator.next()
    }
}
