//
//  Created by Vitali Kurlovich on 13.03.26.
//

@testable import SemanticVersioning
import Testing

@Suite("PreRelease")
struct PreReleaseTests {
    @Test("PreRelease", arguments: [
        ("prerelease", PreRelease(value: "prerelease")),
        ("alpha", PreRelease(value: "alpha")),
        ("beta", PreRelease(value: "beta")),
        ("alpha.beta", PreRelease(value: "alpha.beta")),
        ("alpha.beta.1", PreRelease(value: "alpha.beta.1")),
        ("alpha.1", PreRelease(value: "alpha.1")),
        ("alpha0.valid", PreRelease(value: "alpha0.valid")),
        ("alpha.0valid", PreRelease(value: "alpha.0valid")),
        ("alpha-a.b-c-somethinglong", PreRelease(value: "alpha-a.b-c-somethinglong")),
        ("rc.1", PreRelease(value: "rc.1")),
        ("DEV-SNAPSHOT", PreRelease(value: "DEV-SNAPSHOT")),
        ("SNAPSHOT-123", PreRelease(value: "SNAPSHOT-123")),
        ("0A.is.legal", PreRelease(value: "0A.is.legal")),
        ("---RC-SNAPSHOT.12.9.1--.12", PreRelease(value: "---RC-SNAPSHOT.12.9.1--.12")),
        ("alpha.1227", PreRelease(value: "alpha.1227")),
        ("rc.10000aaa-kk-0.1", PreRelease(value: "rc.10000aaa-kk-0.1")),
        ("0.3.7", PreRelease(value: "0.3.7")),
        ("x.7.z.92", PreRelease(value: "x.7.z.92")),

    ])
    func preRelease(_ args: (String, PreRelease)) throws {
        #expect(try PreRelease(args.0) == args.1)
        #expect(args.0 == args.1.description)
    }

    @Test("Invalid PreRelease", arguments: [
        "",
        "abc.$",
        "abc+",
        "01.3.7",
        "0.03.7",
        "x.7.z.092",
        "0123",
        "0123.0123",
        "alpha_beta",
        "alpha.",
        "alpha..",
        "alpha..1",
        "alpha...1",
        "alpha....1",
        "alpha.....1",
        "alpha......1",
        "alpha.......1",

    ])
    func invalidPreRelease(_ string: String) throws {
        #expect(throws: VersionError.invalidFormat) {
            try PreRelease(string)
        }
    }

    @Test("Compare",
          arguments: try [
              (PreRelease("alpha.1"), PreRelease("alpha.2")),
              (PreRelease("alpha"), PreRelease("beta")),
              (PreRelease("alpha.9"), PreRelease("alpha.123"))
          ])
    func compare(_ args: (PreRelease, PreRelease)) throws {
        #expect(args.0 < args.1)
        #expect(args.1 > args.0)
    }
}
