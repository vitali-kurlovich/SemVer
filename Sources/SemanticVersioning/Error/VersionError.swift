//
//  Created by Vitali Kurlovich on 13.03.26.
//

public enum VersionError: Error {
    case invalidFormat
    case invalidCoreVersionFormat
    case invalidPreReleaseFormat
    case invalidMetadataFormat
}

extension VersionError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidFormat:
            return "Invalid format"
        case .invalidCoreVersionFormat:
            return "Invalid core-version format"
        case .invalidPreReleaseFormat:
            return "Invalid pre-release format"
        case .invalidMetadataFormat:
            return "Invalid metadata format"
        }
    }
}
