//
//  Created by Vitali Kurlovich on 19.03.26.
//

import SemanticVersioning

struct VersionFormat: Hashable {
    typealias Options = VersionFormatStyle.Options

    enum FormatType: Hashable {
        case full
        case medium
        case short
        case custom
    }

    var type: FormatType = .full
    var options: Options = [.coreVersion]
}

extension VersionFormat {
    var style: VersionFormatStyle {
        switch type {
        case .full:
            return .full
        case .medium:
            return .medium
        case .short:
            return .short
        case .custom:
            return VersionFormatStyle(options: options)
        }
    }
}
