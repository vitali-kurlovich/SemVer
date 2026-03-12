@testable import SemVer
import Testing

@Suite("SemVerersion")
struct SemVerTests {}

extension SemVerTests {
    @Test
    func compare() throws {
        #expect(Version(major: 1, minor: 2, patch: 3) < Version(major: 1, minor: 2, patch: 4))
        #expect(Version(major: 1, minor: 2, patch: 3) < Version(major: 1, minor: 3))
        #expect(Version(major: 1, minor: 2, patch: 3) < Version(major: 2))
    }

    @Test("Incorrect string")
    func incorrect() {
        #expect(Version("") == nil)
        #expect(Version("1,") == nil)
        #expect(Version("1.2.q") == nil)
        #expect(Version("1.2.3.5") == nil)
    }

    @Test("String init")
    func string() {
        #expect(Version(major: 1, minor: 2, patch: 3) == Version("1.2.3"))
        #expect(Version(major: 1, minor: 2) == Version("1.2"))
        #expect(Version(major: 1) == Version("1"))

        #expect(String(Version(major: 1, minor: 2, patch: 3)) == "1.2.3")
    }
}
