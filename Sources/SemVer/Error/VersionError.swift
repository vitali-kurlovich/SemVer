//
//  Created by Vitali Kurlovich on 13.03.26.
//

public enum VersionError: Error {
    case invalidFormat
    case invalidCoreVersionFormat
    case invalidPreReleaseFormat
    case invalidMetadataFormat
}
