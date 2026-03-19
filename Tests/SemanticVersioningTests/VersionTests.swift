import Foundation
@testable import SemanticVersioning
import Testing

@Suite("Version")
struct VersionTests {}

extension VersionTests {
    @Test("Accessors")
    func accessors() throws {
        let ver = Version(major: 1, minor: 2, patch: 3)
        #expect(ver.major == 1)
        #expect(ver.minor == 2)
        #expect(ver.patch == 3)
    }
}

extension VersionTests {
    @Test("Invalid Semantic Versions", arguments: [
        "1",
        "1.2",
        "1.2.3-0123",
        "1.2.3-0123.0123",
        "1.1.2+.123",
        "+invalid",
        "-invalid",
        "-invalid+invalid",
        "-invalid.01",
        "alpha",
        "alpha.beta",
        "alpha.beta.1",
        "alpha.1",
        "alpha+beta",
        "alpha_beta",
        "alpha.",
        "alpha..",
        "beta",
        "1.0.0-alpha_beta",
        "-alpha.",
        "1.0.0-alpha..",
        "1.0.0-alpha..1",
        "1.0.0-alpha...1",
        "1.0.0-alpha....1",
        "1.0.0-alpha.....1",
        "1.0.0-alpha......1",
        "1.0.0-alpha.......1",
        "01.1.1",
        "1.01.1",
        "1.1.01",
        "1.2",
        "1.2.3.DEV",
        "1.2-SNAPSHOT",
        "1.2.31.2.3----RC-SNAPSHOT.12.09.1--..12+788",
        "1.2-RC-SNAPSHOT",
        "-1.0.3-gamma+b7718",
        "+justmeta",
        "9.8.7+meta+meta",
        "9.8.7-whatever+meta+meta",
        "99999999999999999999999.999999999999999999.99999999999999999----RC-SNAPSHOT.12.09.1--------------------------------..12",
    ])
    func incorrect(_ string: String) {
        #expect(throws: VersionError.invalidFormat) {
            try Version(string)
        }
    }
}

extension VersionTests {
    @Test("String init", arguments: [
        ("0.0.4", Version(major: 0, minor: 0, patch: 4)),
        ("1.2.3", Version(major: 1, minor: 2, patch: 3)),
        ("10.20.30", Version(major: 10, minor: 20, patch: 30)),
        ("1.1.2-prerelease+meta", Version(major: 1, minor: 1, patch: 2,
                                          prerelease: PreRelease(value: "prerelease"),
                                          metadata: Metadata(value: "meta"))),
        ("1.1.2+meta", Version(major: 1, minor: 1, patch: 2,
                               metadata: Metadata(value: "meta"))),
        ("1.1.2+meta-valid", Version(major: 1, minor: 1, patch: 2,
                                     metadata: Metadata(value: "meta-valid"))),
        ("1.0.0-alpha", Version(major: 1, minor: 0, patch: 0,
                                prerelease: PreRelease(value: "alpha"))),
        ("1.0.0-beta", Version(major: 1, minor: 0, patch: 0,
                               prerelease: PreRelease(value: "beta"))),
        ("1.0.0-alpha.beta", Version(major: 1, minor: 0, patch: 0,
                                     prerelease: PreRelease(value: "alpha.beta"))),
        ("1.0.0-alpha.beta.1", Version(major: 1, minor: 0, patch: 0,
                                       prerelease: PreRelease(value: "alpha.beta.1"))),
        ("1.0.0-alpha.1", Version(major: 1, minor: 0, patch: 0,
                                  prerelease: PreRelease(value: "alpha.1"))),
        ("1.0.0-alpha0.valid", Version(major: 1, minor: 0, patch: 0,
                                       prerelease: PreRelease(value: "alpha0.valid"))),
        ("1.0.0-alpha.0valid", Version(major: 1, minor: 0, patch: 0,
                                       prerelease: PreRelease(value: "alpha.0valid"))),

        ("1.0.0-alpha-a.b-c-somethinglong+build.1-aef.1-its-okay", Version(major: 1, minor: 0, patch: 0,
                                                                           prerelease: PreRelease(value: "alpha-a.b-c-somethinglong"),
                                                                           metadata: Metadata(value: "build.1-aef.1-its-okay"))),
        ("1.0.0-rc.1+build.1", Version(major: 1, minor: 0, patch: 0,
                                       prerelease: PreRelease(value: "rc.1"),
                                       metadata: Metadata(value: "build.1"))),
        ("2.0.0-rc.1+build.123", Version(major: 2, minor: 0, patch: 0,
                                         prerelease: PreRelease(value: "rc.1"),
                                         metadata: Metadata(value: "build.123"))),

        ("1.2.3-beta", Version(major: 1, minor: 2, patch: 3,
                               prerelease: PreRelease(value: "beta"))),

        ("10.2.3-DEV-SNAPSHOT", Version(major: 10, minor: 2, patch: 3,
                                        prerelease: PreRelease(value: "DEV-SNAPSHOT"))),
        ("1.2.3-SNAPSHOT-123", Version(major: 1, minor: 2, patch: 3,
                                       prerelease: PreRelease(value: "SNAPSHOT-123"))),

        ("1.0.0", Version(major: 1, minor: 0, patch: 0)),
        ("2.0.0", Version(major: 2, minor: 0, patch: 0)),
        ("1.1.7", Version(major: 1, minor: 1, patch: 7)),

        ("2.0.0+build.1848", Version(major: 2, minor: 0, patch: 0,
                                     metadata: Metadata(value: "build.1848"))),

        ("2.0.1-alpha.1227", Version(major: 2, minor: 0, patch: 1,
                                     prerelease: PreRelease(value: "alpha.1227"))),

        ("1.0.0-alpha+beta", Version(major: 1, minor: 0, patch: 0,
                                     prerelease: PreRelease(value: "alpha"),
                                     metadata: Metadata(value: "beta"))),

        ("1.2.3----RC-SNAPSHOT.12.9.1--.12+788", Version(major: 1, minor: 2, patch: 3,
                                                         prerelease: PreRelease(value: "---RC-SNAPSHOT.12.9.1--.12"),
                                                         metadata: Metadata(value: "788"))),

        ("1.2.3----R-S.12.9.1--.12+meta", Version(major: 1, minor: 2, patch: 3,
                                                  prerelease: PreRelease(value: "---R-S.12.9.1--.12"),
                                                  metadata: Metadata(value: "meta"))),

        ("1.2.3----RC-SNAPSHOT.12.9.1--.12", Version(major: 1, minor: 2, patch: 3,
                                                     prerelease: PreRelease(value: "---RC-SNAPSHOT.12.9.1--.12"))),

        ("1.0.0+0.build.1-rc.10000aaa-kk-0.1", Version(major: 1, minor: 0, patch: 0,
                                                       metadata: Metadata(value: "0.build.1-rc.10000aaa-kk-0.1"))),

        ("1.0.0-0A.is.legal", Version(major: 1, minor: 0, patch: 0,
                                      prerelease: PreRelease(value: "0A.is.legal"))),

        ("9999999999999999999.999999999999999999.99999999999999999",
         Version(major: 9_999_999_999_999_999_999, minor: 999_999_999_999_999_999, patch: 99_999_999_999_999_999)),
    ])
    func string(_ args: (String, Version)) throws {
        #expect(try Version(args.0) == args.1)
        #expect(args.0 == args.1.description)
    }
}

