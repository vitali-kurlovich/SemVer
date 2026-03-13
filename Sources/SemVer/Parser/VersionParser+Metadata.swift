//
//  Created by Vitali Kurlovich on 13.03.26.
//

extension VersionParser {
    func parseMetadata(_ string: String) throws -> Metadata {
        let regexp = /([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*)/

        let match = try regexp.wholeMatch(in: string)

        guard let result = match?.output else {
            throw VersionError.invalidMetadataFormat
        }

        return Metadata(value: result.1)
    }
}
