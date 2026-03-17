//
//  Created by Vitali Kurlovich on 13.03.26.
//

public enum VersionError: Error {
    case invalidFormat
}

extension VersionError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidFormat:
            return "Invalid format"
        }
    }
}