extension VersionTests {
    @Test("Compare", arguments: try [
        (Version("1.0.0"), Version("2.0.0")),
        (Version("2.0.0"), Version("2.1.0")),
        (Version("2.1.0"), Version("2.1.1")),
        (Version("1.0.0-alpha"), Version("1.0.0")),
        (Version("1.0.0-alpha"), Version("1.0.0-alpha.1")),
        (Version("1.0.0-alpha.1"), Version("1.0.0-alpha.beta")),
        (Version("1.0.0-alpha.beta"), Version("1.0.0-beta")),
        (Version("1.0.0-beta"), Version("1.0.0-beta.2")),

        (Version("1.0.0-beta.2"), Version("1.0.0-beta.11")),

        (Version("1.0.0-beta.11"), Version("1.0.0-rc.1")),
        (Version("1.0.0-rc.1"), Version("1.0.0"))
    ])
    func compare(_ args: (Version, Version)) throws {
        #expect(args.0 < args.1)
        #expect(args.1 > args.0)
    }
}

extension VersionTests {
    @Test("Formatting", arguments: try [
        (Version("1.0.0"), VersionFormatStyle.full, "1.0.0"),
        (Version("1.0.0"), VersionFormatStyle.medium, "1.0.0"),
        (Version("1.0.0"), VersionFormatStyle.short, "1.0.0"),

        (Version("1.0.0-alpha.1"), VersionFormatStyle.full, "1.0.0-alpha.1"),
        (Version("1.0.0-alpha.1"), VersionFormatStyle.medium, "1.0.0-alpha.1"),
        (Version("1.0.0-alpha.1"), VersionFormatStyle.short, "1.0.0"),

        (Version("1.0.0-alpha.1+meta"), VersionFormatStyle.full, "1.0.0-alpha.1+meta"),
        (Version("1.0.0-alpha.1+meta"), VersionFormatStyle.medium, "1.0.0-alpha.1"),
        (Version("1.0.0-alpha.1+meta"), VersionFormatStyle.short, "1.0.0"),

        (Version("1.0.0-alpha.1+meta"), VersionFormatStyle.custom([.preRelease]), "alpha.1"),
        (Version("1.0.0-alpha.1+meta"), VersionFormatStyle.custom([.preRelease, .metadata]), "alpha.1+meta"),

        (Version("1.0.0-alpha.1+meta"), VersionFormatStyle.custom([.coreVersion, .metadata]), "1.0.0+meta"),

        (Version("1.0.0-alpha.1+meta"), VersionFormatStyle.custom([.metadata]), "meta")

    ])
    func formatted(_ args: (Version, VersionFormatStyle, String)) {
        #expect(args.0.formatted(args.1) == args.2)

        #expect(args.0.formatted() == args.0.formatted(.medium))
    }

