//
//  Created by Vitali Kurlovich on 13.03.26.
//

@testable import SemVer
import Testing

@Suite("CoreVersion")
struct CoreVersionTests {}

extension CoreVersionTests {
    @Test("Convert string",
          arguments: [
              ("1.2.3", CoreVersion(major: 1, minor: 2, patch: 3)),
              ("1.2.0", CoreVersion(major: 1, minor: 2, patch: 0)),
              ("1.0.0", CoreVersion(major: 1, minor: 0, patch: 0)),
          ])
    func coreVersion(_ args: (String, CoreVersion)) throws {
        #expect(try CoreVersion(args.0) == args.1)
        #expect(args.0 == args.1.description)
    }

    @Test("Invalid core version",
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
        #expect(throws: VersionError.invalidCoreVersionFormat) {
            try CoreVersion(string)
        }
    }

    @Test("Compare",
          arguments: [
              (CoreVersion(major: 1, minor: 0, patch: 0), CoreVersion(major: 2, minor: 0, patch: 0)),
              (CoreVersion(major: 2, minor: 0, patch: 0), CoreVersion(major: 2, minor: 0, patch: 1)),
              (CoreVersion(major: 2, minor: 0, patch: 0), CoreVersion(major: 2, minor: 1, patch: 0)),
          ])
    func compare(_ args: (CoreVersion, CoreVersion)) {
        #expect(args.0 < args.1)
        #expect(args.1 > args.0)
    }

    @Test("Compare")
    func equal() {
        #expect(CoreVersion(major: 9, minor: 8, patch: 7) == CoreVersion(major: 9, minor: 8, patch: 7))
        #expect(CoreVersion(major: 9, minor: 8, patch: 7) != CoreVersion(major: 9, minor: 8, patch: 6))
        #expect(CoreVersion(major: 9, minor: 8, patch: 7) != CoreVersion(major: 9, minor: 7, patch: 7))
        #expect(CoreVersion(major: 9, minor: 8, patch: 7) != CoreVersion(major: 8, minor: 8, patch: 7))
    }
}
