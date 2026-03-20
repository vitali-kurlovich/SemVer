//
//  Created by Vitali Kurlovich on 13.03.26.
//

import SemanticVersioning
import Testing

typealias VersionCore = Version.VersionCore

@Suite("VersionCore")
struct VersionCoreTests {}

extension VersionCoreTests {
    @Test("Convert string",
          arguments: [
              ("1.2.3", VersionCore(major: 1, minor: 2, patch: 3)),
              ("1.2.0", VersionCore(major: 1, minor: 2, patch: 0)),
              ("1.0.0", VersionCore(major: 1, minor: 0, patch: 0)),
          ])
    func coreVersion(_ args: (String, VersionCore)) throws {
        #expect(try VersionCore(args.0) == args.1)
        #expect(args.0 == args.1.description)
    }

    @Test("Invalid version core",
          arguments: [
              "",
              "1",
              "1.",
              "1.2",
              "1.2.",
              "01.2.3",
              "1.02.3",
              "1.2.03",
              "alpha",
              "1.2.a",
              "-1.2.3",
              "1.2.3-",
              "1.2.3+",
          ])
    func incorrectFormat(_ string: String) {
        #expect(throws: VersionError.invalidFormat) {
            try VersionCore(string)
        }
    }

    @Test("Compare",
          arguments: [
              ("1.0.0", "2.0.0"),
              ("2.0.0", "2.0.1"),
              ("2.0.0", "2.1.0"),

              ("2.1.0", "2.1.1"),
              ("2.1.1", "2.2.0"),

              ("2.1.3", "2.2.0"),

              ("2.1.0", "2.2.0"),
              ("2.1.3", "2.2.0"),

              ("2.0.0", "3.0.0"),
              ("2.0.4", "3.0.0"),
              ("2.4.0", "3.0.0"),
              ("2.4.4", "3.0.0"),
          ])
    func compare(_ args: (String, String)) throws {
        let left = try VersionCore(args.0)
        let right = try VersionCore(args.1)

        #expect(left < right)
        #expect(right > left)

        #expect((left > right) == false)
        #expect((left == right) == false)

        #expect((right < left) == false)
        #expect((right == left) == false)
    }

    @Test("Compare")
    func equal() {
        #expect(VersionCore(major: 9, minor: 8, patch: 7) == VersionCore(major: 9, minor: 8, patch: 7))
        #expect(VersionCore(major: 9, minor: 8, patch: 7) != VersionCore(major: 9, minor: 8, patch: 6))
        #expect(VersionCore(major: 9, minor: 8, patch: 7) != VersionCore(major: 9, minor: 7, patch: 7))
        #expect(VersionCore(major: 9, minor: 8, patch: 7) != VersionCore(major: 8, minor: 8, patch: 7))
    }
}
