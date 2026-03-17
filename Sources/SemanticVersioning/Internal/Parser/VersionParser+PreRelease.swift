//
//  Created by Vitali Kurlovich on 13.03.26.
//

extension VersionParser {
    func parsePreRelease(_ string: String) throws(VersionError) -> PreRelease {
        let regexp = /((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*)/
        do {
            let match = try regexp.wholeMatch(in: string)

            guard let result = match?.output else {
                throw VersionError.invalidFormat
            }

            return PreRelease(value: result.1)
        } catch {
            throw VersionError.invalidFormat
        }
    }
}
