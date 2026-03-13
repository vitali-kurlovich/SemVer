//
//  Created by Vitali Kurlovich on 13.03.26.
//

extension VersionParser {
    func parse(_ string: String) throws -> Version {
        let regexp =
            /^(?P<major>0|[1-9]\d*)\.(?P<minor>0|[1-9]\d*)\.(?P<patch>0|[1-9]\d*)(?:-(?P<prerelease>(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+(?P<buildmetadata>[0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$/

        let match = try regexp.wholeMatch(in: string)

        guard let result = match?.output else {
            throw VersionError.invalidFormat
        }

        let major = Int(result.major)!
        let minor = Int(result.minor)!
        let patch = Int(result.patch)!

        let coreVersion = CoreVersion(major: major, minor: minor, patch: patch)

        let prerelease: PreRelease?
        if let value = result.prerelease {
            prerelease = PreRelease(value: value)
        } else {
            prerelease = nil
        }

        let metadata: Metadata?
        if let value = result.buildmetadata {
            metadata = Metadata(value: value)
        } else {
            metadata = nil
        }

        return Version(coreVersion,
                       prerelease: prerelease,
                       metadata: metadata)
    }
}
