//
//  Created by Vitali Kurlovich on 13.03.26.
//

@testable import SemVer
import Testing

@Suite("Metadata")
struct MetadataTests {
    @Test("Metadata", arguments: [
        ("788", Metadata(value: "788")),
        ("beta", Metadata(value: "beta")),
        ("meta", Metadata(value: "meta")),
        ("meta-valid", Metadata(value: "meta-valid")),
        ("build.1", Metadata(value: "build.1")),
        ("build.123", Metadata(value: "build.123")),
        ("build.1848", Metadata(value: "build.1848")),
        ("build.1-aef.1-its-okay", Metadata(value: "build.1-aef.1-its-okay")),
        ("001", Metadata(value: "001")),
        ("20130313144700", Metadata(value: "20130313144700")),
        ("exp.sha.5114f85", Metadata(value: "exp.sha.5114f85")),

    ])
    func metadata(_ args: (String, Metadata)) throws {
        #expect(try Metadata(args.0) == args.1)
        #expect(args.0 == args.1.description)
    }

    @Test("Invalid Metadata", arguments: [
        "",
        "abc.$",
        "abc+",
    ])
    func invalidMetadata(_ string: String) throws {
        #expect(throws: VersionError.invalidMetadataFormat) {
            try Metadata(string)
        }
    }
}
