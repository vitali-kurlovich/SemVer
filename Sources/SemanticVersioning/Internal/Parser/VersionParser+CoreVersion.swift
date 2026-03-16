//
//  Created by Vitali Kurlovich on 13.03.26.
//

extension VersionParser {
    func parseCoreVersion(_ string: String) throws(VersionError) -> CoreVersion {
        let regexp = /^(?P<major>0|[1-9]\d*)\.(?P<minor>0|[1-9]\d*)\.(?P<patch>0|[1-9]\d*)/

        do {
            let match = try regexp.wholeMatch(in: string)

            guard let result = match?.output else {
                throw VersionError.invalidCoreVersionFormat
            }

            let major = UInt64(result.major)!
            let minor = UInt64(result.minor)!
            let patch = UInt64(result.patch)!

            return CoreVersion(major: major, minor: minor, patch: patch)
        } catch {
            throw VersionError.invalidFormat
        }
    }
}
