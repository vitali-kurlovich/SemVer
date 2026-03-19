//
//  Created by Vitali Kurlovich on 19.03.26.
//

public struct VersionDetectorResult: Equatable {
    public let range: Range<String.Index>
    public let version: Version
}
