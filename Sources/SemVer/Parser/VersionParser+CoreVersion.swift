//
//  Created by Vitali Kurlovich on 13.03.26.
//

extension VersionParser {
    func parseCoreVersion(_ string: String) throws -> CoreVersion {
        let regexp = /^(?P<major>0|[1-9]\d*)\.(?P<minor>0|[1-9]\d*)\.(?P<patch>0|[1-9]\d*)/

        let match = try regexp.wholeMatch(in: string)

        guard let result = match?.output else {
            throw VersionError.invalidCoreVersionFormat
        }

        let major = Int(result.major)!
        let minor = Int(result.minor)!
        let patch = Int(result.patch)!

        return CoreVersion(major: major, minor: minor, patch: patch)
    }
}
