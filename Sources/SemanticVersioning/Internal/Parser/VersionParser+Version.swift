//
//  Created by Vitali Kurlovich on 13.03.26.
//

extension VersionParser {
    @inlinable
    func parse(_ string: String) throws(VersionError) -> Version {
        let range = string.startIndex ..< string.endIndex
        return try parse(string[range])
    }

    @inlinable
    func parse(_ string: Substring) throws(VersionError) -> Version {
        do {
            let match = try versionRegexp.wholeMatch(in: string)

            guard let match else {
                throw VersionError.invalidFormat
            }

            return version(from: match)

        } catch {
            throw VersionError.invalidFormat
        }
    }
}

extension VersionParser {
    @inlinable
    func firstMatch(in string: Substring) -> (Range<String.Index>, Version)? {
        do {
            let match = try findVersionRegexp.firstMatch(in: string)

            guard let match else {
                return nil
            }

            return (match.range, version(from: match))

        } catch {
            return nil
        }
    }
}

extension VersionParser {
    @inlinable
    var versionRegexp: Regex<(Substring, major: Substring, minor: Substring, patch: Substring, prerelease: Substring?, buildmetadata: Substring?)> {
        /^(?P<major>0|[1-9]\d*)\.(?P<minor>0|[1-9]\d*)\.(?P<patch>0|[1-9]\d*)(?:-(?P<prerelease>(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+(?P<buildmetadata>[0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$/
    }

    @inlinable
    var findVersionRegexp: Regex<(Substring, major: Substring, minor: Substring, patch: Substring, prerelease: Substring?, buildmetadata: Substring?)> {
        /(?P<major>0|[1-9]\d*)\.(?P<minor>0|[1-9]\d*)\.(?P<patch>0|[1-9]\d*)(?:-(?P<prerelease>(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+(?P<buildmetadata>[0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?/
    }

    @inlinable
    func version(from match: Regex<(Substring, major: Substring, minor: Substring, patch: Substring, prerelease: Substring?, buildmetadata: Substring?)>.Match) -> Version {
        version(from: match.output)
    }

    @inlinable
    func version(from result: (Substring, major: Substring, minor: Substring, patch: Substring, prerelease: Substring?, buildmetadata: Substring?)) -> Version {
        let major = UInt64(result.major)!
        let minor = UInt64(result.minor)!
        let patch = UInt64(result.patch)!

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
