//
//  Created by Vitali Kurlovich on 19.03.26.
//

public struct VersionDetector {
    public init() {}
}

public struct VersionDetectorMatches: Sequence {
    public typealias Element = VersionDetectorResult

    let string: Substring

    init(_ string: Substring) {
        self.string = string
    }

    public func makeIterator() -> Iterator {
        let range = string.startIndex ..< string.endIndex
        return Iterator(string: string, range: range)
    }
}

extension VersionDetectorMatches {
    init(_ string: String) {
        let range = string.startIndex ..< string.endIndex
        self.init(string[range])
    }
}

public extension VersionDetectorMatches {
    struct Iterator: IteratorProtocol {
        let string: Substring

        var range: Range<String.Index>

        public mutating func next() -> VersionDetectorResult? {
            let parser = VersionParser()

            guard let match = parser.firstMatch(in: string[range]) else {
                return nil
            }

            range = match.0.upperBound ..< range.upperBound

            return VersionDetectorResult(range: match.0, version: match.1)
        }
    }
}