    @Test("Formatting Attributed")
    func attr() throws {
        let version = try Version("1.2.3-alpha.1+meta")

        var arrtibuted = version.formatted(.full.attributed)

        var semantic = ""
        var coreVersion = ""

        var major = ""
        var minor = ""
        var patch = ""

        var coreSeparator = ""

        var preRelease = ""
        var preReleaseText = ""
        var preReleaseSeparator = ""

        var meta = ""
        var metaText = ""
        var metaSeparator = ""

        func fetchComponents() {
            for run in arrtibuted.runs {
                if run.semanticVersioning.semantic != nil {
                    semantic += String(arrtibuted[run.range].characters)
                }

                if let part = run.semanticVersioning.versionPart {
                    coreVersion += String(arrtibuted[run.range].characters)

                    switch part {
                    case .major:
                        major += String(arrtibuted[run.range].characters)
                    case .minor:
                        minor += String(arrtibuted[run.range].characters)
                    case .patch:
                        patch += String(arrtibuted[run.range].characters)
                    case .groupSeparator:
                        coreSeparator += String(arrtibuted[run.range].characters)
                    }
                }

                if let part = run.semanticVersioning.preReleasePart {
                    preRelease += String(arrtibuted[run.range].characters)

                    switch part {
                    case .preRelease:
                        preReleaseText += String(arrtibuted[run.range].characters)
                    case .groupSeparator:
                        preReleaseSeparator += String(arrtibuted[run.range].characters)
                    }
                }

                if let part = run.semanticVersioning.metadataPart {
                    meta += String(arrtibuted[run.range].characters)

                    switch part {
                    case .metadata:
                        metaText += String(arrtibuted[run.range].characters)
                    case .groupSeparator:
                        metaSeparator += String(arrtibuted[run.range].characters)
                    }
                }
            }
        }

        fetchComponents()

        #expect(semantic == "1.2.3-alpha.1+meta")
        #expect(coreVersion == "1.2.3")
        #expect(major == "1")
        #expect(minor == "2")
        #expect(patch == "3")
        #expect(coreSeparator == "..")

        #expect(preRelease == "-alpha.1")
        #expect(preReleaseText == "alpha.1")
        #expect(preReleaseSeparator == "-")

        #expect(meta == "+meta")
        #expect(metaText == "meta")
        #expect(metaSeparator == "+")

        arrtibuted = version.formatted(.custom([.preRelease]).attributed)

        semantic = ""
        coreVersion = ""

        major = ""
        minor = ""
        patch = ""

        coreSeparator = ""

        preRelease = ""
        preReleaseText = ""
        preReleaseSeparator = ""

        meta = ""
        metaText = ""
        metaSeparator = ""

        fetchComponents()

        #expect(semantic == "alpha.1")
        #expect(coreVersion.isEmpty)
        #expect(major.isEmpty)
        #expect(minor.isEmpty)
        #expect(patch.isEmpty)
        #expect(coreSeparator.isEmpty)

        #expect(preRelease == "alpha.1")
        #expect(preReleaseText == "alpha.1")
        #expect(preReleaseSeparator.isEmpty)

        #expect(meta.isEmpty)
        #expect(metaText.isEmpty)
        #expect(metaSeparator.isEmpty)

        arrtibuted = version.formatted(.custom([.metadata]).attributed)

        semantic = ""
        coreVersion = ""

        major = ""
        minor = ""
        patch = ""

        coreSeparator = ""

        preRelease = ""
        preReleaseText = ""
        preReleaseSeparator = ""

        meta = ""
        metaText = ""
        metaSeparator = ""

        fetchComponents()

        #expect(semantic == "meta")
        #expect(coreVersion.isEmpty)
        #expect(major.isEmpty)
        #expect(minor.isEmpty)
        #expect(patch.isEmpty)
        #expect(coreSeparator.isEmpty)

        #expect(preRelease.isEmpty)
        #expect(preReleaseText.isEmpty)
        #expect(preReleaseSeparator.isEmpty)

        #expect(meta == "meta")
        #expect(metaText == "meta")
        #expect(metaSeparator.isEmpty)
    }
}

extension VersionTests {
    @Test("Codable", arguments: try [
        Version("1.2.3"),
        Version("1.2.3-alpha"),
        Version("1.2.3-alpha+meta"),
        Version("1.2.3+meta")
    ])
    func codable(_ version: Version) throws {
        let encoder = JSONEncoder()

        let data = try encoder.encode(version)

        let decoder = JSONDecoder()
        let result = try decoder.decode(Version.self, from: data)

        #expect(version == result)
    }
}
