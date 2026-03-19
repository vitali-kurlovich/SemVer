//
//  Created by Vitali Kurlovich on 19.03.26.
//

import SemanticVersioning
import Testing

@Suite("VersionDetector")

struct VersionDetectorTests {
    @Test("FirstMatch", arguments: [
        ("Begin 1.2.3-alpha+meta end", "1.2.3-alpha+meta"),
        (" 1.2.3-alpha+meta end", "1.2.3-alpha+meta"),
        ("1.2.3-alpha+meta end", "1.2.3-alpha+meta"),

        ("Begin 1.2.3-alpha+meta ", "1.2.3-alpha+meta"),
        ("Begin 1.2.3-alpha+meta", "1.2.3-alpha+meta"),

        ("Begin 1.2.3-alpha end", "1.2.3-alpha"),
        (" 1.2.3-alpha end", "1.2.3-alpha"),
        ("1.2.3-alpha end", "1.2.3-alpha"),

        ("Begin 1.2.3-alpha ", "1.2.3-alpha"),
        ("Begin 1.2.3-alpha", "1.2.3-alpha"),

        ("Begin 1.2.3+meta end", "1.2.3+meta"),
        (" 1.2.3+meta end", "1.2.3+meta"),
        ("1.2.3+meta end", "1.2.3+meta"),

        ("Begin 1.2.3+meta ", "1.2.3+meta"),
        ("Begin 1.2.3+meta", "1.2.3+meta"),

        ("Begin 1.2.3 end", "1.2.3"),
        (" 1.2.3 end", "1.2.3"),
        ("1.2.3 end", "1.2.3"),

        ("Begin 1.2.3 ", "1.2.3"),
        ("Begin 1.2.3", "1.2.3"),

        ("Begin 1.2.3+alpha+meta end", "1.2.3+alpha"),
        ("Begin 1.2.3.4-alpha+meta end", "1.2.3"),
        ("Begin 01.2.3-alpha+meta end", "1.2.3-alpha+meta"),
        ("Begin 1.2.03-alpha+meta end", "1.2.0"),

    ])
    func firstMatch(_ args: (String, String)) throws {
        let detector = VersionDetector()

        let result = try #require(detector.firstMatch(in: args.0))

        #expect(args.0[result.range] == args.1)
    }

    @Test("Matches", arguments: [
        ("Begin 1.2.3-alpha+meta end", ["1.2.3-alpha+meta"]),

        ("Begin 1.2.3-alpha+meta and 2.2.2-beta+rc end", ["1.2.3-alpha+meta", "2.2.2-beta+rc"]),
        ("Begin 1.2 end", []),
    ])
    func matches(_ args: (String, [String])) throws {
        let detector = VersionDetector()

        let result = detector.matches(in: args.0).map { result in
            String(args.0[result.range])
        }

        #expect(result == args.1)
    }

    @Test("No Matches", arguments: [
        "Begin 1.3-alpha+meta end",
        "Begin 1.02.3-alpha+meta end",
    ])
    func noMatches(_ string: String) throws {
        let detector = VersionDetector()

        #expect(detector.firstMatch(in: string) == nil)
    }
}
